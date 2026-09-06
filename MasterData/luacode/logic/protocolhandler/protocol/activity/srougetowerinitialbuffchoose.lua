local function p1(protocol)
  NekoData.DataManager.DM_TowerV2:OnSRougeTowerInitialBuffChoose(protocol)
  
  DialogManager.DestroySingletonDialog("towerv2.towerv2revertdialog")
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
  local candidates = NekoData.BehaviorManager.BM_TowerV2:GetInitBuffCandidates()
  if candidates and #candidates ~= 0 then
    DialogManager.CreateSingletonDialog("towerv2.towerv2buffchoosedialog"):SetData(nil, candidates, controller)
  end
end

local function p2(protocol, client)
end

return {p1, p2}
