local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local ThawEffect = class("ThawEffect", EffectBase)

function ThawEffect:Ctor(animated)
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

function ThawEffect:Run(args)
  local dlg = DialogManager.GetDialog("freezedialog")
  if dlg then
    dlg:RemoveCount(self._animated)
  end
  if DialogManager.GetDialog("dungeon.rockerdialog") then
    DialogManager.GetDialog("dungeon.rockerdialog"):UnMute()
  end
  if DialogManager.GetDialog("dungeon.touchlayer") then
    DialogManager.GetDialog("dungeon.touchlayer"):UnMute()
    local activeController = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
    if activeController.SetActorRunning then
      activeController:SetActorRunning(true)
    end
  end
end

return ThawEffect
