local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local StaticEvent = require("logic.scene.luaevent.event.staticevent")
local AddEventEffect = class("EventEffect", EffectBase)

function AddEventEffect:Ctor(eventid)
  self._eventid = eventid
  self._triggered = false
end

function AddEventEffect:Destroy()
  if self._event and not self._triggered then
    self._event:Destroy()
    self._event = nil
  end
end

function AddEventEffect:Run()
  if global_var_debug and self:GetParam("pause") then
    CS.PixelNeko.LuaManager.Pause()
  end
  self._event = StaticEvent.CreateFromConfig(self._eventid)
  EventManager.AddEvent(self._event)
  self._triggered = true
end

return AddEventEffect
