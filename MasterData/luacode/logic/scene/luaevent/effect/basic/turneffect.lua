local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local TurnEffect = class("TurnEffect", EffectBase)
local PathResolver = require("logic.scene.pathresolver")

function TurnEffect:Ctor(dir, path)
  self._dir = dir
  self._path = path
end

function TurnEffect:Destroy()
end

function TurnEffect:Run()
  local active_controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
  local object
  if self._path then
    object = PathResolver.Resolve(self._path)
  else
    object = active_controller:GetPathResolver():GetActor()
  end
  CS.PixelNeko.Lua.NavMeshStaticFunctions.SetActorOrientation(object, self._dir)
end

return TurnEffect
