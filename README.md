# lua-try-catch
Simple try catch module using [middleclass](https://github.com/kikito/middleclass) by kikito

### Usage

```lua
local try = require("try-catch").try

try(function()
    error("raise error")
end)
.catch(function(ex)
    print(ex.message)
    print(ex.traceback)
end)
.finally(function ()
    print("finally do something...")
end)
```

### Customize Exception

```lua
local class = require("middleclass")
local tryCatch = require("try-catch")

---Set Custom Exception Class
local customException = class("exception", tryCatch.exceptionBase)

function customException:initialize(msg)
    self.base(msg)
    self.message = "this is customException: " .. msg
end

tryCatch.options.customException = customException
```

```lua
try(function()
    error("raise error")
end)
.catch(function(ex)
    print(ex.message) --> this is customException: example.lua:18: raise error   
end)
```

### License
MIT