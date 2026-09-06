local function p1(protocol)
  NekoData.BehaviorManager.BM_Message:SendMessageById(protocol.msgId, protocol.parameters)
end

local function p2(protocol, client)
end

return {p1, p2}
