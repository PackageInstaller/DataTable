local CItemAttrTable = BeanManager.GetTableByName("item.citemattr")
local CItemPinJiTable = BeanManager.GetTableByName("item.citempinji")
local CMaterialItemTable = BeanManager.GetTableByName("item.cmaterialitem")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CItemClassToLoadTable = BeanManager.GetTableByName("item.citemclasstoload")
local CTimeLimitedTtemTable = BeanManager.GetTableByName("item.ctimelimiteditem")
local CstringTable = BeanManager.GetTableByName("message.cstringres")
local CEquipStrengthenItemTable = BeanManager.GetTableByName("equip.cequipstrengthenitem")
local CEquipEnchantItemTable = BeanManager.GetTableByName("equip.cequipenchantitem")
local CDonateValue = BeanManager.GetTableByName("guild.cdonatevalue")
local EquipTypeEnum = LuaNetManager.GetBeanDef("protocol.item.equiptype")
local ItemTypeEnum = LuaNetManager.GetBeanDef("protocol.item.beans.item")
local Item = strictclass("Item")

function Item:Ctor(id)
  self._itemId = id
  self._itemKey = 0
  self._count = 1
  self._delTimeList = nil
  self._itemRecord = CItemAttrTable:GetRecorder(self._itemId)
  if self._itemRecord then
    self._pinJiRecord = CItemPinJiTable:GetRecorder(self._itemRecord.pinJi)
    self._classToloadRecord = CItemClassToLoadTable:GetRecorder(self._itemRecord.itemtypeid)
  else
    LogErrorFormat("Item", "item with id %s is not exist in citemattr", self._itemId)
  end
end

function Item:InitWithFull(iteminfo)
  if iteminfo then
    self._itemtype = iteminfo.itemtype
    self._itemKey = iteminfo.key
    self._count = iteminfo.number
    self._delTimeList = iteminfo.delTime
  end
end

function Item:InitWithItemInfo(iteminfo)
  if iteminfo then
    self._itemtype = iteminfo.itemtype
    self._count = iteminfo.number
    self._delTimeList = iteminfo.delTime
  end
end

function Item:IsGained()
  return self._itemKey and self._itemKey ~= 0
end

function Item:Clone()
  return clone(self)
end

function Item:GetItemAttr()
  return self._itemRecord
end

function Item:GetID()
  return self._itemId
end

function Item:SetKey(key)
  self._itemKey = key
end

function Item:GetKey()
  return self._itemKey
end

function Item:SetCount(count)
  self._count = count
end

function Item:GetCount()
  return self._count
end

function Item:IfEvolutionItem()
  local c = CMaterialItemTable:GetRecorder(self._itemId)
  if c then
    return c.ifEvolutionItem == 1
  end
end

function Item:GetName()
  return TextManager.GetText(self._itemRecord.nameTextID)
end

function Item:IsStrengthenItem()
  local recorder = CEquipStrengthenItemTable:GetRecorder(self._itemId)
  if recorder then
    return true
  end
  return false
end

function Item:GetSupplyExp()
  local recorder = CEquipStrengthenItemTable:GetRecorder(self._itemId)
  if recorder then
    return recorder.Exp
  end
  return nil
end

function Item:IsEnchantItem()
  local allIds = CEquipEnchantItemTable:GetAllIds()
  for i = 1, #allIds do
    local recorder = CEquipEnchantItemTable:GetRecorder(allIds[i])
    if recorder.id == self._itemId then
      return true
    end
  end
  return false
end

function Item:GetNeedManaByEnchantItem()
  local allIds = CEquipEnchantItemTable:GetAllIds()
  for i = 1, #allIds do
    local recorder = CEquipEnchantItemTable:GetRecorder(allIds[i])
    if recorder.id == self._itemId then
      return recorder.needMana
    end
  end
  return 0
end

function Item:GetEnchantAttrs()
  local map = {}
  local allIds = CEquipEnchantItemTable:GetAllIds()
  for i = 1, #allIds do
    local recorder = CEquipEnchantItemTable:GetRecorder(allIds[i])
    if recorder.id == self._itemId then
      for i, v in ipairs(recorder.attrID) do
        local temp = {}
        temp.attrId = v
        temp.valueRange = {}
        if v == 131 or v == 271 or v == 141 then
          for i, v in ipairs(string.split(recorder.valueRange[i], ";")) do
            temp.valueRange[i] = tostring(tonumber(v) / 10) .. "%"
          end
        else
          temp.valueRange = string.split(recorder.valueRange[i], ";")
        end
        temp.successfulRate = recorder.successfulRate[i]
        map[v] = temp
      end
      return map
    end
  end
  return {}
end

function Item:GetTypeName()
  return TextManager.GetText(self._classToloadRecord.nameTextID)
end

function Item:GetPinJiImage()
  return CImagePathTable:GetRecorder(self._pinJiRecord.imageDir) or DataCommon.DefaultImageAsset
end

function Item:GetPinJiImageAB()
  local record = self:GetPinJiImage()
  return record.assetBundle, record.assetName
end

function Item:GetShopPinJiBackGroundImage()
  return CImagePathTable:GetRecorder(self._pinJiRecord.shopBackground) or DataCommon.DefaultImageAsset
end

function Item:GetEquipStrengthenBackImg()
  return CImagePathTable:GetRecorder(self._pinJiRecord.equipStrengthenImageDir) or DataCommon.DefaultImageAsset
end

function Item:GetItemTipBackGroudImg()
  return CImagePathTable:GetRecorder(self._pinJiRecord.tipsBackground) or DataCommon.DefaultImageAsset
end

function Item:GetShopBuyBackGroudImg()
  return CImagePathTable:GetRecorder(self._pinJiRecord.buyBackground) or DataCommon.DefaultImageAsset
end

function Item:GetPinJiID()
  return self._pinJiRecord.id
end

function Item:GetItemTypeId()
  return self._itemRecord.itemtypeid
end

function Item:GetRank()
  return self._itemRecord.Rank
end

function Item:GetIcon()
  return CImagePathTable:GetRecorder(self._itemRecord.icon) or DataCommon.DefaultImageAsset
end

function Item:GetIconId()
  return self._itemRecord.icon
end

function Item:GetIconAB()
  local record = self:GetIcon()
  return record.assetBundle, record.assetName
end

function Item:GetDestribe()
  return TextManager.GetText(self._itemRecord.destribeTextID)
end

function Item:GetStack()
  return self._itemRecord.maxNum == 1
end

function Item:GetItemType()
  if self._itemtype then
    return self._itemtype
  elseif self._classToloadRecord.id == EquipTypeEnum.WEAPON or self._classToloadRecord.id == EquipTypeEnum.JEWELRY or self._classToloadRecord.id == EquipTypeEnum.ARMOR then
    return ItemTypeEnum.EQUIP
  elseif self._classToloadRecord.id == 315 then
    return ItemTypeEnum.SKILL
  else
    return ItemTypeEnum.BASEITEM
  end
end

function Item:IsUniqueEquip()
  return self._classToloadRecord.id == DataCommon.ItemType.UniqueEquip
end

function Item:IsDiamod()
  return self:GetID() == DataCommon.DiamodID
end

function Item:IsSoulDrop()
  return self:GetID() == DataCommon.SoulDropID
end

function Item:CanResolve()
  return self._itemRecord.resolvegetitem and #self._itemRecord.resolvegetitem > 0 and 0 < self._itemRecord.resolvegetitem[1]
end

function Item:GetResolveItemId()
  return self._itemRecord.resolvegetitem
end

function Item:GetResolveItemNum()
  return self._itemRecord.resolvegetitemnum
end

function Item:IsPageIndexShow(pageindex)
  return self._itemRecord.page == pageindex
end

function Item:GetGainWays()
  local list = {}
  for _, v in ipairs(self._itemRecord.access) do
    local temp1 = string.split(v, "@")
    local temp2 = string.split(temp1[2], ",")
    for i, v in ipairs(temp2) do
      temp2[i] = tonumber(v)
    end
    table.insert(list, {
      type = tonumber(temp1[1]),
      ways = temp2
    })
  end
  return list
end

function Item:SetDelTimeList(delList)
  self._delTimeList = delList
end

function Item:GetDelTime()
  if self._delTimeList then
    return self._delTimeList[1]
  end
end

function Item:GetDelTimeList()
  if self._delTimeList then
    return self._delTimeList
  end
end

function Item:GetTermTime()
  if self._itemRecord.timeLimited ~= 0 then
    local record = CTimeLimitedTtemTable:GetRecorder(self._itemId)
    if record.timeLimit ~= -1 then
      local minToSec = 60
      return record.timeLimit * minToSec - 1
    else
      local dayToSec = 86400
      return record.days * dayToSec - 1
    end
  end
  return 0
end

function Item:IsGuildDonateItem()
  local recorder = CDonateValue:GetRecorder(self:GetID())
  if recorder then
    return true
  end
  return false
end

function Item:GetDonationValueWeight()
  local recorder = CDonateValue:GetRecorder(self:GetID())
  if recorder then
    return recorder.itemvalue
  end
  return 0
end

return Item
