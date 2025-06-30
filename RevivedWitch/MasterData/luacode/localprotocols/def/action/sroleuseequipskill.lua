-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/action/sroleuseequipskill.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SRoleUseEquipSkill = dataclass("SRoleUseEquipSkill")
SRoleUseEquipSkill.ProtocolType = 39
SRoleUseEquipSkill.entityid = 0
SRoleUseEquipSkill.skillid = 0
SRoleUseEquipSkill.Ctor = function(self, client)
  -- function num : 0_0
end

SRoleUseEquipSkill.Marshal = function(self, data)
  -- function num : 0_1
  data.entityid = self.entityid
  data.skillid = self.skillid
end

SRoleUseEquipSkill.Unmarshal = function(self, data)
  -- function num : 0_2
  self.entityid = data.entityid
  self.skillid = data.skillid
  return true
end

SRoleUseEquipSkill.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if type(self.entityid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.entityid) = %s. number required.", type(self.entityid))
    return false
  end
  if type(self.skillid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.skillid) = %s. number required.", type(self.skillid))
    return false
  end
  return true
end

return SRoleUseEquipSkill

