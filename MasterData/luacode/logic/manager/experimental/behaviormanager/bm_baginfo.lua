local ItemTypeEnum = LuaNetManager.GetBeanDef("protocol.item.beans.item")
local BagTypeEnum = LuaNetManager.GetBeanDef("protocol.item.beans.bagtypes")
local CItemAttrTable = BeanManager.GetTableByName("item.citemattr")
local Item = require("logic.manager.experimental.types.item")
local BM_BagInfo = class("BM_BagInfo")

function BM_BagInfo:Ctor()
  self._bagInfoData = NekoData.Data.baginfo
end

function BM_BagInfo:GetItemList()
  local item
  local itemList = {}
  for bagtype, baginfo in pairs(self._bagInfoData[NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userid]) do
    if bagtype == BagTypeEnum.BAG then
      for key, item in pairs(baginfo.items) do
        table.insert(itemList, readonly(item))
      end
    end
  end
  return itemList
end

function BM_BagInfo:GetEquipList()
  local item
  local itemList = {}
  for bagtype, baginfo in pairs(self._bagInfoData[NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userid]) do
    if bagtype == BagTypeEnum.EQUIPBAG then
      for key, item in pairs(baginfo.items) do
        table.insert(itemList, readonly(item))
      end
    end
  end
  return itemList
end

function BM_BagInfo:GetItem(itemKey)
  for bagtype, baginfo in pairs(self._bagInfoData[NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userid]) do
    if bagtype == BagTypeEnum.BAG and baginfo.items[itemKey] then
      return readonly(baginfo.items[itemKey])
    end
  end
end

function BM_BagInfo:GetEquipItem(itemKey)
  for bagtype, baginfo in pairs(self._bagInfoData[NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userid]) do
    if bagtype == BagTypeEnum.EQUIPBAG and baginfo.items[itemKey] then
      return readonly(baginfo.items[itemKey])
    end
  end
end

function BM_BagInfo:GetItemID(itemKey)
  for bagtype, baginfo in pairs(self._bagInfoData[NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userid]) do
    if bagtype == BagTypeEnum.BAG and baginfo.items[itemKey] then
      return baginfo.items[itemKey]:GetID()
    end
  end
end

function BM_BagInfo:GetEquipItemID(itemKey)
  for bagtype, baginfo in pairs(self._bagInfoData[NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userid]) do
    if bagtype == BagTypeEnum.EQUIPBAG and baginfo.items[itemKey] then
      return baginfo.items[itemKey]:GetID()
    end
  end
end

function BM_BagInfo:GetItemCountById(itemId)
  local count = 0
  for bagtype, baginfo in pairs(self._bagInfoData[NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userid]) do
    for key, item in pairs(baginfo.items) do
      if item:GetID() == itemId then
        count = count + item:GetCount()
      end
    end
  end
  return count
end

function BM_BagInfo:GetEquipTypeById(equipId)
  for bagtype, baginfo in pairs(self._bagInfoData[NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userid]) do
    if bagtype == BagTypeEnum.EQUIPBAG then
      for key, item in pairs(baginfo.items) do
        if item:GetID() == equipId then
          return item:GetEquipType()
        end
      end
    end
  end
end

function BM_BagInfo:GetBagCapacityByType(type)
  return self._bagInfoData[NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userid][type].capacity
end

function BM_BagInfo:GetItemListByTypeID(itemtypeid)
  local item, itemrecord
  local itemList = {}
  for bagtype, baginfo in pairs(self._bagInfoData[NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userid]) do
    if bagtype == BagTypeEnum.BAG then
      for key, item in pairs(baginfo.items) do
        if item:GetItemTypeId() == itemtypeid then
          table.insert(itemList, readonly(item))
        end
      end
    end
  end
  return itemList
end

function BM_BagInfo:GetItemListByPageIndex(pageIndex)
  local item
  local itemList = {}
  local itemrecord
  for bagtype, baginfo in pairs(self._bagInfoData[NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userid]) do
    if bagtype == BagTypeEnum.BAG then
      for key, item in pairs(baginfo.items) do
        if item:IsPageIndexShow(pageIndex) then
          table.insert(itemList, readonly(item))
        end
      end
    end
  end
  return itemList
end

function BM_BagInfo:GetItemHunShiList()
  local item
  local itemList = {}
  local itemrecord
  for bagtype, baginfo in pairs(self._bagInfoData[NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userid]) do
    if bagtype == BagTypeEnum.BAG then
      for key, item in pairs(baginfo.items) do
        if item:IfEvolutionItem() then
          table.insert(itemList, readonly(item))
        end
      end
    end
  end
  return itemList
end

function BM_BagInfo:GetDiamodItem()
  local item = Item.Create(DataCommon.DiamodID)
  item:SetCount(NekoData.BehaviorManager.BM_Currency:GetDiamond())
  return item
end

function BM_BagInfo:GetSoulDropCoinItem()
  local item = Item.Create(DataCommon.SoulDropID)
  item:SetCount(NekoData.BehaviorManager.BM_Currency:GetSoulDropCoin())
  return item
end

function BM_BagInfo:GetValuableBagList()
  local item
  local itemList = {}
  for bagtype, baginfo in pairs(self._bagInfoData[NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userid]) do
    if bagtype == BagTypeEnum.VALUABLEBAG then
      for key, item in pairs(baginfo.items) do
        table.insert(itemList, readonly(item))
      end
    end
  end
  return itemList
end

function BM_BagInfo:GetStrengthenItemList()
  local item
  local itemList = {}
  for bagtype, baginfo in pairs(self._bagInfoData[NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userid]) do
    if bagtype == BagTypeEnum.BAG then
      for key, item in pairs(baginfo.items) do
        if item:IsStrengthenItem() then
          table.insert(itemList, readonly(item))
        end
      end
    end
  end
  table.sort(itemList, function(a, b)
    return a:GetID() < b:GetID()
  end)
  return itemList
end

function BM_BagInfo:GetEnchantItemList()
  local item
  local itemList = {}
  for bagtype, baginfo in pairs(self._bagInfoData[NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userid]) do
    if bagtype == BagTypeEnum.BAG then
      for key, item in pairs(baginfo.items) do
        if item:IsEnchantItem() then
          table.insert(itemList, readonly(item))
        end
      end
    end
  end
  table.sort(itemList, function(a, b)
    return a:GetID() < b:GetID()
  end)
  return itemList
end

function BM_BagInfo:GetItemWithBagType(bagtype, itemKey)
  for b, baginfo in pairs(self._bagInfoData[NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userid]) do
    if b == bagtype and baginfo.items[itemKey] then
      return readonly(baginfo.items[itemKey])
    end
  end
  LogInfoFormat("BM_BagInfo", [[
bagtype %s dont have item key %s
traceback %s]], bagtype, itemKey, debug.traceback())
end

function BM_BagInfo:GetItemListWithBagType(bagType)
  local itemList = {}
  for bagtype, baginfo in pairs(self._bagInfoData[NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userid]) do
    if bagtype == bagType then
      for key, item in pairs(baginfo.items) do
        table.insert(itemList, readonly(item))
      end
    end
  end
  return itemList
end

function BM_BagInfo:GetUnLockEquipList()
  local item
  local itemList = {}
  for bagtype, baginfo in pairs(self._bagInfoData[NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userid]) do
    if bagtype == BagTypeEnum.EQUIPBAG then
      for key, item in pairs(baginfo.items) do
        if not item:IsLocked() then
          table.insert(itemList, readonly(item))
        end
      end
    end
  end
  return itemList
end

function BM_BagInfo:HasCachedFMKey()
  for k, v in pairs(self._bagInfoData.cachedPreFMKeyTable) do
    return true
  end
  return false
end

function BM_BagInfo:IsCachedFMKey(key)
  local result = self._bagInfoData.cachedPreFMKeyTable[key]
  if result then
    return true
  else
    return false
  end
end

function BM_BagInfo:GetCachedFMKeyTable()
  return self._bagInfoData.cachedPreFMKeyTable
end

function BM_BagInfo:RemoveCachedFMKey(key)
  self._bagInfoData.cachedPreFMKeyTable[key] = nil
end

function BM_BagInfo:SetPreFMLastLuckValueTable(key, value)
  self._bagInfoData.preFMLastLuckValueTable[key] = value
end

function BM_BagInfo:GetPreFMLastLuckValueTable(key)
  return self._bagInfoData.preFMLastLuckValueTable[key]
end

function BM_BagInfo:GetDeleteSpiritItem()
  local spiritItems = self:GetItemListByTypeID(DataCommon.SpiritItemType)
  local item
  local delTime = 9.007199254741002E15
  local hsaDelTime = false
  for i, v in ipairs(spiritItems) do
    local tempDeltime = v:GetDelTime()
    if tempDeltime and delTime > tempDeltime then
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

function BM_BagInfo:GetGuildDonateItems()
  local item
  local itemList = {}
  for bagtype, baginfo in pairs(self._bagInfoData[NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userid]) do
    if bagtype == BagTypeEnum.BAG then
      for key, item in pairs(baginfo.items) do
        if item:IsGuildDonateItem() then
          table.insert(itemList, readonly(item))
        end
      end
    end
  end
  table.sort(itemList, function(a, b)
    if a:GetDonationValueWeight() < b:GetDonationValueWeight() then
      return true
    elseif a:GetDonationValueWeight() == b:GetDonationValueWeight() then
      return a:GetID() < b:GetID()
    end
  end)
  return itemList
end

function BM_BagInfo:GetFurnitureCountById(itemId)
  local count = 0
  for bagtype, baginfo in pairs(self._bagInfoData[NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userid]) do
    if bagtype == BagTypeEnum.FURNITURE_BAG then
      for key, item in pairs(baginfo.items) do
        if item:GetID() == itemId then
          count = count + item:GetCount()
        end
      end
    end
  end
  return count
end

return BM_BagInfo
