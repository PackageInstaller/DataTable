local function p1(protocol)
  local req = LuaNetManager.CreateProtocol("protocol.chat.cchangesubchannel")
  
  NekoData.DataManager.DM_Chat:OnSChangeSubChannel(protocol)
  if protocol.num == req.FLAG_CHANNEL_FULL then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100186)
  elseif protocol.num == req.FLAG_CHANNEL_INEXISTENT then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100187)
  end
  LuaNotificationCenter.PostNotification(Common.n_SubChannelChange, nil, nil)
end

local function p2(protocol, client)
end

return {p1, p2}
