local function p1(protocol)
  local dialog = DialogManager.GetDialog("yardmusic.unlockmusicdialog")
  
  if dialog and dialog._musicId == protocol.id then
    dialog:Destroy()
  end
  NekoData.DataManager.DM_YardMusic:OnSUnlockSong(protocol)
  NekoData.BehaviorManager.BM_YardMusic:SetPlayingId(protocol.id)
  LuaNotificationCenter.PostNotification(Common.n_UnlockSong, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
