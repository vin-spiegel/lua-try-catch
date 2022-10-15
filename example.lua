local class = require("middleclass")
local tryCatch = require("try-catch")

local try = tryCatch.try

---Set Custom Exception Class
local customException = class("customException", tryCatch.exceptionBase)

function customException:initialize(msg)
    self.base(msg)
    self.message = "this is customException: " .. msg
end

tryCatch.options.customException = customException

try(function()
    error("raise error")
end)
.catch(function(ex)
    print(ex.message)
    -- print(ex.traceback)
end)
.finally(function ()
    print("finally do something...")
end)