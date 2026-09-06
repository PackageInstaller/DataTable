local function p1(protocol)
  LogInfo("snpcservice", "receive")
  
  local userinfo = {}
  userinfo.npcID = protocol.npcId
  userinfo.serverID = protocol.serviceId
  userinfo.childs = protocol.childServiceIds
  LuaNotificationCenter.PostNotification(Common.n_NPCServerIDReceive, nil, userinfo)
end

local function p2(protocol, client)
end

return {p1, p2}
