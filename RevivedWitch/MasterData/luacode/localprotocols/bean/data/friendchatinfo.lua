-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/bean/data/friendchatinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local FriendChatInfo = dataclass("FriendChatInfo")
FriendChatInfo.chatid = 0
FriendChatInfo.sender = 0
FriendChatInfo.msg = ""
FriendChatInfo.time = 0
FriendChatInfo.mark = 0
FriendChatInfo.hyperlinks = ""
FriendChatInfo.Ctor = function(self)
  -- function num : 0_0
end

FriendChatInfo.Marshal = function(self, data)
  -- function num : 0_1
  data.chatid = self.chatid
  data.sender = self.sender
  data.msg = self.msg
  data.time = self.time
  data.mark = self.mark
  data.hyperlinks = self.hyperlinks
end

FriendChatInfo.Unmarshal = function(self, data)
  -- function num : 0_2
  self.chatid = data.chatid
  self.sender = data.sender
  self.msg = data.msg
  self.time = data.time
  self.mark = data.mark
  self.hyperlinks = data.hyperlinks
end

FriendChatInfo.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if type(self.chatid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.chatid) = %s. number required.", type(self.chatid))
    return false
  end
  if type(self.sender) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.sender) = %s. number required.", type(self.sender))
    return false
  end
  if type(self.msg) ~= "string" then
    LogErrorFormat("LocalProtocols", "type error!type(self.msg) = %s. string required.", type(self.msg))
    return false
  end
  if type(self.time) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.time) = %s. number required.", type(self.time))
    return false
  end
  if type(self.mark) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.mark) = %s. number required.", type(self.mark))
    return false
  end
  if type(self.hyperlinks) ~= "string" then
    LogErrorFormat("LocalProtocols", "type error!type(self.hyperlinks) = %s. string required.", type(self.hyperlinks))
    return false
  end
  return true
end

return FriendChatInfo

