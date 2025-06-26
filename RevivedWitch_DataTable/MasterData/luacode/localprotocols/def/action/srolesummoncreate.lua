-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/action/srolesummoncreate.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SRoleSummonCreate = dataclass("SRoleSummonCreate")
SRoleSummonCreate.ProtocolType = 24
SRoleSummonCreate.entityid = 0
SRoleSummonCreate.fatherEntityId = 0
SRoleSummonCreate.Role = 1
SRoleSummonCreate.Monster = 2
SRoleSummonCreate.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : _ENV
  self.attribute = ((require("localprotocols.bean.data.attribute")).Create)()
end

SRoleSummonCreate.Marshal = function(self, data)
  -- function num : 0_1
  data.entityid = self.entityid
  data.attribute = {}
  ;
  (self.attribute):Marshal(data.attribute)
  data.fatherEntityId = self.fatherEntityId
end

SRoleSummonCreate.Unmarshal = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  self.entityid = data.entityid
  self.attribute = ((require("localprotocols.bean.data.attribute")).Create)()
  ;
  (self.attribute):Unmarshal(data.attribute)
  self.fatherEntityId = data.fatherEntityId
  return true
end

SRoleSummonCreate.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if type(self.entityid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.entityid) = %s. number required.", type(self.entityid))
    return false
  end
  if not (self.attribute):CheckVariable() then
    return false
  end
  if type(self.fatherEntityId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.fatherEntityId) = %s. number required.", type(self.fatherEntityId))
    return false
  end
  return true
end

return SRoleSummonCreate

