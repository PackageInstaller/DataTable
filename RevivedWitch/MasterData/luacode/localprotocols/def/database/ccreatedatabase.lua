-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/database/ccreatedatabase.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CCreateDataBase = dataclass("CCreateDataBase")
CCreateDataBase.ProtocolType = 301
CCreateDataBase.userId = 0
CCreateDataBase.clientId = 0
CCreateDataBase.Ctor = function(self, client)
  -- function num : 0_0
end

CCreateDataBase.Marshal = function(self, data)
  -- function num : 0_1
  data.userId = self.userId
  data.clientId = self.clientId
end

CCreateDataBase.Unmarshal = function(self, data)
  -- function num : 0_2
  self.userId = data.userId
  self.clientId = data.clientId
  return true
end

CCreateDataBase.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if type(self.userId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.userId) = %s. number required.", type(self.userId))
    return false
  end
  if type(self.clientId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.clientId) = %s. number required.", type(self.clientId))
    return false
  end
  return true
end

return CCreateDataBase

