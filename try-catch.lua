local class = require ("middleclass")
local _container = nil

---@class exception Exception
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
local errorModule = {
    customException = nil
}

---@param fn fun(exception: any)
errorModule.catch = function(fn)
    if type(fn) == "function" and _container ~= nil then
        fn(_container)
    end
    return errorModule
end

---@param fn function
errorModule.finally = function(fn)
    if type(fn) == "function" then
        fn()
    end
end

---@param fn function
errorModule.try = function(fn)
    local status, result = pcall(fn)
    if not status then
        if errorModule.customException ~= nil then
            _container = errorModule.customException:new(result)
        else
---@diagnostic disable-next-line: undefined-field
            _container = exception:new(result)
        end
    end
    return errorModule
end

return {
    tryCatch = errorModule,
    exception = exception,
}