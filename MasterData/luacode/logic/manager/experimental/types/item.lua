-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/types/item.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CItemAttrTable = (BeanManager.GetTableByName)("item.citemattr")
local CItemPinJiTable = (BeanManager.GetTableByName)("item.citempinji")
local CMaterialItemTable = (BeanManager.GetTableByName)("item.cmaterialitem")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CItemClassToLoadTable = (BeanManager.GetTableByName)("item.citemclasstoload")
local CTimeLimitedTtemTable = (BeanManager.GetTableByName)("item.ctimelimiteditem")
local CstringTable = (BeanManager.GetTableByName)("message.cstringres")
local CEquipStrengthenItemTable = (BeanManager.GetTableByName)("equip.cequipstrengthenitem")
local CEquipEnchantItemTable = (BeanManager.GetTableByName)("equip.cequipenchantitem")
local CDonateValue = (BeanManager.GetTableByName)("guild.cdonatevalue")
local EquipTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.equiptype")
local ItemTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.item")
local Item = strictclass("Item")
Item.Ctor = function(self, id)
  -- function num : 0_0 , upvalues : CItemAttrTable, CItemPinJiTable, CItemClassToLoadTable, _ENV
  self._itemId = id
  self._itemKey = 0
  self._count = 1
  self._delTimeList = nil
  self._itemRecord = CItemAttrTable:GetRecorder(self._itemId)
  if self._itemRecord then
    self._pinJiRecord = CItemPinJiTable:GetRecorder((self._itemRecord).pinJi)
    self._classToloadRecord = CItemClassToLoadTable:GetRecorder((self._itemRecord).itemtypeid)
  else
    LogErrorFormat("Item", "item with id %s is not exist in citemattr", self._itemId)
  end
end

Item.InitWithFull = function(self, iteminfo)
  -- function num : 0_1
  if iteminfo then
    self._itemtype = iteminfo.itemtype
    self._itemKey = iteminfo.key
    self._count = iteminfo.number
    self._delTimeList = iteminfo.delTime
  end
end

Item.InitWithItemInfo = function(self, iteminfo)
  -- function num : 0_2
  if iteminfo then
    self._itemtype = iteminfo.itemtype
    self._count = iteminfo.number
    self._delTimeList = iteminfo.delTime
  end
end

Item.IsGained = function(self)
  -- function num : 0_3
  do return not self._itemKey or self._itemKey ~= 0 end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

Item.Clone = function(self)
  -- function num : 0_4 , upvalues : _ENV
  return clone(self)
end

Item.GetItemAttr = function(self)
  -- function num : 0_5
  return self._itemRecord
end

Item.GetID = function(self)
  -- function num : 0_6
  return self._itemId
end

Item.SetKey = function(self, key)
  -- function num : 0_7
  self._itemKey = key
end

Item.GetKey = function(self)
  -- function num : 0_8
  return self._itemKey
end

Item.SetCount = function(self, count)
  -- function num : 0_9
  self._count = count
end

Item.GetCount = function(self)
  -- function num : 0_10
  return self._count
end

Item.IfEvolutionItem = function(self)
  -- function num : 0_11 , upvalues : CMaterialItemTable
  local c = CMaterialItemTable:GetRecorder(self._itemId)
  if c.ifEvolutionItem ~= 1 then
    do return not c end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

Item.GetName = function(self)
  -- function num : 0_12 , upvalues : _ENV
  return (TextManager.GetText)((self._itemRecord).nameTextID)
end

Item.IsStrengthenItem = function(self)
  -- function num : 0_13 , upvalues : CEquipStrengthenItemTable
  local recorder = CEquipStrengthenItemTable:GetRecorder(self._itemId)
  if recorder then
    return true
  end
  return false
end

Item.GetSupplyExp = function(self)
  -- function num : 0_14 , upvalues : CEquipStrengthenItemTable
  local recorder = CEquipStrengthenItemTable:GetRecorder(self._itemId)
  if recorder then
    return recorder.Exp
  end
  return nil
end

Item.IsEnchantItem = function(self)
  -- function num : 0_15 , upvalues : CEquipEnchantItemTable
  local allIds = CEquipEnchantItemTable:GetAllIds()
  for i = 1, #allIds do
    local recorder = CEquipEnchantItemTable:GetRecorder(allIds[i])
    if recorder.id == self._itemId then
      return true
    end
  end
  return false
end

Item.GetNeedManaByEnchantItem = function(self)
  -- function num : 0_16 , upvalues : CEquipEnchantItemTable
  local allIds = CEquipEnchantItemTable:GetAllIds()
  for i = 1, #allIds do
    local recorder = CEquipEnchantItemTable:GetRecorder(allIds[i])
    if recorder.id == self._itemId then
      return recorder.needMana
    end
  end
  return 0
end

Item.GetEnchantAttrs = function(self)
  -- function num : 0_17 , upvalues : CEquipEnchantItemTable, _ENV
  local map = {}
  local allIds = CEquipEnchantItemTable:GetAllIds()
  for i = 1, #allIds do
    local recorder = CEquipEnchantItemTable:GetRecorder(allIds[i])
    if recorder.id == self._itemId then
      for i,v in ipairs(recorder.attrID) do
        local temp = {}
        temp.attrId = v
        temp.valueRange = {}
        if v == 131 or v == 271 or v == 141 then
          for i,v in ipairs((string.split)((recorder.valueRange)[i], ";")) do
            -- DECOMPILER ERROR at PC48: Confused about usage of register: R19 in 'UnsetPending'

            (temp.valueRange)[i] = tostring(tonumber(v) / 10) .. "%"
          end
        else
          do
            do
              temp.valueRange = (string.split)((recorder.valueRange)[i], ";")
              temp.successfulRate = (recorder.successfulRate)[i]
              map[v] = temp
              -- DECOMPILER ERROR at PC63: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC63: LeaveBlock: unexpected jumping out IF_ELSE_STMT

              -- DECOMPILER ERROR at PC63: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
      return map
    end
  end
  return {}
end

Item.GetTypeName = function(self)
  -- function num : 0_18 , upvalues : _ENV
  return (TextManager.GetText)((self._classToloadRecord).nameTextID)
end

Item.GetPinJiImage = function(self)
  -- function num : 0_19 , upvalues : CImagePathTable, _ENV
  if not CImagePathTable:GetRecorder((self._pinJiRecord).imageDir) then
    return DataCommon.DefaultImageAsset
  end
end

Item.GetPinJiImageAB = function(self)
  -- function num : 0_20
  local record = self:GetPinJiImage()
  return record.assetBundle, record.assetName
end

Item.GetShopPinJiBackGroundImage = function(self)
  -- function num : 0_21 , upvalues : CImagePathTable, _ENV
  if not CImagePathTable:GetRecorder((self._pinJiRecord).shopBackground) then
    return DataCommon.DefaultImageAsset
  end
end

Item.GetEquipStrengthenBackImg = function(self)
  -- function num : 0_22 , upvalues : CImagePathTable, _ENV
  if not CImagePathTable:GetRecorder((self._pinJiRecord).equipStrengthenImageDir) then
    return DataCommon.DefaultImageAsset
  end
end

Item.GetItemTipBackGroudImg = function(self)
  -- function num : 0_23 , upvalues : CImagePathTable, _ENV
  if not CImagePathTable:GetRecorder((self._pinJiRecord).tipsBackground) then
    return DataCommon.DefaultImageAsset
  end
end

Item.GetShopBuyBackGroudImg = function(self)
  -- function num : 0_24 , upvalues : CImagePathTable, _ENV
  if not CImagePathTable:GetRecorder((self._pinJiRecord).buyBackground) then
    return DataCommon.DefaultImageAsset
  end
end

Item.GetPinJiID = function(self)
  -- function num : 0_25
  return (self._pinJiRecord).id
end

Item.GetItemTypeId = function(self)
  -- function num : 0_26
  return (self._itemRecord).itemtypeid
end

Item.GetRank = function(self)
  -- function num : 0_27
  return (self._itemRecord).Rank
end

Item.GetIcon = function(self)
  -- function num : 0_28 , upvalues : CImagePathTable, _ENV
  if not CImagePathTable:GetRecorder((self._itemRecord).icon) then
    return DataCommon.DefaultImageAsset
  end
end

Item.GetIconId = function(self)
  -- function num : 0_29
  return (self._itemRecord).icon
end

Item.GetIconAB = function(self)
  -- function num : 0_30
  local record = self:GetIcon()
  return record.assetBundle, record.assetName
end

Item.GetDestribe = function(self)
  -- function num : 0_31 , upvalues : _ENV
  return (TextManager.GetText)((self._itemRecord).destribeTextID)
end

Item.GetStack = function(self)
  -- function num : 0_32
  do return (self._itemRecord).maxNum == 1 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Item.GetItemType = function(self)
  -- function num : 0_33 , upvalues : EquipTypeEnum, ItemTypeEnum
  if self._itemtype then
    return self._itemtype
  else
    if (self._classToloadRecord).id == EquipTypeEnum.WEAPON or (self._classToloadRecord).id == EquipTypeEnum.JEWELRY or (self._classToloadRecord).id == EquipTypeEnum.ARMOR then
      return ItemTypeEnum.EQUIP
    else
      if (self._classToloadRecord).id == 315 then
        return ItemTypeEnum.SKILL
      else
        return ItemTypeEnum.BASEITEM
      end
    end
  end
end

Item.IsUniqueEquip = function(self)
  -- function num : 0_34 , upvalues : _ENV
  do return (self._classToloadRecord).id == (DataCommon.ItemType).UniqueEquip end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Item.IsDiamod = function(self)
  -- function num : 0_35 , upvalues : _ENV
  do return self:GetID() == DataCommon.DiamodID end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Item.IsSoulDrop = function(self)
  -- function num : 0_36 , upvalues : _ENV
  do return self:GetID() == DataCommon.SoulDropID end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Item.CanResolve = function(self)
  -- function num : 0_37
  do return not (self._itemRecord).resolvegetitem or (#(self._itemRecord).resolvegetitem > 0 and ((self._itemRecord).resolvegetitem)[1] > 0) end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

Item.GetResolveItemId = function(self)
  -- function num : 0_38
  return (self._itemRecord).resolvegetitem
end

Item.GetResolveItemNum = function(self)
  -- function num : 0_39
  return (self._itemRecord).resolvegetitemnum
end

Item.IsPageIndexShow = function(self, pageindex)
  -- function num : 0_40
  do return (self._itemRecord).page == pageindex end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Item.GetGainWays = function(self)
  -- function num : 0_41 , upvalues : _ENV
  local list = {}
  for _,v in ipairs((self._itemRecord).access) do
    local temp1 = (string.split)(v, "@")
    local temp2 = (string.split)(temp1[2], ",")
    for i,v in ipairs(temp2) do
      temp2[i] = tonumber(v)
    end
    ;
    (table.insert)(list, {type = tonumber(temp1[1]), ways = temp2})
  end
  return list
end

Item.SetDelTimeList = function(self, delList)
  -- function num : 0_42
  self._delTimeList = delList
end

Item.GetDelTime = function(self)
  -- function num : 0_43
  if self._delTimeList then
    return (self._delTimeList)[1]
  end
end

Item.GetDelTimeList = function(self)
  -- function num : 0_44
  if self._delTimeList then
    return self._delTimeList
  end
end

Item.GetTermTime = function(self)
  -- function num : 0_45 , upvalues : CTimeLimitedTtemTable
  if (self._itemRecord).timeLimited ~= 0 then
    local record = CTimeLimitedTtemTable:GetRecorder(self._itemId)
    if record.timeLimit ~= -1 then
      local minToSec = 60
      return record.timeLimit * minToSec - 1
    else
      do
        do
          local dayToSec = 86400
          do return record.days * dayToSec - 1 end
          return 0
        end
      end
    end
  end
end

Item.IsGuildDonateItem = function(self)
  -- function num : 0_46 , upvalues : CDonateValue
  local recorder = CDonateValue:GetRecorder(self:GetID())
  if recorder then
    return true
  end
  return false
end

Item.GetDonationValueWeight = function(self)
  -- function num : 0_47 , upvalues : CDonateValue
  local recorder = CDonateValue:GetRecorder(self:GetID())
  if recorder then
    return recorder.itemvalue
  end
  return 0
end

return Item

