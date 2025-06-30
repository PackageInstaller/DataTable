-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/dm_equip.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EquipTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.equiptype")
local DM_Equip = class("DM_Equip")
DM_Equip.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._equip = (NekoData.Data).equip
end

DM_Equip.OnSEquipmentInfo = function(self, protocol)
  -- function num : 0_1 , upvalues : _ENV, EquipTypeEnum
  self._userid = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userid
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._equip)[self._userid] = {}
  local equip = (self._equip)[self._userid]
  equip.WEAPON = {}
  equip.JEWELRY = {}
  for i,v in ipairs(protocol.equipments) do
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
    for key,value in pairs(v.baseAttr) do
      -- DECOMPILER ERROR at PC56: Confused about usage of register: R14 in 'UnsetPending'

      (equipInfo.mainAttributes)[key] = value
    end
    for key,value in pairs(v.appendAttr) do
      -- DECOMPILER ERROR at PC64: Confused about usage of register: R14 in 'UnsetPending'

      (equipInfo.additionalAattributes)[key] = value
    end
    for key,value in pairs(v.appendSkill) do
      -- DECOMPILER ERROR at PC72: Confused about usage of register: R14 in 'UnsetPending'

      (equipInfo.additionalSkills)[key] = value
    end
    ;
    (table.insert)(equip[equipInfo.equipType], equipInfo)
  end
end

DM_Equip.OnSChangeEquipment = function(self, protocol)
  -- function num : 0_2 , upvalues : _ENV, EquipTypeEnum
  for equipKey,roleKey in pairs(protocol.equips) do
    local type = nil
    if protocol.equipType == EquipTypeEnum.WEAPON then
      type = "WEAPON"
    end
    if protocol.equipType == EquipTypeEnum.JEWELRY then
      type = "JEWELRY"
    end
    if type then
      for i,v in ipairs(((self._equip)[self._userid])[type]) do
        if v.key == equipKey then
          v.roleKey = roleKey
        end
      end
    end
  end
end

DM_Equip.OnSNewEquipment = function(self, protocol)
  -- function num : 0_3 , upvalues : _ENV, EquipTypeEnum
  self._userid = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userid
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
  for key,value in pairs(v.baseAttr) do
    -- DECOMPILER ERROR at PC42: Confused about usage of register: R9 in 'UnsetPending'

    (equipInfo.mainAttributes)[key] = value
  end
  for key,value in pairs(v.appendAttr) do
    -- DECOMPILER ERROR at PC50: Confused about usage of register: R9 in 'UnsetPending'

    (equipInfo.additionalAattributes)[key] = value
  end
  for key,value in pairs(v.appendSkill) do
    -- DECOMPILER ERROR at PC58: Confused about usage of register: R9 in 'UnsetPending'

    (equipInfo.additionalSkills)[key] = value
  end
  ;
  (table.insert)(((self._equip)[self._userid])[equipInfo.equipType], equipInfo)
end

return DM_Equip

