local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local FlyToEffect = class("ObjectTeleportEffect", EffectBase)
local PathResolver = require("logic.scene.pathresolver")

function FlyToEffect:Ctor(path, x, y, followNavMesh)
  self._path = path
  self._x = x
  self._y = y
  self._followNavMesh = followNavMesh
end

function FlyToEffect:Run()
  if global_var_debug and self:GetParam("pause") then
    CS.PixelNeko.LuaManager.Pause()
  end
  local object = self._object or PathResolver.Resolve(self._path)
  if self._followNavMesh then
    CS.PixelNeko.Lua.NavMeshStaticFunctions.FlyTo(object, self._x, self._y)
  else
    CS.PixelNeko.Lua.TransformStaticFunctions.SetPosition(object, self._x * 0.4, 0, self._y * -0.56)
  end
end

return FlyToEffect
