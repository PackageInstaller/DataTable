local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local FlyToWorldPosEffect = class("ObjectTeleportNavMeshEffect", EffectBase)
local PathResolver = require("logic.scene.pathresolver")

function FlyToWorldPosEffect:Ctor(path, x, y, z, followNavMesh)
  self._path = path
  self._x = x
  self._y = y
  self._z = z
  self._followNavMesh = followNavMesh
end

function FlyToWorldPosEffect:Run()
  if global_var_debug and self:GetParam("pause") then
    CS.PixelNeko.LuaManager.Pause()
  end
  local object = self._object or PathResolver.Resolve(self._path)
  if self._followNavMesh then
    CS.PixelNeko.Lua.NavMeshStaticFunctions.FlyToWorldPos(object, self._x, self._y, self._z)
  else
    CS.PixelNeko.Lua.TransformStaticFunctions.SetPosition(object, self._x, self._y, self._z)
  end
end

return FlyToWorldPosEffect
