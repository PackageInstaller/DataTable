-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/effect/basic/freezeeffect.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local FreezeEffect = class("FreezeEffect", EffectBase)
FreezeEffect.Ctor = function(self, animated)
  -- function num : 0_0 , upvalues : _ENV
  if not animated then
    self._animated = false
  else
    local str = tostring(animated)
    if str == "false" or str == "0" or str == "" then
      self._animated = false
    else
      self._animated = true
    end
  end
end

FreezeEffect.Run = function(self, args)
  -- function num : 0_1 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("freezedialog")):AddCount(self._animated)
  if (DialogManager.GetDialog)("dungeon.rockerdialog") then
    ((DialogManager.GetDialog)("dungeon.rockerdialog")):Mute()
  end
  if (DialogManager.GetDialog)("dungeon.touchlayer") then
    ((DialogManager.GetDialog)("dungeon.touchlayer")):Mute()
  end
  local activeController = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
  if activeController.StopWalking then
    activeController:StopWalking()
  end
  ;
  (DialogManager.DestroySingletonDialog)("dungeon.hint.dungeonhintdialog")
end

return FreezeEffect

