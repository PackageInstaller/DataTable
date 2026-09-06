local function p1(protocol)
  NekoData.DataManager.DM_Guild:OnSOpenGuild(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_OnSOpenParty, nil, nil)
  local dialog = DialogManager.CreateSingletonDialog("guild.guildmaindetail")
  if dialog then
    dialog:Init()
  end
  NekoData.DataManager.DM_Guild:ClearGotoGuildBossJump()
end

local function p2(protocol, client)
end

return {p1, p2}
