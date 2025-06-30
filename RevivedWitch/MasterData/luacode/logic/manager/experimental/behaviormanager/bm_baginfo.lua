-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_baginfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ItemTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.item")
local BagTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.bagtypes")
local CItemAttrTable = (BeanManager.GetTableByName)("item.citemattr")
local Item = require("logic.manager.experimental.types.item")
local BM_BagInfo = class("BM_BagInfo")
BM_BagInfo.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._bagInfoData = (NekoData.Data).baginfo
end

BM_BagInfo.GetItemList = function(self)
  -- function num : 0_1 , upvalues : _ENV, BagTypeEnum
  local item = nil
  local itemList = {}
  for bagtype,baginfo in pairs((self._bagInfoData)[(((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userid]) do
    if bagtype == BagTypeEnum.BAG then
      for key,item in pairs(baginfo.items) do
        (table.insert)(itemList, readonly(item))
      end
    end
  end
  return itemList
end

BM_BagInfo.GetEquipList = function(self)
  -- function num : 0_2 , upvalues : _ENV, BagTypeEnum
  local item = nil
  local itemList = {}
  for bagtype,baginfo in pairs((self._bagInfoData)[(((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userid]) do
    if bagtype == BagTypeEnum.EQUIPBAG then
      for key,item in pairs(baginfo.items) do
        (table.insert)(itemList, readonly(item))
      end
    end
  end
  return itemList
end

BM_BagInfo.GetItem = function(self, itemKey)
  -- function num : 0_3 , upvalues : _ENV, BagTypeEnum
  for bagtype,baginfo in pairs((self._bagInfoData)[(((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userid]) do
    if bagtype == BagTypeEnum.BAG and (baginfo.items)[itemKey] then
      return readonly((baginfo.items)[itemKey])
    end
  end
end

BM_BagInfo.GetEquipItem = function(self, itemKey)
  -- function num : 0_4 , upvalues : _ENV, BagTypeEnum
  for bagtype,baginfo in pairs((self._bagInfoData)[(((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userid]) do
    if bagtype == BagTypeEnum.EQUIPBAG and (baginfo.items)[itemKey] then
      return readonly((baginfo.items)[itemKey])
    end
  end
end

BM_BagInfo.GetItemID = function(self, itemKey)
  -- function num : 0_5 , upvalues : _ENV, BagTypeEnum
  for bagtype,baginfo in pairs((self._bagInfoData)[(((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userid]) do
    if bagtype == BagTypeEnum.BAG and (baginfo.items)[itemKey] then
      return ((baginfo.items)[itemKey]):GetID()
    end
  end
end

BM_BagInfo.GetEquipItemID = function(self, itemKey)
  -- function num : 0_6 , upvalues : _ENV, BagTypeEnum
  for bagtype,baginfo in pairs((self._bagInfoData)[(((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userid]) do
    if bagtype == BagTypeEnum.EQUIPBAG and (baginfo.items)[itemKey] then
      return ((baginfo.items)[itemKey]):GetID()
    end
  end
end

BM_BagInfo.GetItemCountById = function(self, itemId)
  -- function num : 0_7 , upvalues : _ENV
  local count = 0
  for bagtype,baginfo in pairs((self._bagInfoData)[(((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userid]) do
    for key,item in pairs(baginfo.items) do
      if item:GetID() == itemId then
        count = count + item:GetCount()
      end
    end
  end
  return count
end

BM_BagInfo.GetEquipTypeById = function(self, equipId)
  -- function num : 0_8 , upvalues : _ENV, BagTypeEnum
  for bagtype,baginfo in pairs((self._bagInfoData)[(((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userid]) do
    if bagtype == BagTypeEnum.EQUIPBAG then
      for key,item in pairs(baginfo.items) do
        if item:GetID() == equipId then
          return item:GetEquipType()
        end
      end
    end
  end
end

BM_BagInfo.GetBagCapacityByType = function(self, type)
  -- function num : 0_9 , upvalues : _ENV
  return (((self._bagInfoData)[(((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userid])[type]).capacity
end

BM_BagInfo.GetItemListByTypeID = function(self, itemtypeid)
  -- function num : 0_10 , upvalues : _ENV, BagTypeEnum
  local item, itemrecord = nil, nil
  local itemList = {}
  for bagtype,baginfo in pairs((self._bagInfoData)[(((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userid]) do
    if bagtype == BagTypeEnum.BAG then
      for key,item in pairs(baginfo.items) do
        if item:GetItemTypeId() == itemtypeid then
          (table.insert)(itemList, readonly(item))
        end
      end
    end
  end
  return itemList
end

BM_BagInfo.GetItemListByPageIndex = function(self, pageIndex)
  -- function num : 0_11 , upvalues : _ENV, BagTypeEnum
  local item = nil
  local itemList = {}
  local itemrecord = nil
  for bagtype,baginfo in pairs((self._bagInfoData)[(((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userid]) do
    if bagtype == BagTypeEnum.BAG then
      for key,item in pairs(baginfo.items) do
        if item:IsPageIndexShow(pageIndex) then
          (table.insert)(itemList, readonly(item))
        end
      end
    end
  end
  return itemList
end

BM_BagInfo.GetItemHunShiList = function(self)
  -- function num : 0_12 , upvalues : _ENV, BagTypeEnum
  local item = nil
  local itemList = {}
  local itemrecord = nil
  for bagtype,baginfo in pairs((self._bagInfoData)[(((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userid]) do
    if bagtype == BagTypeEnum.BAG then
      for key,item in pairs(baginfo.items) do
        if item:IfEvolutionItem() then
          (table.insert)(itemList, readonly(item))
        end
      end
    end
  end
  return itemList
end

BM_BagInfo.GetDiamodItem = function(self)
  -- function num : 0_13 , upvalues : Item, _ENV
  local item = (Item.Create)(DataCommon.DiamodID)
  item:SetCount(((NekoData.BehaviorManager).BM_Currency):GetDiamond())
  return item
end

BM_BagInfo.GetSoulDropCoinItem = function(self)
  -- function num : 0_14 , upvalues : Item, _ENV
  local item = (Item.Create)(DataCommon.SoulDropID)
  item:SetCount(((NekoData.BehaviorManager).BM_Currency):GetSoulDropCoin())
  return item
end

BM_BagInfo.GetValuableBagList = function(self)
  -- function num : 0_15 , upvalues : _ENV, BagTypeEnum
  local item = nil
  local itemList = {}
  for bagtype,baginfo in pairs((self._bagInfoData)[(((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userid]) do
    if bagtype == BagTypeEnum.VALUABLEBAG then
      for key,item in pairs(baginfo.items) do
        (table.insert)(itemList, readonly(item))
      end
    end
  end
  return itemList
end

BM_BagInfo.GetStrengthenItemList = function(self)
  -- function num : 0_16 , upvalues : _ENV, BagTypeEnum
  local item = nil
  local itemList = {}
  for bagtype,baginfo in pairs((self._bagInfoData)[(((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userid]) do
    if bagtype == BagTypeEnum.BAG then
      for key,item in pairs(baginfo.items) do
        if item:IsStrengthenItem() then
          (table.insert)(itemList, readonly(item))
        end
      end
    end
  end
  ;
  (table.sort)(itemList, function(a, b)
    -- function num : 0_16_0
    do return a:GetID() < b:GetID() end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  return itemList
end

BM_BagInfo.GetEnchantItemList = function(self)
  -- function num : 0_17 , upvalues : _ENV, BagTypeEnum
  local item = nil
  local itemList = {}
  for bagtype,baginfo in pairs((self._bagInfoData)[(((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userid]) do
    if bagtype == BagTypeEnum.BAG then
      for key,item in pairs(baginfo.items) do
        if item:IsEnchantItem() then
          (table.insert)(itemList, readonly(item))
        end
      end
    end
  end
  ;
  (table.sort)(itemList, function(a, b)
    -- function num : 0_17_0
    do return a:GetID() < b:GetID() end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  return itemList
end

BM_BagInfo.GetItemWithBagType = function(self, bagtype, itemKey)
  -- function num : 0_18 , upvalues : _ENV
  for b,baginfo in pairs((self._bagInfoData)[(((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userid]) do
    if b == bagtype and (baginfo.items)[itemKey] then
      return readonly((baginfo.items)[itemKey])
    end
  end
  LogInfoFormat("BM_BagInfo", "bagtype %s dont have item key %s\ntraceback %s", bagtype, itemKey, (debug.traceback)())
end

BM_BagInfo.GetItemListWithBagType = function(self, bagType)
  -- function num : 0_19 , upvalues : _ENV
  local itemList = {}
  for bagtype,baginfo in pairs((self._bagInfoData)[(((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userid]) do
    if bagtype == bagType then
      for key,item in pairs(baginfo.items) do
        (table.insert)(itemList, readonly(item))
      end
    end
  end
  return itemList
end

BM_BagInfo.GetUnLockEquipList = function(self)
  -- function num : 0_20 , upvalues : _ENV, BagTypeEnum
  local item = nil
  local itemList = {}
  for bagtype,baginfo in pairs((self._bagInfoData)[(((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userid]) do
    if bagtype == BagTypeEnum.EQUIPBAG then
      for key,item in pairs(baginfo.items) do
        if not item:IsLocked() then
          (table.insert)(itemList, readonly(item))
        end
      end
    end
  end
  return itemList
end

BM_BagInfo.HasCachedFMKey = function(self)
  -- function num : 0_21 , upvalues : _ENV
  for k,v in pairs((self._bagInfoData).cachedPreFMKeyTable) do
    do return true end
  end
  return false
end

BM_BagInfo.IsCachedFMKey = function(self, key)
  -- function num : 0_22
  local result = ((self._bagInfoData).cachedPreFMKeyTable)[key]
  if result then
    return true
  else
    return false
  end
end

BM_BagInfo.GetCachedFMKeyTable = function(self)
  -- function num : 0_23
  return (self._bagInfoData).cachedPreFMKeyTable
end

BM_BagInfo.RemoveCachedFMKey = function(self, key)
  -- function num : 0_24
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self._bagInfoData).cachedPreFMKeyTable)[key] = nil
end

BM_BagInfo.SetPreFMLastLuckValueTable = function(self, key, value)
  -- function num : 0_25
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R3 in 'UnsetPending'

  ((self._bagInfoData).preFMLastLuckValueTable)[key] = value
end

BM_BagInfo.GetPreFMLastLuckValueTable = function(self, key)
  -- function num : 0_26
  return ((self._bagInfoData).preFMLastLuckValueTable)[key]
end

BM_BagInfo.GetDeleteSpiritItem = function(self)
  -- function num : 0_27 , upvalues : _ENV
  (self:GetItemListByTypeID(DataCommon.SpiritItemType))
  local spiritItems = nil
  local item = nil
  local delTime = 9.007199254741e+15
  local hsaDelTime = false
  for i,v in ipairs(spiritItems) do
    local tempDeltime = v:GetDelTime()
    if tempDeltime and tempDeltime < delTime then
      delTime = tempDeltime
      item = v
      hsaDelTime = true
    end
  end
  if hsaDelTime then
    return item
  end
  return false
end

BM_BagInfo.GetGuildDonateItems = function(self)
  -- function num : 0_28 , upvalues : _ENV, BagTypeEnum
  local item = nil
  local itemList = {}
  for bagtype,baginfo in pairs((self._bagInfoData)[(((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userid]) do
    if bagtype == BagTypeEnum.BAG then
      for key,item in pairs(baginfo.items) do
        if item:IsGuildDonateItem() then
          (table.insert)(itemList, readonly(item))
        end
      end
    end
  end
  ;
  (table.sort)(itemList, function(a, b)
    -- function num : 0_28_0
    if a:GetDonationValueWeight() < b:GetDonationValueWeight() then
      return true
    else
      if a:GetID() >= b:GetID() then
        do return a:GetDonationValueWeight() ~= b:GetDonationValueWeight() end
        -- DECOMPILER ERROR: 2 unprocessed JMP targets
      end
    end
  end
)
  return itemList
end

BM_BagInfo.GetFurnitureCountById = function(self, itemId)
  -- function num : 0_29 , upvalues : _ENV, BagTypeEnum
  local count = 0
  for bagtype,baginfo in pairs((self._bagInfoData)[(((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userid]) do
    if bagtype == BagTypeEnum.FURNITURE_BAG then
      for key,item in pairs(baginfo.items) do
        if item:GetID() == itemId then
          count = count + item:GetCount()
        end
      end
    end
  end
  return count
end

return BM_BagInfo

