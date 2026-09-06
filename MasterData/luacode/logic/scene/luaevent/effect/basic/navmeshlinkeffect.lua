local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local NavMeshLinkEffect = class("NavMeshLinkEffect", EffectBase)

function NavMeshLinkEffect:Ctor(op, ...)
  self._op = op
  self._args = {
    ...
  }
end

function NavMeshLinkEffect:Run()
  local active_controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
  if self._op == "add" then
    CS.PixelNeko.Lua.NavMeshStaticFunctions.AddNavMeshLink(active_controller._sceneRef.builder, table.unpack(self._args))
  elseif self._op == "remove" then
    CS.PixelNeko.Lua.NavMeshStaticFunctions.RemoveNavMeshLink(active_controller._sceneRef.builder, table.unpack(self._args))
  end
end

return NavMeshLinkEffect
