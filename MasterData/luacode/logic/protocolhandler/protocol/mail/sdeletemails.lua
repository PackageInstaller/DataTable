local function p1(protocol)
  NekoData.DataManager.DM_Mail:OnSDeleteMails(protocol)
  
  local userInfo = {}
  if #protocol.uniqueIds == 1 then
    userInfo.result = protocol.uniqueIds[1].result
    userInfo.uniqueId = protocol.uniqueIds[1].uniqueId
    userInfo.tag = "sdeletemails"
  end
  LuaNotificationCenter.PostNotification(Common.n_MailInfoChange, DM_Mail, userInfo)
end

local function p2(protocol, client)
end

return {p1, p2}
