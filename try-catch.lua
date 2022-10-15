local class = require ("middleclass")
local _container = nil


---@class Exception Exception
---@field message string errror message
---@field traceback string callstack
local exception = class("exception")

function exception:initialize(msg)
    self.message = msg
    self.traceback = debug.traceback and debug.traceback()
end

function exception.base(msg)
    exception.message = msg
    exception.traceback = debug.traceback and debug.traceback()
end

---ErrorHandling Class
---@class ErrorHandler 
local handler = {
    customException = nil
}

handler.setCustomException = function(c)
end

---@param fn fun(exception: Exception)
handler.catch = function(fn)
    if type(fn) == "function" and _container ~= nil then
        fn(_container)
    end
    return handler
end

---@param fn function
handler.finally = function(fn)
    if type(fn) == "function" then
        fn()
    end
end

---@param fn function
local try = function(fn)
    local status, result = pcall(fn)
    if not status then
        if handler.customException ~= nil then
            _container = handler.customException:new(result)
        else
---@diagnostic disable-next-line: undefined-field
            _container = exception:new(result)
        end
    end
    return handler
end

return {
    exceptionBase = exception,
    options = handler,
    try = try,
}