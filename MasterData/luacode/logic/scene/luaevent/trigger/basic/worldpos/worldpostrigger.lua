local TriggerBase = require("logic.scene.luaevent.trigger.triggerbase")
local WorldPosTrigger = class("WorldPosTrigger", TriggerBase)

function WorldPosTrigger:Ctor(triggertype, id, eventid, poslist)
  WorldPosTrigger.super.Ctor(self, triggertype, id, eventid)
  self._points = poslist
end

local function eq(lhs, rhs)
  return math.floor(lhs * 1000 + 0.5) == math.floor(rhs * 1000 + 0.5)
end

local function le(lhs, rhs)
  return math.floor(lhs * 1000 + 0.5) <= math.floor(rhs * 1000 + 0.5) or tostring(lhs) == tostring(rhs)
end

function WorldPosTrigger:OnCheck(x, y)
  for _, pt in pairs(self._points) do
    local ltx = pt.x
    local lty = pt.y
    local rbx = ltx + (pt.w or 0)
    local rby = lty + (pt.h or 0)
    if le(ltx, x) and le(x, rbx) and le(lty, y) and le(y, rby) then
      return true
    end
  end
  return false
end

return WorldPosTrigger
