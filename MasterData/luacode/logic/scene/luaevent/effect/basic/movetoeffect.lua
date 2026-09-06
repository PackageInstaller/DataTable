local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local MoveToEffect = class("ActorMoveEffect", EffectBase)
local PathResolver = require("logic.scene.pathresolver")

function MoveToEffect:Ctor(path, velocity, x, y, followNavMesh)
  self._path = path
  self._velocity = velocity
  self._x = x
  self._y = y
  self._followNavMesh = followNavMesh
end

function MoveToEffect:Run()
  if global_var_debug and self:GetParam("pause") then
    CS.PixelNeko.LuaManager.Pause()
  end
  local object = self._object or PathResolver.Resolve(self._path)
  CS.PixelNeko.Lua.NavMeshStaticFunctions.StopWalking(object)
  CS.PixelNeko.Lua.NavMeshStaticFunctions.SetSpeed(object, self._velocity)
  if self._followNavMesh then
    CS.PixelNeko.Lua.NavMeshStaticFunctions.MoveTo(object, self._x, self._y, self._z)
  else
    CS.PixelNeko.Lua.TransformStaticFunctions.MoveTo(object, self._x * 0.4, self._y * -0.56)
  end
end

function MoveToEffect:Then(callback)
  local event = EventManager.CreateEvent()
  local trigger
  if self._z then
    trigger = TriggerManager.CreateTrigger("worldpos", event:GetID(), {
      {
        x = self._x,
        y = self._z
      }
    })
  else
    trigger = TriggerManager.CreateTrigger("gridpos", event:GetID(), {
      {
        x = self._x,
        y = self._y
      }
    })
  end
  event:AddTrigger(trigger:GetType(), trigger)
  local effect = EffectFactory.CreateCustomEffect(function()
    LuaNotificationCenter.PostNotification(Common.n_SceneEffectEnd, self, self)
  end)
  event:AddEffect(effect)
  effect = EffectFactory.CreateCustomEffect(callback)
  event:AddEffect(effect)
  EventManager.AddEvent(event)
end

return MoveToEffect
