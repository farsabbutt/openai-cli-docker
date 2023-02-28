# OpenAI CLI Docker

Dockerized image of OpenAI CLI (Command line interface) with all the dependencies installed (python, pip etc) that can be used to fine-tune/train a model with custom data. <a href="https://platform.openai.com/docs/guides/fine-tuning">OpenAI CLI Fine-Tuning Docs</a>

## Getting Started

### Configure your OpenAI API Key
``` bash
#.env.local
OPENAI_API_KEY="<YOUR_OPENAI_API_KEY>"
```


Execute the following commands in the given order:

### Build image
First build the image:
``` bash
./dev-tools.sh build
```

### Start container
Then start the container:
``` bash
./dev-tools.sh start
```

### Execute commands in container
Then execute commands in the running container:
``` bash
./dev-tools.sh exec
```

### Run openai commands
At this point you can start using openai CLI:
``` bash
openai
```

### Stop container
Finally once finished, you can stop the running container:
``` bash
./dev-tools.sh stop
```