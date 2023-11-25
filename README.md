# shell-scripting

This is a repository created to host all the automation related to Roboshop starting from bascis to advanced.
All the coding standards are close to best coding standards followed by all the major openSource companies.

In this repo, we start everything from bascis and follows sequential order.

```
Shell is native to linux and had better native advantage with better performance.
```

# Exception Handling Operators : 

```
&&  :  Second command will be executed only if the first command is TRUE or a pass

        ex : df -h && uptime             : First command is true, second command will be executed
             df -asdfasf  && uptime      : first command is false, second command will not be executed

||  :  Second command will only be executed if the first command is false or a failued

        ex : df -h || uptime             : First command is true, second command will not be executed
             df -asdfasf  | uptime      : first command is false, second command will be executed

```