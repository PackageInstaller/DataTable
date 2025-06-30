-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/trigger/basic/gridpos/gridpostrigger.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TriggerBase = require("logic.scene.luaevent.trigger.triggerbase")
local GridPosTrigger = class("GridPosTrigger", TriggerBase)
GridPosTrigger.Ctor = function(self, triggertype, id, eventid, poslist, oncepergrid)
  -- function num : 0_0 , upvalues : GridPosTrigger, _ENV
  ((GridPosTrigger.super).Ctor)(self, triggertype, id, eventid)
  self._points = {}
  self._points = poslist
  self._once = oncepergrid
  local areas = {}
  for _,pt in pairs(self._points) do
    areas[#areas + 1] = {ltx = pt.x, lty = pt.y, rbx = pt.x + (pt.w or 0), rby = pt.y + (pt.h or 0)}
  end
  self._points = areas
end

GridPosTrigger.IsContinuous = function(self)
  -- function num : 0_1
  return not self._once
end

GridPosTrigger.OnCheck = function(self, x, y)
  -- function num : 0_2 , upvalues : _ENV
  for _,pt in pairs(self._points) do
    if pt.ltx <= x and x <= pt.rbx and pt.lty <= y and y <= pt.rby then
      return true
    end
  end
  return false
end

GridPosTrigger.Check = function(self, ...)
  -- function num : 0_3 , upvalues : GridPosTrigger
  ((GridPosTrigger.super).Check)(self, ...)
end

return GridPosTrigger

