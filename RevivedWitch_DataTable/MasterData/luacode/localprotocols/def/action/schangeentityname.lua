-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/action/schangeentityname.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SChangeEntityName = dataclass("SChangeEntityName")
SChangeEntityName.ProtocolType = 56
SChangeEntityName.entityId = 0
SChangeEntityName.nameTextId = 0
SChangeEntityName.Ctor = function(self, client)
  -- function num : 0_0
end

SChangeEntityName.Marshal = function(self, data)
  -- function num : 0_1
  data.entityId = self.entityId
  data.nameTextId = self.nameTextId
end

SChangeEntityName.Unmarshal = function(self, data)
  -- function num : 0_2
  self.entityId = data.entityId
  self.nameTextId = data.nameTextId
  return true
end

SChangeEntityName.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if type(self.entityId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.entityId) = %s. number required.", type(self.entityId))
    return false
  end
  if type(self.nameTextId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.nameTextId) = %s. number required.", type(self.nameTextId))
    return false
  end
  return true
end

return SChangeEntityName

