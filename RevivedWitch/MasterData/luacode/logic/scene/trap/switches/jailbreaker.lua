-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/trap/switches/jailbreaker.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Switch = require("logic.scene.trap.switch")
local JailBreaker = class("JailBreaker", Switch)
local FixedPos = require("logic.scene.trap.components.trigger.fixedpos")
JailBreaker.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : JailBreaker
  ((JailBreaker.super).Ctor)(self, ...)
end

JailBreaker.Destroy = function(self)
  -- function num : 0_1
  (self._builder):Destroy()
end

JailBreaker.Activate = function(self)
  -- function num : 0_2 , upvalues : FixedPos, _ENV
  self._builder = (FixedPos.Create)(self, self:GetEffectArea())
  self:BuildStateEffects()
  local event = (self._builder):BuildEnterEvent()
  ;
  (EventManager.AddEvent)(event)
end

JailBreaker.Deactivate = function(self)
  -- function num : 0_3 , upvalues : JailBreaker
  ((JailBreaker.super).Deactivate)(self)
end

JailBreaker.OnEnterArea = function(self)
  -- function num : 0_4
  (self:ToNextState()):Run()
end

JailBreaker.OnLeaveArea = function(self)
  -- function num : 0_5
  (self:ToNextState()):Run()
end

return JailBreaker

