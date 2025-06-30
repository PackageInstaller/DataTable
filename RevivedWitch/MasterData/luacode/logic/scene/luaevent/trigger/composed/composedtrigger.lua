-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/trigger/composed/composedtrigger.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ComposedTrigger = class("ComposedTrigger")
ComposedTrigger.Ctor = function(self, id, eventid)
  -- function num : 0_0
  self._id = id
  self._eventid = eventid
  self._root = nil
  self._triggers = nil
end

ComposedTrigger.AddTask = function(self, root)
  -- function num : 0_1
  self._root = root
end

ComposedTrigger.GetType = function(self)
  -- function num : 0_2
  return "composed"
end

ComposedTrigger.Destroy = function(self)
  -- function num : 0_3
  (self._root):Destroy()
end

ComposedTrigger.Check = function(self)
  -- function num : 0_4
  return self:OnCheck()
end

ComposedTrigger.OnCheck = function(self)
  -- function num : 0_5
  local type = (self._root):GetType()
  if type == "composed" or type == "operator" then
    return (self._root):Check()
  else
    return (self._root):GetState()
  end
end

ComposedTrigger.IsActive = function(self)
  -- function num : 0_6
  return self:Check()
end

ComposedTrigger.Activate = function(self)
  -- function num : 0_7
  (self._root):Activate()
end

ComposedTrigger.Reset = function(self)
  -- function num : 0_8
  (self._root):Reset()
end

return ComposedTrigger

