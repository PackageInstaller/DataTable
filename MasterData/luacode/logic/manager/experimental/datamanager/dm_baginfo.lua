local DM_BagInfo = class("DM_BagInfo")
local ItemTypeEnum = LuaNetManager.GetBeanDef("protocol.item.beans.item")
local EquipTypeEnum = LuaNetManager.GetBeanDef("protocol.item.equiptype")
local BagTypeEnum = LuaNetManager.GetBeanDef("protocol.item.beans.bagtypes")
local Item = require("logic.manager.experimental.types.item")
local Equip = require("logic.manager.experimental.types.equip")
local Skill = require("logic.manager.experimental.types.skill")
local FurnitureItem = require("logic.manager.experimental.types.furnitureitem")

function DM_BagInfo:Ctor()
  self._bagInfoData = NekoData.Data.baginfo
end

function DM_BagInfo:Clear()
  if self._bagInfoData then
    for k, v in pairs(self._bagInfoData) do
      self._bagInfoData[k] = nil
    end
  end
  self._bagInfoData.cachedPreFMKeyTable = nil
  self._bagInfoData.preFMLastLuckValueTable = nil
end

function DM_BagInfo:OnSEnter(protocol)
  self._bagInfoData.cachedPreFMKeyTable = {}
  self._bagInfoData.preFMLastLuckValueTable = {}
  self._userid = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userid
  self._bagInfoData[self._userid] = {}
  local bagInfoData = self._bagInfoData[self._userid]
  local item
  for type, bagInfo in pairs(protocol.bags) do
    bagInfoData[type] = {
      capacity = bagInfo.capacity,
      items = {}
    }
    if type == BagTypeEnum.FURNITURE_BAG then
      for i, value in ipairs(bagInfo.items) do
        item = FurnitureItem.Create(value.id)
        item:InitWithFull(value)
        bagInfoData[type].items[value.key] = item
      end
    else
      for i, value in ipairs(bagInfo.items) do
        if value.itemtype == ItemTypeEnum.BASEITEM then
          item = Item.Create(value.id)
        elseif value.itemtype == ItemTypeEnum.EQUIP then
          item = Equip.Create(value.id)
        elseif value.itemtype == ItemTypeEnum.SKILL then
          item = Skill.Create(value.id)
        end
        item:InitWithFull(value)
        bagInfoData[type].items[value.key] = item
        if value.itemtype == ItemTypeEnum.EQUIP and #value.extra.preRandomEntry > 0 then
          item:SetPreRandomEntry(value.extra.preRandomEntry, value.extra.preFinalAttrRandomEntry)
          self._bagInfoData.cachedPreFMKeyTable[value.key] = true
        end
      end
    end
  end
end

function DM_BagInfo:OnSAddItem(protocol)
  local item
  local mydata = {}
  mydata.bagType = protocol.bagType
  mydata.data = protocol.data
  if mydata.bagType == BagTypeEnum.FURNITURE_BAG then
    for i, value in ipairs(mydata.data) do
      local item = self._bagInfoData[self._userid][mydata.bagType].items[value.key]
      if item then
        item:SetCount(value.number)
      else
        item = FurnitureItem.Create(value.id)
        item:InitWithFull(value)
        self._bagInfoData[self._userid][mydata.bagType].items[value.key] = item
      end
    end
  else
    for i, value in ipairs(mydata.data) do
      local item = self._bagInfoData[self._userid][mydata.bagType].items[value.key]
      if item then
        item:SetCount(value.number)
      else
        if value.itemtype == ItemTypeEnum.BASEITEM then
          item = Item.Create(value.id)
        elseif value.itemtype == ItemTypeEnum.EQUIP then
          item = Equip.Create(value.id)
        elseif value.itemtype == ItemTypeEnum.SKILL then
          item = Skill.Create(value.id)
        end
        item:InitWithFull(value)
        self._bagInfoData[self._userid][mydata.bagType].items[value.key] = item
      end
    end
  end
end

function DM_BagInfo:OnSRemoveItem(protocol)
  if not self._bagInfoData[self._userid] then
    LogErrorFormat("DM_BagInfo", "-- self._userid(DM_BagInfo:OnSEnter) = %s, userid = %s", self._userid, NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userid)
    return
  elseif not self._bagInfoData[self._userid][protocol.bagType] then
    LogErrorFormat("DM_BagInfo", "-- bagType = %s", protocol.bagType)
    return
  end
  self._bagInfoData[self._userid][protocol.bagType].items[protocol.itemKey] = nil
end

function DM_BagInfo:OnSModifyItemNum(protocol)
  self._bagInfoData[self._userid][protocol.bagType].items[protocol.itemKey]:SetCount(protocol.itemNum)
  if protocol.delTime then
    self._bagInfoData[self._userid][protocol.bagType].items[protocol.itemKey]:SetDelTimeList(protocol.delTime)
  end
end

function DM_BagInfo:OnSChangeEquipment(protocol)
  for equipKey, roleKey in pairs(protocol.equips) do
    local type
    if protocol.equipType[equipKey] == EquipTypeEnum.WEAPON then
      type = EquipTypeEnum.WEAPON
    end
    if protocol.equipType[equipKey] == EquipTypeEnum.JEWELRY then
      type = EquipTypeEnum.JEWELRY
    end
    if protocol.equipType[equipKey] == EquipTypeEnum.ARMOR then
      type = EquipTypeEnum.ARMOR
    end
    if type and self._bagInfoData[self._userid][BagTypeEnum.EQUIPBAG].items[equipKey] then
      self._bagInfoData[self._userid][BagTypeEnum.EQUIPBAG].items[equipKey]:SetRoleKey(roleKey)
    end
  end
end

function DM_BagInfo:OnSIdentifyEquip(protocol)
  local type = BagTypeEnum.EQUIPBAG
  self._bagInfoData[self._userid][type].items[protocol.equipKey]:SetExtraInof(protocol.info)
end

function DM_BagInfo:OnSEquipLevelUp(protocol)
  local type = BagTypeEnum.EQUIPBAG
  if self._bagInfoData[self._userid][type].items[protocol.equipKey] then
    self._bagInfoData[self._userid][type].items[protocol.equipKey]:SetStrengthenLevel(protocol.lv)
    self._bagInfoData[self._userid][type].items[protocol.equipKey]:SetEquipExp(protocol.exp)
    self._bagInfoData[self._userid][type].items[protocol.equipKey]:SetScore(protocol.power)
    self._bagInfoData[self._userid][type].items[protocol.equipKey]:SetFinalAttr(protocol.finalAttr)
  end
end

function DM_BagInfo:OnSEquipExpUp(protocol)
  local type = BagTypeEnum.EQUIPBAG
  if self._bagInfoData[self._userid][type].items[protocol.equipKey] then
    self._bagInfoData[self._userid][type].items[protocol.equipKey]:SetEquipExp(protocol.exp)
  end
end

function DM_BagInfo:OnSEquipBreak(protocol)
  local type = BagTypeEnum.EQUIPBAG
  if self._bagInfoData[self._userid][type].items[protocol.equipKey] then
    self._bagInfoData[self._userid][type].items[protocol.equipKey]:SetStage(protocol.stage)
  end
end

function DM_BagInfo:OnSChangeEquipAppendAttrs(protocol)
  local type = BagTypeEnum.EQUIPBAG
  if self._bagInfoData[self._userid][type].items[protocol.equipKey] then
    local recastAttrs = self._bagInfoData[self._userid][type].items[protocol.equipKey]:SetEquipRecastAttr({})
    self._bagInfoData[self._userid][type].items[protocol.equipKey]:SetEquipAdditionalAttr(protocol.appendAttr)
    self._bagInfoData[self._userid][type].items[protocol.equipKey]:SetScore(protocol.power)
  end
end

function DM_BagInfo:OnSLockEquip(protocol)
  local type = BagTypeEnum.EQUIPBAG
  if self._bagInfoData[self._userid][type].items[protocol.key] then
    self._bagInfoData[self._userid][type].items[protocol.key]:SetIsLocked(protocol.lock)
  end
end

function DM_BagInfo:OnSViewEquip(protocol)
  local type = BagTypeEnum.EQUIPBAG
  if self._bagInfoData[self._userid][type].items[protocol.key] then
    self._bagInfoData[self._userid][type].items[protocol.key]:SetIsChecked(protocol.viewDetails)
  end
end

function DM_BagInfo:OnSEnchantEquip(protocol)
  self._bagInfoData.cachedPreFMKeyTable[protocol.equipKey] = nil
  local type = BagTypeEnum.EQUIPBAG
  if self._bagInfoData[self._userid][type].items[protocol.equipKey] then
    self._bagInfoData[self._userid][type].items[protocol.equipKey]:SetScore(protocol.power)
    self._bagInfoData[self._userid][type].items[protocol.equipKey]:SetFinalAttr(protocol.finalAttr)
    self._bagInfoData[self._userid][type].items[protocol.equipKey]:SetRandomEntry(protocol.randomEntry, protocol.finalAttrEntry)
    self._bagInfoData[self._userid][type].items[protocol.equipKey]:SetRandomIndex(protocol.index)
    self._bagInfoData[self._userid][type].items[protocol.equipKey]:SetLuckValue(protocol.luck)
    self._bagInfoData[self._userid][type].items[protocol.equipKey]:SetIsEnchanted(true)
  end
end

function DM_BagInfo:OnSPreviewEquipAttrs(protocol)
  local type = BagTypeEnum.EQUIPBAG
  if self._bagInfoData[self._userid][type].items[protocol.key] then
    self._bagInfoData[self._userid][type].items[protocol.key]:SetPreviewStrengthAttr(protocol.lvAttrs)
  end
end

function DM_BagInfo:OnSPreEnchantEquip(protocol)
  local type = BagTypeEnum.EQUIPBAG
  if self._bagInfoData[self._userid][type].items[protocol.equipKey] then
    self._bagInfoData[self._userid][type].items[protocol.equipKey]:SetLuckValue(protocol.luck)
    self._bagInfoData[self._userid][type].items[protocol.equipKey]:SetFMRequiredMana(protocol.nextCostMaNa)
  end
end

function DM_BagInfo:OnSDecomposeEquips(protocol)
  if not self._bagInfoData[self._userid] then
    LogErrorFormat("DM_BagInfo", "-- self._userid(DM_BagInfo:OnSEnter) = %s, userid = %s", self._userid, NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userid)
    return
  elseif not self._bagInfoData[self._userid][BagTypeEnum.EQUIPBAG] then
    LogErrorFormat("DM_BagInfo", "-- bagType = %s", BagTypeEnum.EQUIPBAG)
    return
  end
  for i, equipKey in ipairs(protocol.equipKeys) do
    self._bagInfoData[self._userid][BagTypeEnum.EQUIPBAG].items[equipKey] = nil
  end
end

function DM_BagInfo:OnSEquipGemInlay(protocol)
  local type = BagTypeEnum.EQUIPBAG
  if self._bagInfoData[self._userid][type].items[protocol.equipKey] then
    self._bagInfoData[self._userid][type].items[protocol.equipKey]:SetGemInfo(protocol.pos, protocol.gemId, protocol.suitId)
    self._bagInfoData[self._userid][type].items[protocol.equipKey]:SetScore(protocol.power)
  end
end

return DM_BagInfo
