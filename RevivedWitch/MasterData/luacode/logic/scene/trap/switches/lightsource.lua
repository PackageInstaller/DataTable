-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/trap/switches/lightsource.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Switch = require("logic.scene.trap.switch")
local LightSource = class("LightSource", Switch)
local Future = require("logic.scene.luaevent.effect.future")
local StaticEvent = require("logic.scene.luaevent.event.staticevent")
LightSource.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : LightSource
  ((LightSource.super).Ctor)(self, ...)
end

LightSource.Activate = function(self)
  -- function num : 0_1
  self:BuildStateEffects()
end

LightSource.ToNextState = function(self)
  -- function num : 0_2 , upvalues : Future
  if self._state == 0 then
    self._state = 1
    return self:OnStateChange()
  end
  return (Future.NoOp)()
end

LightSource.CheckState = function(self)
  -- function num : 0_3 , upvalues : _ENV, Future
  local succ = self:CheckMirrors()
  if succ then
    if not ((self._lights)[succ]).effect then
      local effect = (EffectFactory.CreateTrapStateChangeEffect)({(self._traps)[succ]}, nil, "seq")
    end
    local future = (Future.Create)(effect)
    return future
  end
  do
    return (Future.NoOp)()
  end
end

LightSource.OnStateChange = function(self)
  -- function num : 0_4 , upvalues : LightSource, _ENV, Future
  (((LightSource.super).OnStateChange)(self)):Run()
  local succ = self:CheckMirrors()
  if succ then
    if not ((self._lights)[succ]).effect then
      local effect = (EffectFactory.CreateTrapStateChangeEffect)({(self._traps)[succ]}, nil, "seq")
    end
    local future = (Future.Create)(effect)
    return future
  end
  do
    return (Future.NoOp)()
  end
end

LightSource.CheckMirrorState = function(self, routeid, mirror)
  -- function num : 0_5 , upvalues : _ENV
  local id = mirror:GetID()
  for i,v in ipairs((self._lights)[routeid]) do
    if v.id == id then
      if not v.state then
        LogError("lightsource", routeid .. " " .. v.id)
        dump(self._lights)
      end
      return v.state == mirror:GetLightState()
    end
  end
  assert(false, (debug.traceback)())
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

LightSource.CheckMirrors = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local succ = nil
  for routeid,route in ipairs(self._lights) do
    local found = self._state == 1
    for _,v in ipairs(route) do
      local mirror = (SwitchManager.GetSwitch)(self._instanceid, v.id)
      mirror:ShowLight(found)
      if found then
        found = self:CheckMirrorState(routeid, mirror)
      end
    end
    if found then
      succ = routeid
    end
  end
  if succ then
    do
      if self._instanceid == 9 then
        local jsonStr = (JSON.encode)({eventName = "6"})
        ;
        (ThinkingAnalyticsInterface.SetUserPropertiesOnce_TA)(jsonStr)
      end
      do
        if self._instanceid == 10 then
          local jsonStr = (JSON.encode)({eventName = "7"})
          ;
          (ThinkingAnalyticsInterface.SetUserPropertiesOnce_TA)(jsonStr)
        end
        do return succ end
        -- DECOMPILER ERROR: 5 unprocessed JMP targets
      end
    end
  end
end

LightSource.SetStateInfo = function(self, info)
  -- function num : 0_7 , upvalues : _ENV, StaticEvent
  self._lights = info
  for _,v in pairs(self._lights) do
    if v.effectid ~= 0 then
      v.effect = (StaticEvent.CreateSwitchEffect)(v.effectid)
    end
  end
end

LightSource.SetTarget = function(self, target)
  -- function num : 0_8 , upvalues : _ENV
  self._traps = (string.split)(target, ",")
  for k,v in pairs(self._traps) do
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R7 in 'UnsetPending'

    (self._traps)[k] = {instance = self._instanceid, id = tonumber(v)}
  end
end

return LightSource

