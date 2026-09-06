local Switch = require("logic.scene.trap.switch")
local LightSource = class("LightSource", Switch)
local Future = require("logic.scene.luaevent.effect.future")
local StaticEvent = require("logic.scene.luaevent.event.staticevent")

function LightSource:Ctor(...)
  LightSource.super.Ctor(self, ...)
end

function LightSource:Activate()
  self:BuildStateEffects()
end

function LightSource:ToNextState()
  if self._state == 0 then
    self._state = 1
    return self:OnStateChange()
  end
  return Future.NoOp()
end

function LightSource:CheckState()
  local succ = self:CheckMirrors()
  if succ then
    local effect = self._lights[succ].effect or EffectFactory.CreateTrapStateChangeEffect({
      self._traps[succ]
    }, nil, "seq")
    local future = Future.Create(effect)
    return future
  end
  return Future.NoOp()
end

function LightSource:OnStateChange()
  LightSource.super.OnStateChange(self):Run()
  local succ = self:CheckMirrors()
  if succ then
    local effect = self._lights[succ].effect or EffectFactory.CreateTrapStateChangeEffect({
      self._traps[succ]
    }, nil, "seq")
    local future = Future.Create(effect)
    return future
  end
  return Future.NoOp()
end

function LightSource:CheckMirrorState(routeid, mirror)
  local id = mirror:GetID()
  for i, v in ipairs(self._lights[routeid]) do
    if v.id == id then
      if not v.state then
        LogError("lightsource", routeid .. " " .. v.id)
        dump(self._lights)
      end
      return v.state == mirror:GetLightState()
    end
  end
  assert(false, debug.traceback())
end

function LightSource:CheckMirrors()
  local succ
  for routeid, route in ipairs(self._lights) do
    local found = self._state == 1
    for _, v in ipairs(route) do
      local mirror = SwitchManager.GetSwitch(self._instanceid, v.id)
      mirror:ShowLight(found)
      found = found and self:CheckMirrorState(routeid, mirror)
    end
    if found then
      succ = routeid
    end
  end
  if succ then
    if self._instanceid == 9 then
      local jsonStr = JSON.encode({eventName = "6"})
      ThinkingAnalyticsInterface.SetUserPropertiesOnce_TA(jsonStr)
    end
    if self._instanceid == 10 then
      local jsonStr = JSON.encode({eventName = "7"})
      ThinkingAnalyticsInterface.SetUserPropertiesOnce_TA(jsonStr)
    end
  end
  return succ
end

function LightSource:SetStateInfo(info)
  self._lights = info
  for _, v in pairs(self._lights) do
    if v.effectid ~= 0 then
      v.effect = StaticEvent.CreateSwitchEffect(v.effectid)
    end
  end
end

function LightSource:SetTarget(target)
  self._traps = string.split(target, ",")
  for k, v in pairs(self._traps) do
    self._traps[k] = {
      instance = self._instanceid,
      id = tonumber(v)
    }
  end
end

return LightSource
