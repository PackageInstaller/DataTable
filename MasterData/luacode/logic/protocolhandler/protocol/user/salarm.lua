local function p1(protocol)
  if protocol.result == 0 then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100306, nil)
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100064, nil)
  end
end

local function p2(protocol, client)
end

return {p1, p2}
