local TaskUIHandler = {}

function TaskUIHandler:Handle()
  if not NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Gacha) then
    return
  end
  local sceneController = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.Base)
  local csend = LuaNetManager.CreateProtocol("protocol.card.crefreshcardui")
  csend:Send()
  local dialog = DialogManager.CreateSingletonDialog("gacha.gachamaindialog")
  if dialog then
    dialog:Init(sceneController)
  end
end

return TaskUIHandler
