local CStoreFriendChatList = dataclass("CStoreFriendChatList")
CStoreFriendChatList.ProtocolType = 111
CStoreFriendChatList.userId = 0

function CStoreFriendChatList:Ctor(client)
  self.msgs = {}
end

function CStoreFriendChatList:Marshal(data)
  data.userId = self.userId
  data.msgs = {}
  for index, value in ipairs(self.msgs) do
    data.msgs[index] = {}
    self.msgs[index]:Marshal(data.msgs[index])
  end
end

function CStoreFriendChatList:Unmarshal(data)
  self.userId = data.userId
  for index, value in ipairs(data.msgs) do
    self.msgs[index] = require("localprotocols.bean.data.friendchatinfo").Create()
    self.msgs[index]:Unmarshal(data.msgs[index])
  end
  return true
end

function CStoreFriendChatList:CheckVariable()
  if type(self.userId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.userId) = %s. number required.", type(self.userId))
    return false
  end
  if type(self.msgs) ~= "table" then
    LogErrorFormat("LocalProtocols", "type error!type(self.msgs) = %s. table required.", type(self.msgs))
    return false
  end
  for index, value in ipairs(self.msgs) do
    if not value:CheckVariable() then
      return false
    end
  end
  return true
end

return CStoreFriendChatList
