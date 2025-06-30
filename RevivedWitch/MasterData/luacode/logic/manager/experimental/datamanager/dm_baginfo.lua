-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/dm_baginfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DM_BagInfo = class("DM_BagInfo")
local ItemTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.item")
local EquipTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.equiptype")
local BagTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.bagtypes")
local Item = require("logic.manager.experimental.types.item")
local Equip = require("logic.manager.experimental.types.equip")
local Skill = require("logic.manager.experimental.types.skill")
local FurnitureItem = require("logic.manager.experimental.types.furnitureitem")
DM_BagInfo.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._bagInfoData = (NekoData.Data).baginfo
end

DM_BagInfo.Clear = function(self)
  -- function num : 0_1 , upvalues : _ENV
  if self._bagInfoData then
    for k,v in pairs(self._bagInfoData) do
      -- DECOMPILER ERROR at PC8: Confused about usage of register: R6 in 'UnsetPending'

      (self._bagInfoData)[k] = nil
    end
  end
  do
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (self._bagInfoData).cachedPreFMKeyTable = nil
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (self._bagInfoData).preFMLastLuckValueTable = nil
  end
end

DM_BagInfo.OnSEnter = function(self, protocol)
  -- function num : 0_2 , upvalues : _ENV, BagTypeEnum, FurnitureItem, ItemTypeEnum, Item, Equip, Skill
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._bagInfoData).cachedPreFMKeyTable = {}
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._bagInfoData).preFMLastLuckValueTable = {}
  self._userid = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userid
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._bagInfoData)[self._userid] = {}
  local bagInfoData = (self._bagInfoData)[self._userid]
  local item = nil
  for type,bagInfo in pairs(protocol.bags) do
    bagInfoData[type] = {capacity = bagInfo.capacity, 
items = {}
}
    if type == BagTypeEnum.FURNITURE_BAG then
      for i,value in ipairs(bagInfo.items) do
        item = (FurnitureItem.Create)(value.id)
        item:InitWithFull(value)
        -- DECOMPILER ERROR at PC48: Confused about usage of register: R14 in 'UnsetPending'

        ;
        ((bagInfoData[type]).items)[value.key] = item
      end
    else
      do
        for i,value in ipairs(bagInfo.items) do
          if value.itemtype == ItemTypeEnum.BASEITEM then
            item = (Item.Create)(value.id)
          else
            if value.itemtype == ItemTypeEnum.EQUIP then
              item = (Equip.Create)(value.id)
            else
              if value.itemtype == ItemTypeEnum.SKILL then
                item = (Skill.Create)(value.id)
              end
            end
          end
          item:InitWithFull(value)
          -- DECOMPILER ERROR at PC88: Confused about usage of register: R14 in 'UnsetPending'

          ;
          ((bagInfoData[type]).items)[value.key] = item
          if value.itemtype == ItemTypeEnum.EQUIP and #(value.extra).preRandomEntry > 0 then
            item:SetPreRandomEntry((value.extra).preRandomEntry, (value.extra).preFinalAttrRandomEntry)
            -- DECOMPILER ERROR at PC107: Confused about usage of register: R14 in 'UnsetPending'

            ;
            ((self._bagInfoData).cachedPreFMKeyTable)[value.key] = true
          end
        end
        do
          -- DECOMPILER ERROR at PC110: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC110: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC110: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
end

DM_BagInfo.OnSAddItem = function(self, protocol)
  -- function num : 0_3 , upvalues : BagTypeEnum, _ENV, FurnitureItem, ItemTypeEnum, Item, Equip, Skill
  local item = nil
  local mydata = {}
  mydata.bagType = protocol.bagType
  mydata.data = protocol.data
  if mydata.bagType == BagTypeEnum.FURNITURE_BAG then
    for i,value in ipairs(mydata.data) do
      local item = ((((self._bagInfoData)[self._userid])[mydata.bagType]).items)[value.key]
      if item then
        item:SetCount(value.number)
      else
        item = (FurnitureItem.Create)(value.id)
        item:InitWithFull(value)
        -- DECOMPILER ERROR at PC42: Confused about usage of register: R10 in 'UnsetPending'

        ;
        ((((self._bagInfoData)[self._userid])[mydata.bagType]).items)[value.key] = item
      end
    end
  else
    do
      for i,value in ipairs(mydata.data) do
        local item = ((((self._bagInfoData)[self._userid])[mydata.bagType]).items)[value.key]
        if item then
          item:SetCount(value.number)
        else
          if value.itemtype == ItemTypeEnum.BASEITEM then
            item = (Item.Create)(value.id)
          else
            if value.itemtype == ItemTypeEnum.EQUIP then
              item = (Equip.Create)(value.id)
            else
              if value.itemtype == ItemTypeEnum.SKILL then
                item = (Skill.Create)(value.id)
              end
            end
          end
          item:InitWithFull(value)
          -- DECOMPILER ERROR at PC100: Confused about usage of register: R10 in 'UnsetPending'

          ;
          ((((self._bagInfoData)[self._userid])[mydata.bagType]).items)[value.key] = item
        end
      end
    end
  end
end

DM_BagInfo.OnSRemoveItem = function(self, protocol)
  -- function num : 0_4 , upvalues : _ENV
  if not (self._bagInfoData)[self._userid] then
    LogErrorFormat("DM_BagInfo", "-- self._userid(DM_BagInfo:OnSEnter) = %s, userid = %s", self._userid, (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userid)
    return 
  else
    if not ((self._bagInfoData)[self._userid])[protocol.bagType] then
      LogErrorFormat("DM_BagInfo", "-- bagType = %s", protocol.bagType)
      return 
    end
  end
  -- DECOMPILER ERROR at PC38: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((((self._bagInfoData)[self._userid])[protocol.bagType]).items)[protocol.itemKey] = nil
end

DM_BagInfo.OnSModifyItemNum = function(self, protocol)
  -- function num : 0_5
  (((((self._bagInfoData)[self._userid])[protocol.bagType]).items)[protocol.itemKey]):SetCount(protocol.itemNum)
  if protocol.delTime then
    (((((self._bagInfoData)[self._userid])[protocol.bagType]).items)[protocol.itemKey]):SetDelTimeList(protocol.delTime)
  end
end

DM_BagInfo.OnSChangeEquipment = function(self, protocol)
  -- function num : 0_6 , upvalues : _ENV, EquipTypeEnum, BagTypeEnum
  for equipKey,roleKey in pairs(protocol.equips) do
    local type = nil
    if (protocol.equipType)[equipKey] == EquipTypeEnum.WEAPON then
      type = EquipTypeEnum.WEAPON
    end
    if (protocol.equipType)[equipKey] == EquipTypeEnum.JEWELRY then
      type = EquipTypeEnum.JEWELRY
    end
    if (protocol.equipType)[equipKey] == EquipTypeEnum.ARMOR then
      type = EquipTypeEnum.ARMOR
    end
    if type and ((((self._bagInfoData)[self._userid])[BagTypeEnum.EQUIPBAG]).items)[equipKey] then
      (((((self._bagInfoData)[self._userid])[BagTypeEnum.EQUIPBAG]).items)[equipKey]):SetRoleKey(roleKey)
    end
  end
end

DM_BagInfo.OnSIdentifyEquip = function(self, protocol)
  -- function num : 0_7 , upvalues : BagTypeEnum
  local type = BagTypeEnum.EQUIPBAG
  ;
  (((((self._bagInfoData)[self._userid])[type]).items)[protocol.equipKey]):SetExtraInof(protocol.info)
end

DM_BagInfo.OnSEquipLevelUp = function(self, protocol)
  -- function num : 0_8 , upvalues : BagTypeEnum
  local type = BagTypeEnum.EQUIPBAG
  if ((((self._bagInfoData)[self._userid])[type]).items)[protocol.equipKey] then
    (((((self._bagInfoData)[self._userid])[type]).items)[protocol.equipKey]):SetStrengthenLevel(protocol.lv)
    ;
    (((((self._bagInfoData)[self._userid])[type]).items)[protocol.equipKey]):SetEquipExp(protocol.exp)
    ;
    (((((self._bagInfoData)[self._userid])[type]).items)[protocol.equipKey]):SetScore(protocol.power)
    ;
    (((((self._bagInfoData)[self._userid])[type]).items)[protocol.equipKey]):SetFinalAttr(protocol.finalAttr)
  end
end

DM_BagInfo.OnSEquipExpUp = function(self, protocol)
  -- function num : 0_9 , upvalues : BagTypeEnum
  local type = BagTypeEnum.EQUIPBAG
  if ((((self._bagInfoData)[self._userid])[type]).items)[protocol.equipKey] then
    (((((self._bagInfoData)[self._userid])[type]).items)[protocol.equipKey]):SetEquipExp(protocol.exp)
  end
end

DM_BagInfo.OnSEquipBreak = function(self, protocol)
  -- function num : 0_10 , upvalues : BagTypeEnum
  local type = BagTypeEnum.EQUIPBAG
  if ((((self._bagInfoData)[self._userid])[type]).items)[protocol.equipKey] then
    (((((self._bagInfoData)[self._userid])[type]).items)[protocol.equipKey]):SetStage(protocol.stage)
  end
end

DM_BagInfo.OnSChangeEquipAppendAttrs = function(self, protocol)
  -- function num : 0_11 , upvalues : BagTypeEnum
  local type = BagTypeEnum.EQUIPBAG
  if ((((self._bagInfoData)[self._userid])[type]).items)[protocol.equipKey] then
    local recastAttrs = (((((self._bagInfoData)[self._userid])[type]).items)[protocol.equipKey]):SetEquipRecastAttr({})
    ;
    (((((self._bagInfoData)[self._userid])[type]).items)[protocol.equipKey]):SetEquipAdditionalAttr(protocol.appendAttr)
    ;
    (((((self._bagInfoData)[self._userid])[type]).items)[protocol.equipKey]):SetScore(protocol.power)
  end
end

DM_BagInfo.OnSLockEquip = function(self, protocol)
  -- function num : 0_12 , upvalues : BagTypeEnum
  local type = BagTypeEnum.EQUIPBAG
  if ((((self._bagInfoData)[self._userid])[type]).items)[protocol.key] then
    (((((self._bagInfoData)[self._userid])[type]).items)[protocol.key]):SetIsLocked(protocol.lock)
  end
end

DM_BagInfo.OnSViewEquip = function(self, protocol)
  -- function num : 0_13 , upvalues : BagTypeEnum
  local type = BagTypeEnum.EQUIPBAG
  if ((((self._bagInfoData)[self._userid])[type]).items)[protocol.key] then
    (((((self._bagInfoData)[self._userid])[type]).items)[protocol.key]):SetIsChecked(protocol.viewDetails)
  end
end

DM_BagInfo.OnSEnchantEquip = function(self, protocol)
  -- function num : 0_14 , upvalues : BagTypeEnum
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  ((self._bagInfoData).cachedPreFMKeyTable)[protocol.equipKey] = nil
  local type = BagTypeEnum.EQUIPBAG
  if ((((self._bagInfoData)[self._userid])[type]).items)[protocol.equipKey] then
    (((((self._bagInfoData)[self._userid])[type]).items)[protocol.equipKey]):SetScore(protocol.power)
    ;
    (((((self._bagInfoData)[self._userid])[type]).items)[protocol.equipKey]):SetFinalAttr(protocol.finalAttr)
    ;
    (((((self._bagInfoData)[self._userid])[type]).items)[protocol.equipKey]):SetRandomEntry(protocol.randomEntry, protocol.finalAttrEntry)
    ;
    (((((self._bagInfoData)[self._userid])[type]).items)[protocol.equipKey]):SetRandomIndex(protocol.index)
    ;
    (((((self._bagInfoData)[self._userid])[type]).items)[protocol.equipKey]):SetLuckValue(protocol.luck)
    ;
    (((((self._bagInfoData)[self._userid])[type]).items)[protocol.equipKey]):SetIsEnchanted(true)
  end
end

DM_BagInfo.OnSPreviewEquipAttrs = function(self, protocol)
  -- function num : 0_15 , upvalues : BagTypeEnum
  local type = BagTypeEnum.EQUIPBAG
  if ((((self._bagInfoData)[self._userid])[type]).items)[protocol.key] then
    (((((self._bagInfoData)[self._userid])[type]).items)[protocol.key]):SetPreviewStrengthAttr(protocol.lvAttrs)
  end
end

DM_BagInfo.OnSPreEnchantEquip = function(self, protocol)
  -- function num : 0_16 , upvalues : BagTypeEnum
  local type = BagTypeEnum.EQUIPBAG
  if ((((self._bagInfoData)[self._userid])[type]).items)[protocol.equipKey] then
    (((((self._bagInfoData)[self._userid])[type]).items)[protocol.equipKey]):SetLuckValue(protocol.luck)
    ;
    (((((self._bagInfoData)[self._userid])[type]).items)[protocol.equipKey]):SetFMRequiredMana(protocol.nextCostMaNa)
  end
end

DM_BagInfo.OnSDecomposeEquips = function(self, protocol)
  -- function num : 0_17 , upvalues : _ENV, BagTypeEnum
  if not (self._bagInfoData)[self._userid] then
    LogErrorFormat("DM_BagInfo", "-- self._userid(DM_BagInfo:OnSEnter) = %s, userid = %s", self._userid, (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userid)
    return 
  else
    if not ((self._bagInfoData)[self._userid])[BagTypeEnum.EQUIPBAG] then
      LogErrorFormat("DM_BagInfo", "-- bagType = %s", BagTypeEnum.EQUIPBAG)
      return 
    end
  end
  for i,equipKey in ipairs(protocol.equipKeys) do
    -- DECOMPILER ERROR at PC41: Confused about usage of register: R7 in 'UnsetPending'

    ((((self._bagInfoData)[self._userid])[BagTypeEnum.EQUIPBAG]).items)[equipKey] = nil
  end
end

return DM_BagInfo

