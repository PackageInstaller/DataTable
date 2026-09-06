local function p1(protocol)
  NekoData.DataManager.DM_Task:OnSAddBadges(protocol)
  
  local dialog = DialogManager.GetDialog("achievement.roleachievementgetmodalshowdialog")
  if dialog then
    dialog:Destroy()
  end
  LuaNotificationCenter.PostNotification(Common.n_RefreshAchievementShowBag, nil, nil)
end

local function p2(protocol, client)
end

return {p1, p2}
