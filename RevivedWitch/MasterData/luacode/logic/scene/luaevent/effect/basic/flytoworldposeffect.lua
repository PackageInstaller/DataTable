-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/effect/basic/flytoworldposeffect.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local FlyToWorldPosEffect = class("ObjectTeleportNavMeshEffect", EffectBase)
local PathResolver = require("logic.scene.pathresolver")
FlyToWorldPosEffect.Ctor = function(self, path, x, y, z, followNavMesh)
  -- function num : 0_0
  self._path = path
  self._x = x
  self._y = y
  self._z = z
  self._followNavMesh = followNavMesh
end

FlyToWorldPosEffect.Run = function(self)
  -- function num : 0_1 , upvalues : _ENV, PathResolver
  if global_var_debug and self:GetParam("pause") then
    (((CS.PixelNeko).LuaManager).Pause)()
  end
  if not self._object then
    local object = (PathResolver.Resolve)(self._path)
  end
  if self._followNavMesh then
    ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).FlyToWorldPos)(object, self._x, self._y, self._z)
  else
    ;
    ((((CS.PixelNeko).Lua).TransformStaticFunctions).SetPosition)(object, self._x, self._y, self._z)
  end
end

return FlyToWorldPosEffect

