# ghostmail
api for ghostmail android app for getting temporary email
# Example
```nim
import asyncdispatch, ghostmail, json
let email = waitFor get_emails()
echo email["email"].getStr()
```

# Launch (your script)
```
nim c -d:ssl -r  your_app.nim
```
