-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/bean/data/equipreddotdata.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EquipRedDotData = dataclass("EquipRedDotData")
EquipRedDotData.roleKey = 0
EquipRedDotData.weaponKey = 0
EquipRedDotData.armorKey = 0
EquipRedDotData.jewelryKey = 0
EquipRedDotData.Ctor = function(self)
  -- function num : 0_0
end

EquipRedDotData.Marshal = function(self, data)
  -- function num : 0_1
  data.roleKey = self.roleKey
  data.weaponKey = self.weaponKey
  data.armorKey = self.armorKey
  data.jewelryKey = self.jewelryKey
end

EquipRedDotData.Unmarshal = function(self, data)
  -- function num : 0_2
  self.roleKey = data.roleKey
  self.weaponKey = data.weaponKey
  self.armorKey = data.armorKey
  self.jewelryKey = data.jewelryKey
end

EquipRedDotData.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if type(self.roleKey) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.roleKey) = %s. number required.", type(self.roleKey))
    return false
  end
  if type(self.weaponKey) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.weaponKey) = %s. number required.", type(self.weaponKey))
    return false
  end
  if type(self.armorKey) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.armorKey) = %s. number required.", type(self.armorKey))
    return false
  end
  if type(self.jewelryKey) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.jewelryKey) = %s. number required.", type(self.jewelryKey))
    return false
  end
  return true
end

return EquipRedDotData

