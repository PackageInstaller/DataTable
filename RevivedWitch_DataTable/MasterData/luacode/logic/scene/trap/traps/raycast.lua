-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/trap/traps/raycast.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Trap = require("logic.scene.trap.trap")
local Raycast = class("Raycast", Trap)
local Future = require("logic.scene.luaevent.effect.future")
Raycast.Activate = function(self)
  -- function num : 0_0
  self:BuildStateEffects()
end

Raycast.ToNextState = function(self)
  -- function num : 0_1 , upvalues : Raycast, Future
  if self._state == 0 then
    return ((Raycast.super).ToNextState)(self)
  end
  return (Future.NoOp)()
end

return Raycast

