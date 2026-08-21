-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/friendchat/sgetlocalchatinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SGetLocalChatInfo = dataclass("SGetLocalChatInfo")
SGetLocalChatInfo.ProtocolType = 108
SGetLocalChatInfo.clientId = 0
SGetLocalChatInfo.userId = 0
SGetLocalChatInfo.redNum = 0
SGetLocalChatInfo.totalNum = 0
SGetLocalChatInfo.Ctor = function(self, client)
  -- function num : 0_0
end

SGetLocalChatInfo.Marshal = function(self, data)
  -- function num : 0_1
  data.clientId = self.clientId
  data.userId = self.userId
  data.redNum = self.redNum
  data.totalNum = self.totalNum
end

SGetLocalChatInfo.Unmarshal = function(self, data)
  -- function num : 0_2
  self.clientId = data.clientId
  self.userId = data.userId
  self.redNum = data.redNum
  self.totalNum = data.totalNum
  return true
end

SGetLocalChatInfo.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
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

