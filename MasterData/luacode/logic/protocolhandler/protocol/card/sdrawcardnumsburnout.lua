local function p1(protocol)
  LogInfoFormat("SDrawCardNumsBurnOut", "--- type = %s --- : ", protocol.kind)
  
  NekoData.BehaviorManager.BM_Message:SendMessageById(100081)
  LuaNotificationCenter.PostNotification(Common.n_DrawCard, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
