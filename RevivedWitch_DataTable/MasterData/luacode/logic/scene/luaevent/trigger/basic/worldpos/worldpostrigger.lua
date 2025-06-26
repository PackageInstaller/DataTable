-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/trigger/basic/worldpos/worldpostrigger.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TriggerBase = require("logic.scene.luaevent.trigger.triggerbase")
local WorldPosTrigger = class("WorldPosTrigger", TriggerBase)
WorldPosTrigger.Ctor = function(self, triggertype, id, eventid, poslist)
  -- function num : 0_0 , upvalues : WorldPosTrigger
  ((WorldPosTrigger.super).Ctor)(self, triggertype, id, eventid)
  self._points = poslist
end

local eq = function(lhs, rhs)
  -- function num : 0_1 , upvalues : _ENV
  do return (math.floor)(lhs * 1000 + 0.5) == (math.floor)(rhs * 1000 + 0.5) end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

local le = function(lhs, rhs)
  -- function num : 0_2 , upvalues : _ENV
  do return (math.floor)(lhs * 1000 + 0.5) <= (math.floor)(rhs * 1000 + 0.5) or tostring(lhs) == tostring(rhs) end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

WorldPosTrigger.OnCheck = function(self, x, y)
  -- function num : 0_3 , upvalues : _ENV, le
  for _,pt in pairs(self._points) do
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

