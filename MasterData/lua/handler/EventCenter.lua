local EventCenter = {}

local isGaming = false
local msgCache = {}
local eventFunctions = {}

-- 注册事件
EventCenter.RegisterEvent = function(self, name, func)
    if func == nil then
        func = function()
            DataManager:GetInstance():Broadcast(name)
        end
    end
    eventFunctions[name] = func
end

-- 派发所有更新事件
-- 玩家断线的时候   服务器推送的消息可能都没接收到   重连后触发所有事件   更新界面
EventCenter.DispatcherMessages = function(self)
    table.walk(eventFunctions, function (k, func) func() end)
end

-- 派发事件
EventCenter.Dispatcher = function(self, messageName, info)
    if eventFunctions[messageName] == nil then
        Logger.LogError("***This handler need registerEvent by Init***")
    end
    DataManager:GetInstance():Broadcast(messageName, info)
end

-- 处理服务器派发的消息
EventCenter.HandleMessage = function(self, msg, func)
    if not isGaming then
        table.insert(msgCache, {msg = msg, func = func})
        return
    end
    if func then func(msg) end
end

EventCenter.OnEnterGame = function(self)
    isGaming = true
    table.walk(msgCache, function (k, val)
        if val.func then val.func(val.msg) end
    end)
    msgCache = {}
end

EventCenter.OnExitGame = function(self)
    isGaming = false
    msgCache = {}
end

return EventCenter