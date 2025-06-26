-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/friendchat/cgetlocalchatinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CGetLocalChatInfo = dataclass("CGetLocalChatInfo")
CGetLocalChatInfo.ProtocolType = 107
CGetLocalChatInfo.userId = 0
CGetLocalChatInfo.Ctor = function(self, client)
  -- function num : 0_0
end

CGetLocalChatInfo.Marshal = function(self, data)
  -- function num : 0_1
  data.userId = self.userId
end

CGetLocalChatInfo.Unmarshal = function(self, data)
  -- function num : 0_2
  self.userId = data.userId
  return true
end

CGetLocalChatInfo.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if type(self.userId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.userId) = %s. number required.", type(self.userId))
    return false
  end
  return true
end

return CGetLocalChatInfo

