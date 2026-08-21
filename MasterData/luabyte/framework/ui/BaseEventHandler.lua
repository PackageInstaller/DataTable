local BaseEventHandler = BaseClass("BaseEventHandler")
local M = BaseEventHandler 

function M:__init()
    self._events = {}
end

function M:_Broadcast( eventName , ...) 
    EventMgr:Broadcast( eventName , ... )
end

function M:_AddListener( eventName,handler )
    if self._events == nil then
        return 
    end
    if self._events[eventName] ~= nil then 
        EventMgr:RemoveListener(eventName,self._events[eventName])
    end
    EventMgr:AddListener(eventName,handler)
    self._events[eventName] = handler
end

function M:_RemoveListener( eventName,handler )
    if self._events == nil then
        return 
    end
    if self._events[eventName] then 
        EventMgr:RemoveListener(eventName,self._events[eventName])
    end
    self._events[eventName] = nil
    EventMgr:RemoveListener(eventName,handler)
end

function M:OnDispose()
    if self._events == nil then 
        return 
    end
    for eventName ,handler in pairs(self._events) do
        EventMgr:RemoveListener(eventName,handler)
    end
    self._events = nil 
end

return BaseEventHandler 