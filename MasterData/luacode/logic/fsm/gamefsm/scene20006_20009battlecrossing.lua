local State = {}

function State.OnEnter(lastState)
  LogInfo("GameFSM", "Scene20006_20009BattleCrossing Enter")
  NekoData.DataManager.DM_Battle:Clear()
  GlobalGameFSM:SetBoolean("crossingEnd", true)
end

function State.Update()
end

function State.OnExit(nextState)
  LogInfo("GameFSM", "Scene20006_20009BattleCrossing Exit")
  local id = NekoData.BehaviorManager.BM_SBattleEnd:GetID()
  local battleid = NekoData.BehaviorManager.BM_SBattleEnd:GetBattleId()
  local result = NekoData.BehaviorManager.BM_SBattleEnd:GetBattleResult()
  LuaNotificationCenter.PostNotification(Common.n_BattleRewardEnd, LuaNotificationCenter, {
    id = id,
    battleId = battleid,
    battleResult = result
  })
  GlobalGameFSM:SetBoolean("crossingEnd", false)
end

return State
