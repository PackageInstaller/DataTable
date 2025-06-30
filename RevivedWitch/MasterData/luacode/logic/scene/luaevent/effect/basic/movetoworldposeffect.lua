-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/effect/basic/movetoworldposeffect.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local MoveToWorldPosEffect = class("ObjectMoveEffect", EffectBase)
local PathResolver = require("logic.scene.pathresolver")
MoveToWorldPosEffect.Ctor = function(self, path, velocity, x, y, z, followNavMesh)
  -- function num : 0_0
  self._path = path
  self._velocity = velocity
  self._x = x
  self._y = y
  self._z = z
  self._followNavMesh = followNavMesh
end

MoveToWorldPosEffect.Bind = function(self, object)
  -- function num : 0_1
  self._object = object
end

MoveToWorldPosEffect.Run = function(self)
  -- function num : 0_2 , upvalues : _ENV, PathResolver
  if global_var_debug and self:GetParam("pause") then
    (((CS.PixelNeko).LuaManager).Pause)()
  end
  if not self._object then
    local object = (PathResolver.Resolve)(self._path)
  end
  if self._followNavMesh then
    ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).StopWalking)(object)
    ;
    ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).SetSpeed)(object, self._velocity)
    ;
    ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).MoveToWorldPos)(object, self._x, self._y, self._z)
    self._destx = ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).GetDestination)(object)
  else
    ;
    ((((CS.PixelNeko).Lua).TransformStaticFunctions).SetSpeed)(object, self._velocity)
    ;
    ((((CS.PixelNeko).Lua).TransformStaticFunctions).MoveToWorldPos)(object, self._x, self._y, self._z)
  end
end

MoveToWorldPosEffect.Then = function(self, callback)
  -- function num : 0_3 , upvalues : _ENV
  local event = (EventManager.CreateEvent)()
  local trigger = (TriggerManager.CreateTrigger)("worldpos", event:GetID(), {
{x = self._x, y = self._z}
})
  event:AddTrigger(trigger:GetType(), trigger)
  local effect = (EffectFactory.CreateCustomEffect)(callback)
  event:AddEffect(effect)
  effect = (EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_3_0 , upvalues : _ENV, self
    (LuaNotificationCenter.PostNotification)(Common.n_SceneEffectEnd, self, self)
  end
)
  event:AddEffect(effect)
  ;
  (EventManager.AddEvent)(event)
end

return MoveToWorldPosEffect

