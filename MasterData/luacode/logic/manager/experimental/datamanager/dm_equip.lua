local EquipTypeEnum = LuaNetManager.GetBeanDef("protocol.item.equiptype")
local DM_Equip = class("DM_Equip")

function DM_Equip:Ctor()
  self._equip = NekoData.Data.equip
end

function DM_Equip:OnSEquipmentInfo(protocol)
  self._userid = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userid
  self._equip[self._userid] = {}
  local equip = self._equip[self._userid]
  equip.WEAPON = {}
  equip.JEWELRY = {}
  for i, v in ipairs(protocol.equipments) do
    local equipInfo = {}
    equipInfo.key = v.key
    equipInfo.id = v.id
    equipInfo.roleKey = v.roleKey
    if v.equipType == EquipTypeEnum.WEAPON then
      equipInfo.equipType = "WEAPON"
    end
    if v.equipType == EquipTypeEnum.JEWELRY then
      equipInfo.equipType = "JEWELRY"
    end
    equipInfo.level = v.level
    equipInfo.starLevel = v.starLevel
    equipInfo.power = v.power
    equipInfo.mainAttributes = {}
    equipInfo.additionalAattributes = {}
    equipInfo.additionalSkills = {}
    for key, value in pairs(v.baseAttr) do
      equipInfo.mainAttributes[key] = value
    end
    for key, value in pairs(v.appendAttr) do
      equipInfo.additionalAattributes[key] = value
    end
    for key, value in pairs(v.appendSkill) do
      equipInfo.additionalSkills[key] = value
    end
    table.insert(equip[equipInfo.equipType], equipInfo)
  end
end

function DM_Equip:OnSChangeEquipment(protocol)
  for equipKey, roleKey in pairs(protocol.equips) do
    local type
    if protocol.equipType == EquipTypeEnum.WEAPON then
      type = "WEAPON"
    end
    if protocol.equipType == EquipTypeEnum.JEWELRY then
      type = "JEWELRY"
    end
    if type then
      for i, v in ipairs(self._equip[self._userid][type]) do
        if v.key == equipKey then
          v.roleKey = roleKey
        end
      end
    end
  end
end

function DM_Equip:OnSNewEquipment(protocol)
  self._userid = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userid
  local v = protocol.equipment
  local equipInfo = {}
  equipInfo.key = v.key
  equipInfo.id = v.id
  equipInfo.roleKey = v.roleKey
  if v.equipType == EquipTypeEnum.WEAPON then
    equipInfo.equipType = "WEAPON"
  end
  if v.equipType == EquipTypeEnum.JEWELRY then
    equipInfo.equipType = "JEWELRY"
  end
  equipInfo.level = v.level
  equipInfo.starLevel = v.starLevel
  equipInfo.power = v.power
  equipInfo.mainAttributes = {}
  equipInfo.additionalAattributes = {}
  equipInfo.additionalSkills = {}
  for key, value in pairs(v.baseAttr) do
    equipInfo.mainAttributes[key] = value
  end
  for key, value in pairs(v.appendAttr) do
    equipInfo.additionalAattributes[key] = value
  end
  for key, value in pairs(v.appendSkill) do
    equipInfo.additionalSkills[key] = value
  end
  table.insert(self._equip[self._userid][equipInfo.equipType], equipInfo)
end

return DM_Equip
