local SGetLocalChatInfo = dataclass("SGetLocalChatInfo")
SGetLocalChatInfo.ProtocolType = 108
SGetLocalChatInfo.clientId = 0
SGetLocalChatInfo.userId = 0
SGetLocalChatInfo.redNum = 0
SGetLocalChatInfo.totalNum = 0

function SGetLocalChatInfo:Ctor(client)
end

function SGetLocalChatInfo:Marshal(data)
  data.clientId = self.clientId
  data.userId = self.userId
  data.redNum = self.redNum
  data.totalNum = self.totalNum
end

function SGetLocalChatInfo:Unmarshal(data)
  self.clientId = data.clientId
  self.userId = data.userId
  self.redNum = data.redNum
  self.totalNum = data.totalNum
  return true
end

function SGetLocalChatInfo:CheckVariable()
  if type(self.clientId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.clientId) = %s. number required.", type(self.clientId))
    return false
  end
  if type(self.userId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.userId) = %s. number required.", type(self.userId))
    return false
  end
  if type(self.redNum) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.redNum) = %s. number required.", type(self.redNum))
    return false
  end
  if type(self.totalNum) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.totalNum) = %s. number required.", type(self.totalNum))
    return false
  end
  return true
end

return SGetLocalChatInfo
