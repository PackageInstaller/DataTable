local CStoreFriendChat = dataclass("CStoreFriendChat")
CStoreFriendChat.ProtocolType = 103
CStoreFriendChat.userId = 0

function CStoreFriendChat:Ctor(client)
  self.msg = require("localprotocols.bean.data.friendchatinfo").Create()
end

function CStoreFriendChat:Marshal(data)
  data.userId = self.userId
  data.msg = {}
  self.msg:Marshal(data.msg)
end

function CStoreFriendChat:Unmarshal(data)
  self.userId = data.userId
  self.msg = require("localprotocols.bean.data.friendchatinfo").Create()
  self.msg:Unmarshal(data.msg)
  return true
end

function CStoreFriendChat:CheckVariable()
  if type(self.userId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.userId) = %s. number required.", type(self.userId))
    return false
  end
  if not self.msg:CheckVariable() then
    return false
  end
  return true
end

return CStoreFriendChat
