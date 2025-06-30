-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/effect/basic/turneffect.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local TurnEffect = class("TurnEffect", EffectBase)
local PathResolver = require("logic.scene.pathresolver")
TurnEffect.Ctor = function(self, dir, path)
  -- function num : 0_0
  self._dir = dir
  self._path = path
end

TurnEffect.Destroy = function(self)
  -- function num : 0_1
end

TurnEffect.Run = function(self)
  -- function num : 0_2 , upvalues : _ENV, PathResolver
  ((SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon))
  local active_controller = nil
  local object = nil
  if self._path then
    object = (PathResolver.Resolve)(self._path)
  else
    object = (active_controller:GetPathResolver()):GetActor()
  end
  ;
  ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).SetActorOrientation)(object, self._dir)
end

return TurnEffect

