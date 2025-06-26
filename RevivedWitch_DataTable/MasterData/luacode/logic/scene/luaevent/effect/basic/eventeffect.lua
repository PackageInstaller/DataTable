-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/effect/basic/eventeffect.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local StaticEvent = require("logic.scene.luaevent.event.staticevent")
local EventEffect = class("EventEffect", EffectBase)
EventEffect.Ctor = function(self, eventid)
  -- function num : 0_0
  self._eventid = eventid
  self._triggered = false
end

EventEffect.Destroy = function(self)
  -- function num : 0_1
  if self._event and not self._triggered then
    (self._event):Destroy()
    self._event = nil
  end
end

EventEffect.Run = function(self, args)
  -- function num : 0_2 , upvalues : _ENV
  if global_var_debug and self:GetParam("pause") then
    (((CS.PixelNeko).LuaManager).Pause)()
  end
  local event = (EventManager.RemoveByConfigID)(self._eventid)
  if event then
    event:Fire(args)
  end
  self._triggered = true
end

return EventEffect

