-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/effect/basic/speedchangeeffect.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local SpeedChangeEffect = class("ActorSpeedChangeEffect", EffectBase)
local PathResolver = require("logic.scene.pathresolver")
SpeedChangeEffect.Ctor = function(self, path, speed)
  -- function num : 0_0
  self._path = path
  self._speed = speed
end

SpeedChangeEffect.Run = function(self)
  -- function num : 0_1 , upvalues : PathResolver, _ENV
  if not self._object then
    local object = (PathResolver.Resolve)(self._path)
  end
  ;
  ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).SetSpeed)(object, self._speed)
end

return SpeedChangeEffect

