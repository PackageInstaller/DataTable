-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/effect/basic/navmeshlinkeffect.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local NavMeshLinkEffect = class("NavMeshLinkEffect", EffectBase)
NavMeshLinkEffect.Ctor = function(self, op, ...)
  -- function num : 0_0
  self._op = op
  self._args = {...}
end

NavMeshLinkEffect.Run = function(self)
  -- function num : 0_1 , upvalues : _ENV
  local active_controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
  if self._op == "add" then
    ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).AddNavMeshLink)((active_controller._sceneRef).builder, (table.unpack)(self._args))
  else
    if self._op == "remove" then
      ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).RemoveNavMeshLink)((active_controller._sceneRef).builder, (table.unpack)(self._args))
    end
  end
end

return NavMeshLinkEffect

