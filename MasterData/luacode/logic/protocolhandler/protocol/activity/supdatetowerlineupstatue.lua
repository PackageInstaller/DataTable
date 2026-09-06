local function p1(protocol)
  NekoData.DataManager.DM_TowerV2:OnSUpdateTowerLineupStatue(protocol)
  
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
  if not controller then
    local dialog = DialogManager.CreateSingletonDialog("teamedit.towerv2teameditdialog")
    dialog:GoTowerBattle()
  end
end

local function p2(protocol, client)
end

return {p1, p2}
