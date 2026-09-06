local CAudioPlayerCell = BeanManager.GetTableByName("courtyard.caudioplayercell")

local function p1(protocol)
  local level = NekoData.BehaviorManager.BM_YardMusic:GetLevel()
  if level == 0 and 0 < protocol.music.level then
    LuaNotificationCenter.PostNotification(Common.n_BuildingUnlock, nil, {
      buildingId = DataCommon.YardMusic
    })
  end
  NekoData.DataManager.DM_YardMusic:OnSInitMusic(protocol)
  local allIds = CAudioPlayerCell:GetAllIds()
  NekoData.BehaviorManager.BM_YardMusic:SetPlayingId(allIds[1])
  DialogManager.CreateSingletonDialog("yardmusic.playingmusicdialog")
  LuaNotificationCenter.PostNotification(Common.n_RefreshYardMusic, nil, nil)
end

local function p2(protocol, client)
end

return {p1, p2}
