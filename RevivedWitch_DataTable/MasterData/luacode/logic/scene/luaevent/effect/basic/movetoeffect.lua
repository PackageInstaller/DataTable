-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/effect/basic/movetoeffect.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local MoveToEffect = class("ActorMoveEffect", EffectBase)
local PathResolver = require("logic.scene.pathresolver")
MoveToEffect.Ctor = function(self, path, velocity, x, y, followNavMesh)
  -- function num : 0_0
  self._path = path
  self._velocity = velocity
  self._x = x
  self._y = y
  self._followNavMesh = followNavMesh
end

MoveToEffect.Run = function(self)
  -- function num : 0_1 , upvalues : _ENV, PathResolver
  if global_var_debug and self:GetParam("pause") then
    (((CS.PixelNeko).LuaManager).Pause)()
  end
  if not self._object then
    local object = (PathResolver.Resolve)(self._path)
  end
  ;
  ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).StopWalking)(object)
  ;
  ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).SetSpeed)(object, self._velocity)
  if self._followNavMesh then
    ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).MoveTo)(object, self._x, self._y, self._z)
  else
    ;
    ((((CS.PixelNeko).Lua).TransformStaticFunctions).MoveTo)(object, self._x * 0.4, self._y * -0.56)
  end
end

MoveToEffect.Then = function(self, callback)
  -- function num : 0_2 , upvalues : _ENV
  local event = ((EventManager.CreateEvent)())
  -- DECOMPILER ERROR at PC3: Overwrote pending register: R3 in 'AssignReg'

  local trigger = .end
  if self._z then
    trigger = (TriggerManager.CreateTrigger)("worldpos", event:GetID(), {
{x = self._x, y = self._z}
})
  else
    trigger = (TriggerManager.CreateTrigger)("gridpos", event:GetID(), {
{x = self._x, y = self._y}
})
  end
  event:AddTrigger(trigger:GetType(), trigger)
  local effect = (EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_2_0 , upvalues : _ENV, self
    (LuaNotificationCenter.PostNotification)(Common.n_SceneEffectEnd, self, self)
  end
)
  event:AddEffect(effect)
  effect = (EffectFactory.CreateCustomEffect)(callback)
  event:AddEffect(effect)
  ;
  (EventManager.AddEvent)(event)
end

return MoveToEffect

