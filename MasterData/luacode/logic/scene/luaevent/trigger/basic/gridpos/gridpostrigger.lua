local TriggerBase = require("logic.scene.luaevent.trigger.triggerbase")
local GridPosTrigger = class("GridPosTrigger", TriggerBase)

function GridPosTrigger:Ctor(triggertype, id, eventid, poslist, oncepergrid)
  GridPosTrigger.super.Ctor(self, triggertype, id, eventid)
  self._points = {}
  self._points = poslist
  self._once = oncepergrid
  local areas = {}
  for _, pt in pairs(self._points) do
    areas[#areas + 1] = {
      ltx = pt.x,
      lty = pt.y,
      rbx = pt.x + (pt.w or 0),
      rby = pt.y + (pt.h or 0)
    }
  end
  self._points = areas
end

function GridPosTrigger:IsContinuous()
  return not self._once
end

function GridPosTrigger:OnCheck(x, y)
  for _, pt in pairs(self._points) do
    if x >= pt.ltx and x <= pt.rbx and y >= pt.lty and y <= pt.rby then
      return true
    end
  end
  return false
end

function GridPosTrigger:Check(...)
  GridPosTrigger.super.Check(self, ...)
end

return GridPosTrigger
