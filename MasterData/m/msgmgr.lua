---@class MsgMgr
local MsgMgr = class("MsgMgr")

function MsgMgr:ctor()
    ---@type table<string, {obj:any, func:function}>
    self.msgMap = {}
end

function MsgMgr:Clear()
    self.msgMap = {}
end

function MsgMgr:regEvent(type, obj, func)  
    if not self.msgMap[type] then  
        self.msgMap[type] = {}
    else  
        for i,v in ipairs(self.msgMap[type]) do  
            if v.func == func and v.obj == obj then  
                error(string.format("duplicate add type:%s", tostring(type)))
            end
        end  
    end

    table.insert(self.msgMap[type], { obj = obj, func = func })
    return true  
end

function MsgMgr:unRegEvent(type, obj, func)
    if self.msgMap[type] then
        for i,v in ipairs(self.msgMap[type]) do
            if v.func == func and v.obj == obj then
                table.remove(self.msgMap[type], i)
                break
            end
        end
    end  
  
    return true  
end  

function MsgMgr:sendEvent(type, ...)
    if self.msgMap[type] then  
        for i,v in ipairs(self.msgMap[type]) do
            if v.obj then
                v.func(v.obj, ...)
            else
                v.func(...)
            end
        end
    end  
end

return MsgMgr