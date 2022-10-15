local class = require("middleclass")
local module = require("try-catch")

local try = module.tryCatch.try

---Set Custom Exception Class
local customException = class("exception", module.exception)

function customException:initialize(msg)
    self.base(msg)
    self.message = "this is customException: " .. msg
end

module.tryCatch.customException = customException

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