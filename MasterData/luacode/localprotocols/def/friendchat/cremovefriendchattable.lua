local CRemoveFriendChatTable = dataclass("CRemoveFriendChatTable")
CRemoveFriendChatTable.ProtocolType = 110
CRemoveFriendChatTable.userId = 0

function CRemoveFriendChatTable:Ctor(client)
end

function CRemoveFriendChatTable:Marshal(data)
  data.userId = self.userId
end

function CRemoveFriendChatTable:Unmarshal(data)
  self.userId = data.userId
  return true
end

function CRemoveFriendChatTable:CheckVariable()
  if type(self.userId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.userId) = %s. number required.", type(self.userId))
    return false
  end
  return true
end

return CRemoveFriendChatTable
