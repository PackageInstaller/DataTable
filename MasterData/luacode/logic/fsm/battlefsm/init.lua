local State = {}

function State.OnEnter(controller, lastState)
  LogInfo("BattleFSM", "Init Enter")
  DialogManager.DestroySingletonDialog("dungeon.dungeonmenudialog")
  DialogManager.DestroySingletonDialog("chat.chatmaindialog")
  DialogManager.DestroySingletonDialog("debug.gmorderdialog")
  DialogManager.DestroySingletonDialog("character.newcharacterinfodialog")
  DialogManager.DestroySingletonDialog("dungeon.dungeonskillbanner")
  DialogManager.DestroySingletonDialog("systemsetting.systemsettingdialog")
  DialogManager.DestroySingletonDialog("dungeon.dungeonconquestdialog")
  DialogManager.DestroySingletonDialog("confirmbox.secondconfirmdialog")
end

function State.Update(controller, deltaTime)
end

function State.OnExit(controller, nextState)
  LogInfo("BattleFSM", "Init Exit")
end

return State
