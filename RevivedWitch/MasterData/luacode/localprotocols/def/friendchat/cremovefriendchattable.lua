-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/friendchat/cremovefriendchattable.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CRemoveFriendChatTable = dataclass("CRemoveFriendChatTable")
CRemoveFriendChatTable.ProtocolType = 110
CRemoveFriendChatTable.userId = 0
CRemoveFriendChatTable.Ctor = function(self, client)
  -- function num : 0_0
end

CRemoveFriendChatTable.Marshal = function(self, data)
  -- function num : 0_1
  data.userId = self.userId
end

CRemoveFriendChatTable.Unmarshal = function(self, data)
  -- function num : 0_2
  self.userId = data.userId
  return true
end

CRemoveFriendChatTable.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if type(self.userId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.userId) = %s. number required.", type(self.userId))
    return false
  end
  return true
end

return CRemoveFriendChatTable

