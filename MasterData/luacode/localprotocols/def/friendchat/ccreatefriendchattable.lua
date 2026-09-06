local CCreateFriendChatTable = dataclass("CCreateFriendChatTable")
CCreateFriendChatTable.ProtocolType = 102
CCreateFriendChatTable.userId = 0

function CCreateFriendChatTable:Ctor(client)
end

function CCreateFriendChatTable:Marshal(data)
  data.userId = self.userId
end

function CCreateFriendChatTable:Unmarshal(data)
  self.userId = data.userId
  return true
end

function CCreateFriendChatTable:CheckVariable()
  if type(self.userId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.userId) = %s. number required.", type(self.userId))
    return false
  end
  return true
end

return CCreateFriendChatTable
