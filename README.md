# β­OpenAI CLI Docker

Docker image blueprint of OpenAI CLI (Command line interface) with all the dependencies installed (python, pip etc) that can be used to fine-tune/train a model with custom data sets. <a href="https://platform.openai.com/docs/guides/fine-tuning">OpenAI CLI Fine-Tuning Docs</a>

## π« Getting Started

### π	Configure your OpenAI API Key
``` bash
#.env.local
OPENAI_API_KEY="<YOUR_OPENAI_API_KEY>"
```


Execute the following commands in the given order:

### π¨ Build
First build the image:
``` bash
./dev-tools.sh build
```

### π Start
Then start the container:
``` bash
./dev-tools.sh start
```

### π¬ Execute
Then execute commands in the running container:
``` bash
./dev-tools.sh exec
```

### π Run
At this point you can start using openai CLI:
``` bash
openai
```

### β Stop
Finally once finished, you can stop the running container:
``` bash
./dev-tools.sh stop
```
