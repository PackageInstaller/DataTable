-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/trap/switches/mirror.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Switch = require("logic.scene.trap.switch")
local Mirror = class("Mirror", Switch)
local StaticEvent = require("logic.scene.luaevent.event.staticevent")
Mirror.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : Mirror
  ((Mirror.super).Ctor)(self, ...)
end

Mirror.BuildStateEffects = function(self)
  -- function num : 0_1 , upvalues : Mirror
  ((Mirror.super).BuildStateEffects)(self)
end

Mirror.SetStateInfo = function(self, info)
  -- function num : 0_2 , upvalues : _ENV, StaticEvent
  self._lightEffects = {}
  for state,effectid in pairs(info) do
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R7 in 'UnsetPending'

    (self._lightEffects)[state] = (StaticEvent.CreateSwitchEffect)(effectid)
  end
end

Mirror.Activate = function(self)
  -- function num : 0_3
  self:BuildStateEffects()
  self:BuildSceneObject()
end

Mirror.ShowLight = function(self, has_income)
  -- function num : 0_4
  if not self._state then
    return 
  end
  if has_income then
    ((self._lightEffects)[self._state + 1]):Run()
    self._lightState = self._state + 1
  else
    ;
    ((self._lightEffects)[0]):Run()
    self._lightState = 0
  end
end

Mirror.GetLightState = function(self)
  -- function num : 0_5
  return self._lightState or 0
end

return Mirror

