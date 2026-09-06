local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local MoveToWorldPosEffect = class("ObjectMoveEffect", EffectBase)
local PathResolver = require("logic.scene.pathresolver")

function MoveToWorldPosEffect:Ctor(path, velocity, x, y, z, followNavMesh)
  self._path = path
  self._velocity = velocity
  self._x = x
  self._y = y
  self._z = z
  self._followNavMesh = followNavMesh
end

function MoveToWorldPosEffect:Bind(object)
  self._object = object
end

function MoveToWorldPosEffect:Run()
  if global_var_debug and self:GetParam("pause") then
    CS.PixelNeko.LuaManager.Pause()
  end
  local object = self._object or PathResolver.Resolve(self._path)
  if self._followNavMesh then
    CS.PixelNeko.Lua.NavMeshStaticFunctions.StopWalking(object)
    CS.PixelNeko.Lua.NavMeshStaticFunctions.SetSpeed(object, self._velocity)
    CS.PixelNeko.Lua.NavMeshStaticFunctions.MoveToWorldPos(object, self._x, self._y, self._z)
    self._destx, _, self._desty = CS.PixelNeko.Lua.NavMeshStaticFunctions.GetDestination(object)
  else
    CS.PixelNeko.Lua.TransformStaticFunctions.SetSpeed(object, self._velocity)
    CS.PixelNeko.Lua.TransformStaticFunctions.MoveToWorldPos(object, self._x, self._y, self._z)
  end
end

function MoveToWorldPosEffect:Then(callback)
  local event = EventManager.CreateEvent()
  local trigger = TriggerManager.CreateTrigger("worldpos", event:GetID(), {
    {
      x = self._x,
      y = self._z
    }
  })
  event:AddTrigger(trigger:GetType(), trigger)
  local effect = EffectFactory.CreateCustomEffect(callback)
  event:AddEffect(effect)
  effect = EffectFactory.CreateCustomEffect(function()
    LuaNotificationCenter.PostNotification(Common.n_SceneEffectEnd, self, self)
  end)
  event:AddEffect(effect)
  EventManager.AddEvent(event)
end

return MoveToWorldPosEffect
