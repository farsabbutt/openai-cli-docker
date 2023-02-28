#!/bin/bash
set -e
# targets
#=========================================
allowed_targets=(
  'build'
  'start'
  'exec'
  'stop'
)
script_name="$(cd $(dirname "$0"); pwd -P)/$(basename "$0")"
script_dir="$(dirname "$script_name")"
# @internal, this must be called before we setup the base variables
parse_env() {
  if [ ! -f "${script_dir}/.env" ]; then
    echo -e "\n\nFile ${script_dir}/.env not found, the file: ${script_dir}/.env.local will be copied for you\n\n"
    cp ${script_dir}/.env.local ${script_dir}/.env
  fi
  set -a
  . "${script_dir}/.env"
  set +a
  if [ -z "$UID" ]; then
    echo >&2
    echo "IMPORTANT: the env var UID is not set, it is important to set it inside ${script_dir}/.env" >&2
    echo >&2
  fi
}
parse_env
# base variables
#=========================================
docker_image_name=open-ai-cli-image
docker_container_name=open-ai-cli


build() {
    echo -e "Building docker image...\n"
    sh -c "docker build -t $docker_image_name ."  
}

start() {
    echo -e "Running docker container...\n"
    sh -c "docker run -d --name $docker_container_name --env-file .env open-ai-cli-image /bin/sh"  
}

exec() {
    sh -c "docker exec -ti $docker_container_name /bin/sh"
}

stop() {
  echo -e "Stopping the container \n"
  sh -c "docker rm -f $docker_container_name"
}

#=========================================
#environment specific functions
#=========================================
os_init() {
  Linux() { :; }
  MINGW() {
    docker() {
      winpty docker "$@"
    }
    docker-compose() {
      winpty docker-compose "$@"
    }
  }
  unameOut="$(uname -s)"
  case "${unameOut}" in
  Linux*)
    machine=Linux
    Linux
    ;;
  Darwin*) machine=Mac ;;
  CYGWIN*) machine=Cygwin ;;
  MINGW*)
    machine=MinGw
    MINGW
    ;;
  *) machine="UNKNOWN:${unameOut}" ;;
  esac
}
help() {
  base64 -d <<<"H4sIAAAAAAAAA1OQjjawNrQ2NrG2NMl9tLD90aIdQJFcBRThxf2PFnZiCi9sB4uhCfY9WjARi9q+
R4s2woWNQSLbHy3ahyKCsEYBLrZo56MFjaj6YCZxodqwYP6jBbsxLV6w/NGCJdiEYeYhyYK5ix8t
mIIhMgdVpP3Rgh2oInBboE43z4UpQfBh5nABAMeKRB91AQAA" | gunzip
  base64 -d <<<"ICAvIF9fIFwgfCAgX18gXCB8ICBfX19ffHwgXCB8IHwgICAgL1wgICAgfF8gICBffAogfCB8ICB8
IHx8IHxfXykgfHwgfF9fICAgfCAgXHwgfCAgIC8gIFwgICAgIHwgfCAgCiB8IHwgIHwgfHwgIF9f
Xy8gfCAgX198ICB8IC4gYCB8ICAvIC9cIFwgICAgfCB8ICAKIHwgfF9ffCB8fCB8ICAgICB8IHxf
X19fIHwgfFwgIHwgLyBfX19fIFwgIF98IHxfIAogIFxfX19fLyB8X3wgICAgIHxfX19fX198fF98
IFxffC9fLyAgICBcX1x8X19fX198"
  printf "\n\n"
  echo "============================="
  printf "\n\n"
  echo "allowed targets: "
  for i in ${allowed_targets[@]}; do
    echo $i
  done
}
_main() {
  os_init "$@"
  #=========================================
  # dynamically calling exposed targets
  #=========================================
  target="$1"
  if [[ ! -z "$target" ]] && [[ "${allowed_targets[@]}" =~ "$target" ]]; then
    $target "$@"
  else
    help "$@"
  fi
}
_main "$@"