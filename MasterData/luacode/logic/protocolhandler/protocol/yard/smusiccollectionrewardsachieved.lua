local CAudioPlayerCell = BeanManager.GetTableByName("courtyard.caudioplayercell")

local function p1(protocol)
  NekoData.DataManager.DM_YardMusic:OnSMusicCollectionRewardsAchieved(protocol)
  local dialog = DialogManager.GetDialog("yardmusic.rewarddialog")
  if dialog then
    dialog:Init()
  end
  dialog = DialogManager.GetDialog("yardmusic.yardmusicdialog")
  if dialog then
    dialog:RefreshCollectBtnRedDot()
  end
  LuaNotificationCenter.PostNotification(Common.n_BuildingGetNumChanged, nil, {
    buildingId = DataCommon.YardMusic,
    state = NekoData.BehaviorManager.BM_YardMusic:GetGetNum()
  })
end

local function p2(protocol, client)
end

return {p1, p2}
