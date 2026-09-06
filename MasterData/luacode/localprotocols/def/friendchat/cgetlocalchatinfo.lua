local CGetLocalChatInfo = dataclass("CGetLocalChatInfo")
CGetLocalChatInfo.ProtocolType = 107
CGetLocalChatInfo.userId = 0

function CGetLocalChatInfo:Ctor(client)
end

function CGetLocalChatInfo:Marshal(data)
  data.userId = self.userId
end

function CGetLocalChatInfo:Unmarshal(data)
  self.userId = data.userId
  return true
end

function CGetLocalChatInfo:CheckVariable()
  if type(self.userId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.userId) = %s. number required.", type(self.userId))
    return false
  end
  return true
end

return CGetLocalChatInfo
