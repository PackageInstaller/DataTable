local function p1(protocol)
  NekoData.DataManager.DM_Mail:OnSSendNewMail(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_MailInfoChange, DM_Mail, nil)
end

local function p2(protocol, client)
end

return {p1, p2}
