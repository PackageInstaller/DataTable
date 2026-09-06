local function p1(protocol)
  DialogManager.DestroySingletonDialog("login.eventreconnectdialog")
  
  local userinfo = {}
  userinfo.npcID = protocol.npcId
  userinfo.services = protocol.serviceIds
  userinfo.effectId = protocol.effectid
  LuaNotificationCenter.PostNotification(Common.n_NPCServerListReceive, nil, userinfo)
end

local function p2(protocol, client)
end

return {p1, p2}
