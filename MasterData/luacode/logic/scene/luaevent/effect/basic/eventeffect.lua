local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local StaticEvent = require("logic.scene.luaevent.event.staticevent")
local EventEffect = class("EventEffect", EffectBase)

function EventEffect:Ctor(eventid)
  self._eventid = eventid
  self._triggered = false
end

function EventEffect:Destroy()
  if self._event and not self._triggered then
    self._event:Destroy()
    self._event = nil
  end
end

function EventEffect:Run(args)
  if global_var_debug and self:GetParam("pause") then
    CS.PixelNeko.LuaManager.Pause()
  end
  local event = EventManager.RemoveByConfigID(self._eventid)
  if event then
    event:Fire(args)
  end
  self._triggered = true
end

return EventEffect
