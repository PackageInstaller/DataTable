local State = {}

function State.OnEnter(lastState)
  LogInfo("GameFSM", "Scene20006_20009BattleLoading Enter")
  local protocol = NekoData.BehaviorManager.BM_SBattleStart:GetProtocol()
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.BossBattle)
  controller:OnSBattleStart(protocol)
  GlobalGameFSM:SetBoolean("battleLoadingEnd", true)
end

function State.Update()
end

function State.OnExit(nextState)
  LogInfo("GameFSM", "Scene20006_20009BattleLoading Exit")
  GlobalGameFSM:SetBoolean("battleLoadingEnd", false)
end

return State
