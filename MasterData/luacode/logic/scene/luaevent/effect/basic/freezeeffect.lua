local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local FreezeEffect = class("FreezeEffect", EffectBase)

function FreezeEffect:Ctor(animated)
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

function FreezeEffect:Run(args)
  DialogManager.CreateSingletonDialog("freezedialog"):AddCount(self._animated)
  if DialogManager.GetDialog("dungeon.rockerdialog") then
    DialogManager.GetDialog("dungeon.rockerdialog"):Mute()
  end
  if DialogManager.GetDialog("dungeon.touchlayer") then
    DialogManager.GetDialog("dungeon.touchlayer"):Mute()
  end
  local activeController = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
  if activeController and activeController.StopWalking then
    activeController:StopWalking()
  end
  DialogManager.DestroySingletonDialog("dungeon.hint.dungeonhintdialog")
end

return FreezeEffect
