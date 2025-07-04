---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by daiyi.
--- DateTime: 2019/4/9 15:49
---
local Component = BaseClass("Component", Updatable)

local function __init(self,entity,...)
    self.is_disposed = false
    self.__entity = entity
    self:Awake(...)
end

local function Awake(self)
    --print("<color=green>[Component] "..self._class_type.__cname.." Awake</color>")
end

local function Dispose(self)
    if(self.is_disposed) then
        return
    end

    --print("<color=yellow>[Component] "..self._class_type.__cname.." Dispose</color>")

    self:EnableUpdate(false)
    
    self.is_disposed = true
end

local function GetEntity(self)
    return self.__entity
end

local function __delete(self)
    self:Dispose()
end

Component.__init = __init
Component.__delete = __delete
Component.Awake = Awake
Component.GetEntity = GetEntity
Component.Dispose = Dispose

return Component