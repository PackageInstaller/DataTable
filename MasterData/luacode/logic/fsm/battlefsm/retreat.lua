local State = {}
local dialogKey = 0
local battleFSM
local CBattleStartProtocol = require("protocols.def.protocol.battle.cbattlestart")

function State.OnEnter(controller, lastState)
  LogInfo("BattleFSM", "Retreat Enter")
  LuaNotificationCenter.RemoveObserver(State)
  LuaAudioManager.PlayBGM(137)
  if NekoData.BehaviorManager.BM_SBattleStart:GetBattleType() == CBattleStartProtocol.TEST then
    GlobalGameFSM:SetNumber("battleId", 0)
    return
  end
  if NekoData.BehaviorManager.BM_Battle:GetBattleId() == 1122 then
    controller._bsc_battleFSM:SetBoolean("retreatEnd", true)
    return
  end
  local losedialog = DialogManager.CreateSingletonDialog("battle.battleaccount.battlelosetextdialog")
  if losedialog then
    LuaNotificationCenter.AddObserver(State, State.OnDialogDestroy, Common.n_DialogWillDestroy, nil)
    dialogKey = losedialog._dialogKey
    battleFSM = controller._bsc_battleFSM
  else
    controller._bsc_battleFSM:SetBoolean("retreatEnd", true)
  end
end

function State.Update(controller, deltaTime)
end

function State.OnExit(controller, nextState)
  LogInfo("BattleFSM", "Retreat Exit")
  LuaNotificationCenter.RemoveObserver(State)
  battleFSM = nil
  controller._bsc_battleFSM:SetBoolean("retreatEnd", false)
end

function State:OnDialogDestroy(notification)
  if notification.userInfo._dialogKey == dialogKey then
    battleFSM:SetBoolean("retreatEnd", true)
  end
end

return State
