local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CEquipSuitTable = BeanManager.GetTableByName("equip.cequipsuitcfg")
local CVocationCfgTable = BeanManager.GetTableByName("role.cvocationcfg")
local CEquipItemTable = BeanManager.GetTableByName("item.cequipitem")
local CEquipStrengthenTable = BeanManager.GetTableByName("equip.cequipstrengthencfg")
local CEquipStrengthenItemTable = BeanManager.GetTableByName("equip.cequipstrengthenitem")
local Cequipbreakcfg = BeanManager.GetTableByName("equip.cequipbreakcfg")
local CEquipSuit = BeanManager.GetTableByName("equip.cequipsuit")
local CEquipBreakStar = BeanManager.GetTableByName("equip.cequipbreakstar")
local CGemTable = BeanManager.GetTableByName("item.cbaoshi")
local CGemSuitTable = BeanManager.GetTableByName("equip.cbaoshisuit")
local Item = require("logic.manager.experimental.types.item")
local ItemEnum = LuaNetManager.GetBeanDef("protocol.item.beans.item")
local Equip = strictclass("Equip", Item)

function Equip:Ctor(id)
  Equip.super.Ctor(self, id)
  self._equipItemRecord = CEquipItemTable:GetRecorder(self._itemId)
end

function Equip:InitWithFull(iteminfo)
  if iteminfo then
    Equip.super.InitWithFull(self, iteminfo)
    self._equipType = iteminfo.extra.equipType
    self._level = iteminfo.extra.level
    self._stage = iteminfo.extra.stage
    self._exp = iteminfo.extra.exp
    self._power = iteminfo.extra.power
    self._baseAttr = iteminfo.extra.baseAttr
    self._finalAttr = iteminfo.extra.finalAttr
    self._attrGrowth = iteminfo.extra.range
    self._recommend = iteminfo.extra.recommend
    self._gems = iteminfo.extra.gems
    self._gemSuitId = iteminfo.extra.gemSuitId
    for k, v in pairs(self._baseAttr) do
      if k ~= 20 and k ~= 30 and k ~= 50 and k ~= 60 and k ~= 130 and k ~= 140 then
        self._baseAttr[k] = nil
      end
    end
    for k, v in pairs(self._finalAttr) do
      if k ~= 20 and k ~= 30 and k ~= 50 and k ~= 60 and k ~= 130 and k ~= 140 then
        self._finalAttr[k] = nil
      end
    end
    self._randomEntry = nil
    self._preRandomEntry = {}
    self:SetRandomEntry(iteminfo.extra.randomEntry, iteminfo.extra.finalAttrRandomEntry)
    self._luck = iteminfo.extra.luck
    self._randomIndex = 1
    self._roleId = iteminfo.extra.roleId
    self._lock = iteminfo.flags and iteminfo.flags & ItemEnum.LOCK == ItemEnum.LOCK
    self._viewDetails = iteminfo.extra.viewDetails
    self._fmRequiredMana = iteminfo.extra.nextEnchantCost
    self._enchant = iteminfo.extra.enchant
  end
end

function Equip:InitWithItemInfo(iteminfo)
  if iteminfo then
    Equip.super.InitWithItemInfo(self, iteminfo)
  end
end

function Equip:Clone()
  return clone(self)
end

function Equip:SetIsLocked(lock)
  self._lock = lock == 1
end

function Equip:IsLocked()
  return self._lock
end

function Equip:SetIsChecked(viewDetails)
  self._viewDetails = viewDetails
end

function Equip:IsChecked()
  return self._viewDetails == 1
end

function Equip:SetExtraInof(info)
  self._equipType = info.equipType
  self._level = info.level
  self._stage = iteminfo.extra.stage
  self._exp = info.exp
  self._power = info.power
  self._baseAttr = info.baseAttr
  for k, v in pairs(self._baseAttr) do
    if k ~= 20 and k ~= 30 and k ~= 50 and k ~= 60 and k ~= 130 and k ~= 140 then
      self._baseAttr[k] = nil
    end
  end
  self._finalAttr = info.finalAttr
  for k, v in pairs(self._finalAttr) do
    if k ~= 20 and k ~= 30 and k ~= 50 and k ~= 60 and k ~= 130 and k ~= 140 then
      self._finalAttr[k] = nil
    end
  end
  self._randomEntry = iteminfo.extra.randomEntry
  self._randomIndex = iteminfo.extra.randomIndex
  self._roleId = info.roleKey
  self._lock = info.lock
  self._viewDetails = info.viewDetails
  self._attrGrowth = info.range
  self._recommend = info.recommend
  self._gems = info.gems
  self._gemSuitId = info.gemSuitId
end

function Equip:SetRoleKey(roleKey)
  self._roleId = roleKey
end

function Equip:GetRoleKey()
  return self._roleId
end

function Equip:GetEquipType()
  return self._equipType
end

function Equip:GetEquipAllAttrRange()
  local list = {}
  for i, v in ipairs(self._equipItemRecord.abilityID) do
    local temp = {}
    temp.attrId = v
    temp.valueRange = string.split(self._equipItemRecord.lookRange[i], "-")
    table.insert(list, temp)
  end
  table.sort(list, function(a, b)
    return a.attrId < b.attrId
  end)
  return list
end

function Equip:GetEquipAllAttrGrowthRange()
  local list = {}
  for i, v in ipairs(self._equipItemRecord.abilityID) do
    local temp = {}
    temp.attrId = v
    temp.growthRange = string.split(self._equipItemRecord.abilitylookRange[i], "-")
    table.insert(list, temp)
  end
  table.sort(list, function(a, b)
    return a.attrId < b.attrId
  end)
  return list
end

function Equip:GetLevelByExp(exp)
  local totalExp = 0
  local level = 0
  for _, lv in ipairs(CEquipStrengthenTable:GetAllIds()) do
    local record = CEquipStrengthenTable:GetRecorder(lv)
    local needExp = record.needExp[self:GetPinJiID()]
    if needExp == 0 then
      return lv - 1
    end
    totalExp = totalExp + needExp
    if exp < totalExp then
      return lv - 1
    end
    if exp == totalExp then
      return lv
    end
    level = lv
  end
  return level
end

function Equip:GetNeedManaByExp(addExp)
  local needMaNa = 0
  local needExp = CEquipStrengthenTable:GetRecorder(self._level + 1).needExp[self:GetPinJiID()] - self._exp
  local curLv = self._level
  if addExp >= needExp then
    while addExp >= needExp do
      local record = CEquipStrengthenTable:GetRecorder(curLv + 1)
      if needExp >= record.needExp[self:GetPinJiID()] then
        needMaNa = needMaNa + record.needMana[self:GetPinJiID()]
      else
        needMaNa = needMaNa + needExp / record.needExp[self:GetPinJiID()] * record.needMana[self:GetPinJiID()]
      end
      addExp = addExp - needExp
      curLv = curLv + 1
      if curLv >= self:GetMaxLevel() then
        addExp = 0
        break
      else
        local record = CEquipStrengthenTable:GetRecorder(curLv + 1)
        needExp = record.needExp[self:GetPinJiID()]
      end
    end
    if addExp ~= 0 then
      local record = CEquipStrengthenTable:GetRecorder(curLv + 1)
      needMaNa = needMaNa + addExp / needExp * record.needMana[self:GetPinJiID()]
    end
  else
    local record = CEquipStrengthenTable:GetRecorder(curLv + 1)
    needMaNa = needMaNa + addExp / record.needExp[self:GetPinJiID()] * record.needMana[self:GetPinJiID()]
  end
  return math.floor(needMaNa)
end

function Equip:GetTotalManaByExp(exp)
  local lv = self:GetLevelByExp(exp)
  local exp1 = self:GetExpByStrengthenLevel(lv)
  local needMana = 0
  for id = 2, lv do
    local record = CEquipStrengthenTable:GetRecorder(id)
    needMana = needMana + record.needMana[self:GetPinJiID()]
  end
  if lv == self:GetMaxLevel() and exp > exp1 then
    exp = exp1
  end
  if 0 < exp - exp1 then
    local record = CEquipStrengthenTable:GetRecorder(lv + 1)
    if record then
      needMana = needMana + math.floor((exp - exp1) / record.needExp[self:GetPinJiID()] * record.needMana[self:GetPinJiID()])
    end
  end
  return needMana
end

function Equip:SetStrengthenLevel(level)
  self._level = level
end

function Equip:GetStrengthenLevel()
  return self._level
end

function Equip:GetStrengthenMaxLevel()
  return self:GetMaxLevel()
end

function Equip:GetExpByStrengthenLevel(level)
  if level == 1 then
    return 0
  else
    local exp = 0
    for id = 2, level do
      local record = CEquipStrengthenTable:GetRecorder(id)
      exp = exp + record.needExp[self:GetPinJiID()]
    end
    return exp
  end
end

function Equip:GetNeedExpByStrengthenLevel(level)
  if level == 1 then
    return 0
  else
    local record = CEquipStrengthenTable:GetRecorder(level)
    return record.needExp[self:GetPinJiID()]
  end
end

function Equip:GetExpByMaxStrengthenLevel()
  local maxExp = 0
  for id = 2, self:GetMaxLevel() do
    local record = CEquipStrengthenTable:GetRecorder(id)
    maxExp = maxExp + record.needExp[self:GetPinJiID()]
  end
  return maxExp
end

function Equip:IsMaxStrengthenLevel()
  return self._level >= self:GetMaxLevel()
end

function Equip:GetStrengthenType()
  return self:GetPinJiID()
end

function Equip:GetMaxExpByStrengthenLevel()
  local maxExp = 0
  for id = 2, self._level do
    local record = CEquipStrengthenTable:GetRecorder(id)
    maxExp = maxExp + record.needExp[self:GetPinJiID()]
  end
  return maxExp
end

function Equip:SetEquipExp(exp)
  self._exp = exp
end

function Equip:GetEquipExp()
  return self._exp
end

function Equip:GetEquipTotalExp()
  if self._level == 1 then
    return self._exp
  else
    local exp = self._exp
    for id = 2, self._level do
      local record = CEquipStrengthenTable:GetRecorder(id)
      exp = exp + record.needExp[self:GetPinJiID()]
    end
    return exp
  end
end

function Equip:SetScore(score)
  self._power = score
end

function Equip:GetScore()
  return self._power
end

function Equip:GetEquipMainAttr()
  return self._baseAttr
end

function Equip:GetAttrGrowth()
  return self._attrGrowth
end

function Equip:GetRecommend()
  return self._recommend
end

function Equip:GetSettingGems()
  return self._gems
end

function Equip:GetGemSuitId()
  return self._gemSuitId
end

function Equip:SetGemInfo(pos, gemid, suitId)
  self._gems[pos] = gemid
  self._gemSuitId = suitId
end

function Equip:GetGemAttr()
  local attr = {}
  for pos = 1, 3 do
    local gemID = self._gems[pos]
    if gemID and 0 < gemID then
      local gemCfg = CGemTable:GetRecorder(gemID)
      local num = attr[gemCfg.attrid] or 0
      attr[gemCfg.attrid] = num + gemCfg.attrnum
    end
  end
  return attr
end

function Equip:GetGemSuitAttrRate(attrid)
  if self._gemSuitId == 0 then
    return 0
  end
  local gemSuitCfg = CGemSuitTable:GetRecorder(self._gemSuitId)
  for i = 1, 4 do
    if gemSuitCfg.attrID[i] == attrid or gemSuitCfg.attrID[i] == 0 then
      return gemSuitCfg.addrnum[i] / 100
    end
  end
  return 0
end

function Equip:SetPreviewStrengthAttr(lvAttrs)
  self._strengthAttrPre = lvAttrs
end

function Equip:GetPreviewStrengthAttrByLevel(lv)
  if not self._strengthAttrPre then
    return {}
  end
  return self._strengthAttrPre[lv].attrs
end

function Equip:SetRandomEntry(randomEntry, finalRandomEntry)
  self._randomEntry = {}
  for k, v in ipairs(randomEntry) do
    local data = v
    data.kind = 1
    table.insert(self._randomEntry, data)
  end
  if finalRandomEntry == nil or finalRandomEntry.attr == 0 then
    self._finalRandomEntry = nil
  else
    self._finalRandomEntry = finalRandomEntry
    self._finalRandomEntry.kind = 3
    table.insert(self._randomEntry, self._finalRandomEntry)
  end
end

function Equip:SetPreRandomEntry(preRandomEntry, preFinalRandomEntry)
  self._preRandomEntry = preRandomEntry
  self._preFinalRandomEntry = preFinalRandomEntry
end

function Equip:GetPreRandomEntry()
  return self._preRandomEntry, self._preFinalRandomEntry
end

function Equip:GetRandomEntry()
  return self._randomEntry
end

function Equip:GetFinalRandomEntry()
  return self._finalRandomEntry
end

function Equip:GetRandomAbility()
  return self._equipItemRecord.randomAbility
end

function Equip:GetEquipMaxHp()
  return self._finalAttr[20] or 0
end

function Equip:GetEquipATK()
  return self._finalAttr[30] or 0
end

function Equip:GetEquipMagAtk()
  return self._finalAttr[40] or 0
end

function Equip:GetEquipDef()
  return self._finalAttr[50] or 0
end

function Equip:GetEquipMagDef()
  return self._finalAttr[60] or 0
end

function Equip:SetFinalAttr(finalAttr)
  self._finalAttr = finalAttr
  for k, v in pairs(self._finalAttr) do
    if k ~= 20 and k ~= 30 and k ~= 50 and k ~= 60 and k ~= 130 and k ~= 140 then
      self._finalAttr[k] = nil
    end
  end
end

function Equip:GetAllAttr()
  return self._finalAttr
end

function Equip:GetLimitEquip()
  return self._equipItemRecord.equipAttrib
end

function Equip:GetApplyVocation()
  local record = CEquipSuitTable:GetRecorder(self._equipItemRecord.equipAttrib)
  return TextManager.GetText(record.txtid)
end

function Equip:GetEquipSuitShowType()
  local record = CEquipSuitTable:GetRecorder(self._equipItemRecord.equipAttrib)
  return record.showtype
end

function Equip:GetEquipSuitImage()
  local record = CEquipSuitTable:GetRecorder(self._equipItemRecord.equipAttrib)
  return CImagePathTable:GetRecorder(record.image) or DataCommon.DefaultImageAsset
end

function Equip:GetApplyVocationIcon()
  local vocationRecord = CVocationCfgTable:GetRecorder(self._equipItemRecord.equipAttrib)
  if vocationRecord then
    if self:GetPinJiID() <= 2 then
      return CImagePathTable:GetRecorder(vocationRecord.imgR)
    end
    if self:GetPinJiID() == 3 then
      return CImagePathTable:GetRecorder(vocationRecord.imgSR)
    end
    if self:GetPinJiID() == 4 then
      return CImagePathTable:GetRecorder(vocationRecord.imgSSR)
    end
  end
  return nil
end

function Equip:GetEquipLimitRoleIdList()
  local str = self._equipItemRecord.roleLimit
  local list = {}
  if str and str ~= "" then
    list = string.split(str, ";")
  end
  return list
end

function Equip:GetResolveItemInfo()
  local itemList = {}
  local items = {}
  for index, itemid in ipairs(self._itemRecord.resolvegetitem) do
    if 0 < itemid then
      itemList[itemid] = self._itemRecord.resolvegetitemnum[index]
    end
  end
  for pos = 1, 3 do
    local gemID = self._gems[pos]
    if 0 < gemID then
      local oldNum = itemList[gemID] or 0
      itemList[gemID] = oldNum + 1
    end
  end
  if self._level == 1 and self._exp == 0 then
    return itemList
  end
  local costExp = self:GetEquipTotalExp()
  local costMana = self:GetTotalManaByExp(costExp)
  local power = BeanManager.GetTableByName("equip.cequipspecialcfg"):GetRecorder(1).parameter
  local returnExp = math.floor(costExp * power / 100)
  local returnMana = math.floor(costMana * power / 100)
  local leftExp = returnExp
  local allIds = CEquipStrengthenItemTable:GetAllIds()
  for index = #allIds, 1, -1 do
    local record = CEquipStrengthenItemTable:GetRecorder(allIds[index])
    if record.decomposereturn == 1 then
      local num = math.floor(leftExp / record.Exp)
      if 0 < num then
        if not itemList[record.id] then
          itemList[record.id] = num
        else
          itemList[record.id] = itemList[record.id] + num
        end
        leftExp = leftExp - record.Exp * num
      end
    end
  end
  itemList[DataCommon.ManaID] = returnMana
  return itemList
end

function Equip:GetAttrGrowthValues()
  return self._equipItemRecord.abilityValue
end

function Equip:SetStage(stage)
  self._stage = stage
end

function Equip:GetStage()
  return self._stage
end

function Equip:GetMaxLevel()
  local equipBreakCfgAllId = Cequipbreakcfg:GetAllIds()
  local maxLevel
  for i, value in ipairs(equipBreakCfgAllId) do
    local equipBreakCfgRecorder = Cequipbreakcfg:GetRecorder(value)
    if equipBreakCfgRecorder.pinJi == self:GetPinJiID() and equipBreakCfgRecorder.breaklv == self:GetStage() then
      maxLevel = equipBreakCfgRecorder.levelmax
    end
  end
  return maxLevel
end

function Equip:GetBreakMaxLevel()
  local equipBreakCfgAllId = Cequipbreakcfg:GetAllIds()
  local maxLevel
  for i, value in ipairs(equipBreakCfgAllId) do
    local equipBreakCfgRecorder = Cequipbreakcfg:GetRecorder(value)
    if equipBreakCfgRecorder.pinJi == self:GetPinJiID() and equipBreakCfgRecorder.breaklv == self:GetStage() + 1 then
      maxLevel = equipBreakCfgRecorder.levelmax
      return maxLevel
    end
  end
  return nil
end

function Equip:GetBreaKNeedMana()
  local equipBreakCfgAllId = Cequipbreakcfg:GetAllIds()
  local mana
  for i, value in ipairs(equipBreakCfgAllId) do
    local equipBreakCfgRecorder = Cequipbreakcfg:GetRecorder(value)
    if equipBreakCfgRecorder.pinJi == self:GetPinJiID() and equipBreakCfgRecorder.breaklv == self:GetStage() then
      mana = equipBreakCfgRecorder.manaCost
      return mana
    end
  end
end

function Equip:GetNextBreakMultiple()
  local equipBreakCfgAllId = Cequipbreakcfg:GetAllIds()
  local breakMultiple = 0
  for i, value in ipairs(equipBreakCfgAllId) do
    local equipBreakCfgRecorder = Cequipbreakcfg:GetRecorder(value)
    if equipBreakCfgRecorder.pinJi == self:GetPinJiID() and equipBreakCfgRecorder.breaklv <= self:GetStage() then
      breakMultiple = breakMultiple + equipBreakCfgRecorder.breakMultiple
    end
  end
  return breakMultiple
end

function Equip:GetCurrentBreakMultiple()
  if self:GetStage() == 0 or self:GetStage() == nil then
    return 0
  end
  local equipBreakCfgAllId = Cequipbreakcfg:GetAllIds()
  local breakMultiple = 0
  for i, value in ipairs(equipBreakCfgAllId) do
    local equipBreakCfgRecorder = Cequipbreakcfg:GetRecorder(value)
    if equipBreakCfgRecorder.pinJi == self:GetPinJiID() and equipBreakCfgRecorder.breaklv <= self:GetStage() - 1 then
      breakMultiple = breakMultiple + equipBreakCfgRecorder.breakMultiple
    end
  end
  return breakMultiple
end

function Equip:GetLastBreakMultiple()
  if self:GetStage() <= 1 then
    return 0
  end
  local equipBreakCfgAllId = Cequipbreakcfg:GetAllIds()
  local breakMultiple = 0
  for i, value in ipairs(equipBreakCfgAllId) do
    local equipBreakCfgRecorder = Cequipbreakcfg:GetRecorder(value)
    if equipBreakCfgRecorder.pinJi == self:GetPinJiID() and equipBreakCfgRecorder.breaklv <= self:GetStage() - 2 then
      breakMultiple = breakMultiple + equipBreakCfgRecorder.breakMultiple
    end
  end
  return breakMultiple
end

function Equip:GetBreaKNeedMaterials()
  local equipBreakCfgAllId = Cequipbreakcfg:GetAllIds()
  local materials = {}
  for i, value in ipairs(equipBreakCfgAllId) do
    local equipBreakCfgRecorder = Cequipbreakcfg:GetRecorder(value)
    if equipBreakCfgRecorder.pinJi == self:GetPinJiID() and equipBreakCfgRecorder.breaklv == self:GetStage() then
      materials = equipBreakCfgRecorder.itemId
      return materials
    end
  end
end

function Equip:GetBreaKNeedMaterialsCount()
  local equipBreakCfgAllId = Cequipbreakcfg:GetAllIds()
  local MaterialsCount = {}
  for i, value in ipairs(equipBreakCfgAllId) do
    local equipBreakCfgRecorder = Cequipbreakcfg:GetRecorder(value)
    if equipBreakCfgRecorder.pinJi == self:GetPinJiID() and equipBreakCfgRecorder.breaklv == self:GetStage() then
      MaterialsCount = equipBreakCfgRecorder.itemNum
      return MaterialsCount
    end
  end
end

function Equip:GetBreaKNeedEquipsCount()
  local equipBreakCfgAllId = Cequipbreakcfg:GetAllIds()
  local count
  for i, value in ipairs(equipBreakCfgAllId) do
    local equipBreakCfgRecorder = Cequipbreakcfg:GetRecorder(value)
    if equipBreakCfgRecorder.pinJi == self:GetPinJiID() and equipBreakCfgRecorder.breaklv == self:GetStage() then
      count = equipBreakCfgRecorder.materialEquipNum
      return count
    end
  end
end

function Equip:GetBreaKNeedEquipsPinji()
  local equipBreakCfgAllId = Cequipbreakcfg:GetAllIds()
  local pinji
  for i, value in ipairs(equipBreakCfgAllId) do
    local equipBreakCfgRecorder = Cequipbreakcfg:GetRecorder(value)
    if equipBreakCfgRecorder.pinJi == self:GetPinJiID() and equipBreakCfgRecorder.breaklv == self:GetStage() then
      pinji = equipBreakCfgRecorder.materialEquipPinji
      return pinji
    end
  end
end

function Equip:GetBreaKLimitTimes()
  local equipBreakCfgAllId = Cequipbreakcfg:GetAllIds()
  local pinji
  local limitTimes = 0
  for i, value in ipairs(equipBreakCfgAllId) do
    local equipBreakCfgRecorder = Cequipbreakcfg:GetRecorder(value)
    if equipBreakCfgRecorder.pinJi == self:GetPinJiID() and limitTimes < equipBreakCfgRecorder.breaklv then
      limitTimes = equipBreakCfgRecorder.breaklv
    end
  end
  return limitTimes
end

function Equip:GetRandomIndex()
  return self._randomIndex
end

function Equip:SetRandomIndex(randomIndex)
  self._randomIndex = randomIndex
end

function Equip:GetEquipAdditionalSkills()
  local temp = {}
  local recorder = CEquipSuit:GetRecorder(self._equipItemRecord.equipSuitid)
  if recorder then
    temp = recorder.suitSkillID
  end
  return temp
end

function Equip:GetLuckValue()
  return self._luck
end

function Equip:SetLuckValue(value)
  self._luck = value
end

function Equip:SetFMRequiredMana(mana)
  self._fmRequiredMana = mana
end

function Equip:GetFMRequiredMana(mana)
  return self._fmRequiredMana
end

function Equip:SetIsEnchanted(value)
  if value == true then
    self._enchant = 1
  else
    self._enchant = 0
  end
end

function Equip:GetIsEnchanted()
  return self._enchant == 1
end

function Equip:GetBagInfoBackPinJiImage()
  return CImagePathTable:GetRecorder(self._pinJiRecord.equipWorkshop) or DataCommon.DefaultImageAsset
end

function Equip:GetEquipSuitId()
  return self._equipItemRecord.equipSuitid
end

function Equip:GetEquipSuitRecorder()
  return CEquipSuit:GetRecorder(self._equipItemRecord.equipSuitid)
end

function Equip:GetEquipStarStr()
  if self:GetBreaKLimitTimes() == self._stage then
    return CEquipBreakStar:GetRecorder(self:GetPinJiID()).brokenstar
  else
    return CEquipBreakStar:GetRecorder(self:GetPinJiID()).star
  end
end

function Equip:GetEquipNotFullStarStr()
  return CEquipBreakStar:GetRecorder(self:GetPinJiID()).star
end

function Equip:GetEquipFullStarStr()
  return CEquipBreakStar:GetRecorder(self:GetPinJiID()).brokenstar
end

return Equip
