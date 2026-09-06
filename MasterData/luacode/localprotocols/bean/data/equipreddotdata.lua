local EquipRedDotData = dataclass("EquipRedDotData")
EquipRedDotData.roleKey = 0
EquipRedDotData.weaponKey = 0
EquipRedDotData.armorKey = 0
EquipRedDotData.jewelryKey = 0

function EquipRedDotData:Ctor()
end

function EquipRedDotData:Marshal(data)
  data.roleKey = self.roleKey
  data.weaponKey = self.weaponKey
  data.armorKey = self.armorKey
  data.jewelryKey = self.jewelryKey
end

function EquipRedDotData:Unmarshal(data)
  self.roleKey = data.roleKey
  self.weaponKey = data.weaponKey
  self.armorKey = data.armorKey
  self.jewelryKey = data.jewelryKey
end

function EquipRedDotData:CheckVariable()
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
