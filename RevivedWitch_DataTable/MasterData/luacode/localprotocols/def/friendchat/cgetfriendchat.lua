-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/friendchat/cgetfriendchat.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CGetFriendChat = dataclass("CGetFriendChat")
CGetFriendChat.ProtocolType = 104
CGetFriendChat.userId = 0
CGetFriendChat.beginId = 0
CGetFriendChat.endId = 0
CGetFriendChat.Ctor = function(self, client)
  -- function num : 0_0
end

CGetFriendChat.Marshal = function(self, data)
  -- function num : 0_1
  data.userId = self.userId
  data.beginId = self.beginId
  data.endId = self.endId
end

CGetFriendChat.Unmarshal = function(self, data)
  -- function num : 0_2
  self.userId = data.userId
  self.beginId = data.beginId
  self.endId = data.endId
  return true
end

CGetFriendChat.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if type(self.userId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.userId) = %s. number required.", type(self.userId))
    return false
  end
  if type(self.beginId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.beginId) = %s. number required.", type(self.beginId))
    return false
  end
  if type(self.endId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.endId) = %s. number required.", type(self.endId))
    return false
  end
  return true
end

return CGetFriendChat

