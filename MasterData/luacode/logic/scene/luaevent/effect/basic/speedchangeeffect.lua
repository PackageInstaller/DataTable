local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local SpeedChangeEffect = class("ActorSpeedChangeEffect", EffectBase)
local PathResolver = require("logic.scene.pathresolver")

function SpeedChangeEffect:Ctor(path, speed)
  self._path = path
  self._speed = speed
end

function SpeedChangeEffect:Run()
  local object = self._object or PathResolver.Resolve(self._path)
  CS.PixelNeko.Lua.NavMeshStaticFunctions.SetSpeed(object, self._speed)
end

return SpeedChangeEffect
