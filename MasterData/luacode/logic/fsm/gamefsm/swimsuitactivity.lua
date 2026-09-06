local State = {}

function State.OnEnter(lastState)
  LogInfo("GameFSM", "SwimSuitActivity Enter")
  DialogManager.DestroySingletonDialog("base.hidemaincitymodaldialog")
  DialogManager.DestroySingletonDialog("loadingdialog")
  if NekoData.BehaviorManager.BM_Game:GetAutoExploreWithoutBackAwards() then
    DialogManager.CreateSingletonDialog("activity.swimsuit.swimsuitaccountdialog")
  end
end

function State.Update()
end

function State.OnExit(nextState)
  LogInfo("GameFSM", "SwimSuitActivity Exit")
end

return State
