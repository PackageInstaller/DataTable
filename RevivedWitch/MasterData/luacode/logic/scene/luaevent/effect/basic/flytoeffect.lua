-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/effect/basic/flytoeffect.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local FlyToEffect = class("ObjectTeleportEffect", EffectBase)
local PathResolver = require("logic.scene.pathresolver")
FlyToEffect.Ctor = function(self, path, x, y, followNavMesh)
  -- function num : 0_0
  self._path = path
  self._x = x
  self._y = y
  self._followNavMesh = followNavMesh
end

FlyToEffect.Run = function(self)
  -- function num : 0_1 , upvalues : _ENV, PathResolver
  if global_var_debug and self:GetParam("pause") then
    (((CS.PixelNeko).LuaManager).Pause)()
  end
  if not self._object then
    local object = (PathResolver.Resolve)(self._path)
  end
  if self._followNavMesh then
    ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).FlyTo)(object, self._x, self._y)
  else
    ;
    ((((CS.PixelNeko).Lua).TransformStaticFunctions).SetPosition)(object, self._x * 0.4, 0, self._y * -0.56)
  end
end

return FlyToEffect

