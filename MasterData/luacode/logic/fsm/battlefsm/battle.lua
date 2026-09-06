local State = {}

function State.OnEnter(controller, lastState)
  LogInfo("BattleFSM", "Battle Enter")
  local cbattleEndInfo = NekoData.BehaviorManager.BM_Login:GetCBattleEndInfo()
  local flag = NekoData.BehaviorManager.BM_Login:IfCanUseLocalCBattleEnd(NekoData.BehaviorManager.BM_SBattleStart:GetProtocol())
  if flag then
    cbattleEndInfo.super._mainClient = LuaNetManager.GetMainConnect()
    cbattleEndInfo:Send(true)
  end
end

function State.Update(controller, deltaTime)
  controller:BSC_UpdateBattleLogic(deltaTime)
end

function State.OnExit(controller, nextState)
  LogInfo("BattleFSM", "Battle Exit")
  local pauseState = controller._bsc_battleFSM:GetParameter("pasue")
  if not pauseState then
    controller:BSC_BattleLogicEnd()
    LuaNotificationCenter.PostNotification(Common.n_BattleEnd, LuaNotificationCenter, {
      battleId = controller._bsc_battleStartProtocol.battleid
    })
    GlobalGameFSM:SetBoolean("toBreakOrReconnect", true)
  end
end

return State
