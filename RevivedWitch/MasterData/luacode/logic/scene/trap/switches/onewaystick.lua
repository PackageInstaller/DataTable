-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/trap/switches/onewaystick.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Switch = require("logic.scene.trap.switch")
local OneWayStick = class("OneWayStick", Switch)
local Future = require("logic.scene.luaevent.effect.future")
OneWayStick.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : OneWayStick
  ((OneWayStick.super).Ctor)(self, ...)
end

OneWayStick.Activate = function(self)
  -- function num : 0_1
  self:BuildStateEffects()
  self:BuildSceneObject()
end

OneWayStick.Deactivate = function(self)
  -- function num : 0_2 , upvalues : OneWayStick
  ((OneWayStick.super).Deactivate)(self)
end

OneWayStick.ToNextState = function(self)
  -- function num : 0_3 , upvalues : Future, OneWayStick
  if self._state == 1 then
    return (Future.NoOp)()
  end
  return ((OneWayStick.super).ToNextState)(self)
end

return OneWayStick

