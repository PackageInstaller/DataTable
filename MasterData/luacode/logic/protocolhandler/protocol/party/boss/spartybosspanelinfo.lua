local function p1(protocol)
  NekoData.DataManager.DM_Guild:OnPartyBossPanelInfoProcess(protocol)
  
  local dialog = DialogManager.CreateSingletonDialog("guildboss.guildbossmaindialog")
  dialog:Init()
  LuaNotificationCenter.PostNotification(Common.n_GuildBossInfo, nil, nil)
end

local function p2(protocol, client)
end

return {p1, p2}
