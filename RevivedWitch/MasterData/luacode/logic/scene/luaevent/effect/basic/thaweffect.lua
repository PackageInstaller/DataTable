-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/effect/basic/thaweffect.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local ThawEffect = class("ThawEffect", EffectBase)
ThawEffect.Ctor = function(self, animated)
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

ThawEffect.Run = function(self, args)
  -- function num : 0_1 , upvalues : _ENV
  local dlg = (DialogManager.GetDialog)("freezedialog")
  if dlg then
    dlg:RemoveCount(self._animated)
  end
  if (DialogManager.GetDialog)("dungeon.rockerdialog") then
    ((DialogManager.GetDialog)("dungeon.rockerdialog")):UnMute()
  end
  if (DialogManager.GetDialog)("dungeon.touchlayer") then
    ((DialogManager.GetDialog)("dungeon.touchlayer")):UnMute()
    local activeController = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
    if activeController.SetActorRunning then
      activeController:SetActorRunning(true)
    end
  end
end

return ThawEffect

