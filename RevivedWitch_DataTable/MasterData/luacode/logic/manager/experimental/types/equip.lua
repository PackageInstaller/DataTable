-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/types/equip.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CstringTable = (BeanManager.GetTableByName)("message.cstringres")
local CEquipSuitTable = (BeanManager.GetTableByName)("equip.cequipsuitcfg")
local CVocationCfgTable = (BeanManager.GetTableByName)("role.cvocationcfg")
local CEquipItemTable = (BeanManager.GetTableByName)("item.cequipitem")
local CEquipStrengthenTable = (BeanManager.GetTableByName)("equip.cequipstrengthencfg")
local CEquipStrengthenItemTable = (BeanManager.GetTableByName)("equip.cequipstrengthenitem")
local Cequipbreakcfg = (BeanManager.GetTableByName)("equip.cequipbreakcfg")
local CEquipSuit = (BeanManager.GetTableByName)("equip.cequipsuit")
local CEquipBreakStar = (BeanManager.GetTableByName)("equip.cequipbreakstar")
local Item = require("logic.manager.experimental.types.item")
local ItemEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.item")
local Equip = strictclass("Equip", Item)
Equip.Ctor = function(self, id)
  -- function num : 0_0 , upvalues : Equip, CEquipItemTable
  ((Equip.super).Ctor)(self, id)
  self._equipItemRecord = CEquipItemTable:GetRecorder(self._itemId)
end

Equip.InitWithFull = function(self, iteminfo)
  -- function num : 0_1 , upvalues : Equip, _ENV, ItemEnum
  if iteminfo then
    ((Equip.super).InitWithFull)(self, iteminfo)
    self._equipType = (iteminfo.extra).equipType
    self._level = (iteminfo.extra).level
    self._stage = (iteminfo.extra).stage
    self._exp = (iteminfo.extra).exp
    self._power = (iteminfo.extra).power
    self._baseAttr = (iteminfo.extra).baseAttr
    self._finalAttr = (iteminfo.extra).finalAttr
    self._attrGrowth = (iteminfo.extra).range
    self._recommend = (iteminfo.extra).recommend
    for k,v in pairs(self._baseAttr) do
      -- DECOMPILER ERROR at PC51: Confused about usage of register: R7 in 'UnsetPending'

      if k ~= 20 and k ~= 30 and k ~= 50 and k ~= 60 and k ~= 130 and k ~= 140 then
        (self._baseAttr)[k] = nil
      end
    end
    for k,v in pairs(self._finalAttr) do
      -- DECOMPILER ERROR at PC71: Confused about usage of register: R7 in 'UnsetPending'

      if k ~= 20 and k ~= 30 and k ~= 50 and k ~= 60 and k ~= 130 and k ~= 140 then
        (self._finalAttr)[k] = nil
      end
    end
    self._randomEntry = nil
    self._preRandomEntry = {}
    self:SetRandomEntry((iteminfo.extra).randomEntry, (iteminfo.extra).finalAttrRandomEntry)
    self._luck = (iteminfo.extra).luck
    self._randomIndex = 1
    self._roleId = (iteminfo.extra).roleId
    self._lock = not iteminfo.flags or iteminfo.flags & ItemEnum.LOCK == ItemEnum.LOCK
    self._viewDetails = (iteminfo.extra).viewDetails
    self._fmRequiredMana = (iteminfo.extra).nextEnchantCost
    self._enchant = (iteminfo.extra).enchant
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

Equip.InitWithItemInfo = function(self, iteminfo)
  -- function num : 0_2 , upvalues : Equip
  if iteminfo then
    ((Equip.super).InitWithItemInfo)(self, iteminfo)
  end
end

Equip.Clone = function(self)
  -- function num : 0_3 , upvalues : _ENV
  return clone(self)
end

Equip.SetIsLocked = function(self, lock)
  -- function num : 0_4
  self._lock = lock == 1
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Equip.IsLocked = function(self)
  -- function num : 0_5
  return self._lock
end

Equip.SetIsChecked = function(self, viewDetails)
  -- function num : 0_6
  self._viewDetails = viewDetails
end

Equip.IsChecked = function(self)
  -- function num : 0_7
  do return self._viewDetails == 1 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Equip.SetExtraInof = function(self, info)
  -- function num : 0_8 , upvalues : _ENV
  self._equipType = info.equipType
  self._level = info.level
  self._stage = (iteminfo.extra).stage
  self._exp = info.exp
  self._power = info.power
  self._baseAttr = info.baseAttr
  for k,v in pairs(self._baseAttr) do
    -- DECOMPILER ERROR at PC31: Confused about usage of register: R7 in 'UnsetPending'

    if k ~= 20 and k ~= 30 and k ~= 50 and k ~= 60 and k ~= 130 and k ~= 140 then
      (self._baseAttr)[k] = nil
    end
  end
  self._finalAttr = info.finalAttr
  for k,v in pairs(self._finalAttr) do
    -- DECOMPILER ERROR at PC53: Confused about usage of register: R7 in 'UnsetPending'

    if k ~= 20 and k ~= 30 and k ~= 50 and k ~= 60 and k ~= 130 and k ~= 140 then
      (self._finalAttr)[k] = nil
    end
  end
  self._randomEntry = (iteminfo.extra).randomEntry
  self._randomIndex = (iteminfo.extra).randomIndex
  self._roleId = info.roleKey
  self._lock = info.lock
  self._viewDetails = info.viewDetails
  self._attrGrowth = info.range
  self._recommend = info.recommend
end

Equip.SetRoleKey = function(self, roleKey)
  -- function num : 0_9
  self._roleId = roleKey
end

Equip.GetRoleKey = function(self)
  -- function num : 0_10
  return self._roleId
end

Equip.GetEquipType = function(self)
  -- function num : 0_11
  return self._equipType
end

Equip.GetEquipAllAttrRange = function(self)
  -- function num : 0_12 , upvalues : _ENV
  local list = {}
  for i,v in ipairs((self._equipItemRecord).abilityID) do
    local temp = {}
    temp.attrId = v
    temp.valueRange = (string.split)(((self._equipItemRecord).lookRange)[i], "-")
    ;
    (table.insert)(list, temp)
  end
  ;
  (table.sort)(list, function(a, b)
    -- function num : 0_12_0
    do return a.attrId < b.attrId end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  return list
end

Equip.GetEquipAllAttrGrowthRange = function(self)
  -- function num : 0_13 , upvalues : _ENV
  local list = {}
  for i,v in ipairs((self._equipItemRecord).abilityID) do
    local temp = {}
    temp.attrId = v
    temp.growthRange = (string.split)(((self._equipItemRecord).abilitylookRange)[i], "-")
    ;
    (table.insert)(list, temp)
  end
  ;
  (table.sort)(list, function(a, b)
    -- function num : 0_13_0
    do return a.attrId < b.attrId end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  return list
end

Equip.GetLevelByExp = function(self, exp)
  -- function num : 0_14 , upvalues : _ENV, CEquipStrengthenTable
  local totalExp = 0
  local level = 0
  for _,lv in ipairs(CEquipStrengthenTable:GetAllIds()) do
    local record = CEquipStrengthenTable:GetRecorder(lv)
    local needExp = (record.needExp)[self:GetPinJiID()]
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

Equip.GetNeedManaByExp = function(self, addExp)
  -- function num : 0_15 , upvalues : CEquipStrengthenTable, _ENV
  local needMaNa = 0
  local needExp = ((CEquipStrengthenTable:GetRecorder(self._level + 1)).needExp)[self:GetPinJiID()] - self._exp
  local curLv = self._level
  while 1 do
    while 1 do
      if needExp <= addExp then
        if needExp <= addExp then
          local record = CEquipStrengthenTable:GetRecorder(curLv + 1)
          if (record.needExp)[self:GetPinJiID()] <= needExp then
            needMaNa = needMaNa + (record.needMana)[self:GetPinJiID()]
          else
            needMaNa = needMaNa + needExp / (record.needExp)[self:GetPinJiID()] * (record.needMana)[self:GetPinJiID()]
          end
          addExp = addExp - needExp
          curLv = curLv + 1
          if self:GetMaxLevel() <= curLv then
            addExp = 0
            -- DECOMPILER ERROR at PC52: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC52: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC52: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC52: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC52: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC52: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
    local record = CEquipStrengthenTable:GetRecorder(curLv + 1)
    needExp = (record.needExp)[self:GetPinJiID()]
  end
  do
    do
      if addExp ~= 0 then
        local record = CEquipStrengthenTable:GetRecorder(curLv + 1)
        needMaNa = needMaNa + addExp / needExp * (record.needMana)[self:GetPinJiID()]
      end
      do
        local record = CEquipStrengthenTable:GetRecorder(curLv + 1)
        needMaNa = needMaNa + addExp / (record.needExp)[self:GetPinJiID()] * (record.needMana)[self:GetPinJiID()]
        return (math.floor)(needMaNa)
      end
    end
  end
end

Equip.GetTotalManaByExp = function(self, exp)
  -- function num : 0_16 , upvalues : CEquipStrengthenTable, _ENV
  local lv = self:GetLevelByExp(exp)
  local exp1 = self:GetExpByStrengthenLevel(lv)
  local needMana = 0
  for id = 2, lv do
    local record = CEquipStrengthenTable:GetRecorder(id)
    needMana = needMana + (record.needMana)[self:GetPinJiID()]
  end
  if lv == self:GetMaxLevel() and exp1 < exp then
    exp = exp1
  end
  do
    if exp - exp1 > 0 then
      local record = CEquipStrengthenTable:GetRecorder(lv + 1)
      if record then
        needMana = needMana + (math.floor)((exp - exp1) / (record.needExp)[self:GetPinJiID()] * (record.needMana)[self:GetPinJiID()])
      end
    end
    return needMana
  end
end

Equip.SetStrengthenLevel = function(self, level)
  -- function num : 0_17
  self._level = level
end

Equip.GetStrengthenLevel = function(self)
  -- function num : 0_18
  return self._level
end

Equip.GetStrengthenMaxLevel = function(self)
  -- function num : 0_19
  return self:GetMaxLevel()
end

Equip.GetExpByStrengthenLevel = function(self, level)
  -- function num : 0_20 , upvalues : CEquipStrengthenTable
  if level == 1 then
    return 0
  else
    local exp = 0
    for id = 2, level do
      local record = CEquipStrengthenTable:GetRecorder(id)
      exp = exp + (record.needExp)[self:GetPinJiID()]
    end
    return exp
  end
end

Equip.GetNeedExpByStrengthenLevel = function(self, level)
  -- function num : 0_21 , upvalues : CEquipStrengthenTable
  if level == 1 then
    return 0
  else
    local record = CEquipStrengthenTable:GetRecorder(level)
    return (record.needExp)[self:GetPinJiID()]
  end
end

Equip.GetExpByMaxStrengthenLevel = function(self)
  -- function num : 0_22 , upvalues : CEquipStrengthenTable
  local maxExp = 0
  for id = 2, self:GetMaxLevel() do
    local record = CEquipStrengthenTable:GetRecorder(id)
    maxExp = maxExp + (record.needExp)[self:GetPinJiID()]
  end
  return maxExp
end

Equip.IsMaxStrengthenLevel = function(self)
  -- function num : 0_23
  do return self:GetMaxLevel() <= self._level end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Equip.GetStrengthenType = function(self)
  -- function num : 0_24
  return self:GetPinJiID()
end

Equip.GetMaxExpByStrengthenLevel = function(self)
  -- function num : 0_25 , upvalues : CEquipStrengthenTable
  local maxExp = 0
  for id = 2, self._level do
    local record = CEquipStrengthenTable:GetRecorder(id)
    maxExp = maxExp + (record.needExp)[self:GetPinJiID()]
  end
  return maxExp
end

Equip.SetEquipExp = function(self, exp)
  -- function num : 0_26
  self._exp = exp
end

Equip.GetEquipExp = function(self)
  -- function num : 0_27
  return self._exp
end

Equip.GetEquipTotalExp = function(self)
  -- function num : 0_28 , upvalues : CEquipStrengthenTable
  if self._level == 1 then
    return self._exp
  else
    local exp = self._exp
    for id = 2, self._level do
      local record = CEquipStrengthenTable:GetRecorder(id)
      exp = exp + (record.needExp)[self:GetPinJiID()]
    end
    return exp
  end
end

Equip.SetScore = function(self, score)
  -- function num : 0_29
  self._power = score
end

Equip.GetScore = function(self)
  -- function num : 0_30
  return self._power
end

Equip.GetEquipMainAttr = function(self)
  -- function num : 0_31
  return self._baseAttr
end

Equip.GetAttrGrowth = function(self)
  -- function num : 0_32
  return self._attrGrowth
end

Equip.GetRecommend = function(self)
  -- function num : 0_33
  return self._recommend
end

Equip.SetPreviewStrengthAttr = function(self, lvAttrs)
  -- function num : 0_34
  self._strengthAttrPre = lvAttrs
end

Equip.GetPreviewStrengthAttrByLevel = function(self, lv)
  -- function num : 0_35
  if not self._strengthAttrPre then
    return {}
  end
  return ((self._strengthAttrPre)[lv]).attrs
end

Equip.SetRandomEntry = function(self, randomEntry, finalRandomEntry)
  -- function num : 0_36 , upvalues : _ENV
  self._randomEntry = {}
  for k,v in ipairs(randomEntry) do
    local data = v
    data.kind = 1
    ;
    (table.insert)(self._randomEntry, data)
  end
  do
    if finalRandomEntry == nil or finalRandomEntry.attr == 0 then
      self._finalRandomEntry = nil
    else
      self._finalRandomEntry = finalRandomEntry
      -- DECOMPILER ERROR at PC24: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (self._finalRandomEntry).kind = 3
      ;
      (table.insert)(self._randomEntry, self._finalRandomEntry)
    end
  end
end

Equip.SetPreRandomEntry = function(self, preRandomEntry, preFinalRandomEntry)
  -- function num : 0_37
  self._preRandomEntry = preRandomEntry
  self._preFinalRandomEntry = preFinalRandomEntry
end

Equip.GetPreRandomEntry = function(self)
  -- function num : 0_38
  return self._preRandomEntry, self._preFinalRandomEntry
end

Equip.GetRandomEntry = function(self)
  -- function num : 0_39
  return self._randomEntry
end

Equip.GetFinalRandomEntry = function(self)
  -- function num : 0_40
  return self._finalRandomEntry
end

Equip.GetRandomAbility = function(self)
  -- function num : 0_41
  return (self._equipItemRecord).randomAbility
end

Equip.GetEquipMaxHp = function(self)
  -- function num : 0_42
  return (self._finalAttr)[20] or 0
end

Equip.GetEquipATK = function(self)
  -- function num : 0_43
  return (self._finalAttr)[30] or 0
end

Equip.GetEquipMagAtk = function(self)
  -- function num : 0_44
  return (self._finalAttr)[40] or 0
end

Equip.GetEquipDef = function(self)
  -- function num : 0_45
  return (self._finalAttr)[50] or 0
end

Equip.GetEquipMagDef = function(self)
  -- function num : 0_46
  return (self._finalAttr)[60] or 0
end

Equip.SetFinalAttr = function(self, finalAttr)
  -- function num : 0_47 , upvalues : _ENV
  self._finalAttr = finalAttr
  for k,v in pairs(self._finalAttr) do
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R7 in 'UnsetPending'

    if k ~= 20 and k ~= 30 and k ~= 50 and k ~= 60 and k ~= 130 and k ~= 140 then
      (self._finalAttr)[k] = nil
    end
  end
end

Equip.GetAllAttr = function(self)
  -- function num : 0_48
  return self._finalAttr
end

Equip.GetLimitEquip = function(self)
  -- function num : 0_49
  return (self._equipItemRecord).equipAttrib
end

Equip.GetApplyVocation = function(self)
  -- function num : 0_50 , upvalues : CEquipSuitTable, _ENV
  local record = CEquipSuitTable:GetRecorder((self._equipItemRecord).equipAttrib)
  return (TextManager.GetText)(record.txtid)
end

Equip.GetEquipSuitShowType = function(self)
  -- function num : 0_51 , upvalues : CEquipSuitTable
  local record = CEquipSuitTable:GetRecorder((self._equipItemRecord).equipAttrib)
  return record.showtype
end

Equip.GetEquipSuitImage = function(self)
  -- function num : 0_52 , upvalues : CEquipSuitTable, CImagePathTable, _ENV
  local record = CEquipSuitTable:GetRecorder((self._equipItemRecord).equipAttrib)
  if not CImagePathTable:GetRecorder(record.image) then
    return DataCommon.DefaultImageAsset
  end
end

Equip.GetApplyVocationIcon = function(self)
  -- function num : 0_53 , upvalues : CVocationCfgTable, CImagePathTable
  local vocationRecord = CVocationCfgTable:GetRecorder((self._equipItemRecord).equipAttrib)
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

Equip.GetEquipLimitRoleIdList = function(self)
  -- function num : 0_54 , upvalues : _ENV
  local str = (self._equipItemRecord).roleLimit
  local list = {}
  if str and str ~= "" then
    list = (string.split)(str, ";")
  end
  return list
end

Equip.GetResolveItemInfo = function(self)
  -- function num : 0_55 , upvalues : _ENV, CEquipStrengthenItemTable
  local itemList = {}
  local items = {}
  for index,itemid in ipairs((self._itemRecord).resolvegetitem) do
    if itemid > 0 then
      itemList[itemid] = ((self._itemRecord).resolvegetitemnum)[index]
    end
  end
  if self._level == 1 and self._exp == 0 then
    return itemList
  end
  local costExp = self:GetEquipTotalExp()
  local costMana = self:GetTotalManaByExp(costExp)
  local power = (((BeanManager.GetTableByName)("equip.cequipspecialcfg")):GetRecorder(1)).parameter
  local returnExp = (math.floor)(costExp * power / 100)
  local returnMana = (math.floor)(costMana * power / 100)
  local leftExp = returnExp
  local allIds = CEquipStrengthenItemTable:GetAllIds()
  for index = #allIds, 1, -1 do
    local record = CEquipStrengthenItemTable:GetRecorder(allIds[index])
    if record.decomposereturn == 1 then
      local num = (math.floor)(leftExp / record.Exp)
      if num > 0 then
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

Equip.GetAttrGrowthValues = function(self)
  -- function num : 0_56
  return (self._equipItemRecord).abilityValue
end

Equip.SetStage = function(self, stage)
  -- function num : 0_57
  self._stage = stage
end

Equip.GetStage = function(self)
  -- function num : 0_58
  return self._stage
end

Equip.GetMaxLevel = function(self)
  -- function num : 0_59 , upvalues : Cequipbreakcfg, _ENV
  (Cequipbreakcfg:GetAllIds())
  local equipBreakCfgAllId = nil
  local maxLevel = nil
  for i,value in ipairs(equipBreakCfgAllId) do
    local equipBreakCfgRecorder = Cequipbreakcfg:GetRecorder(value)
    if equipBreakCfgRecorder.pinJi == self:GetPinJiID() and equipBreakCfgRecorder.breaklv == self:GetStage() then
      maxLevel = equipBreakCfgRecorder.levelmax
    end
  end
  return maxLevel
end

Equip.GetBreakMaxLevel = function(self)
  -- function num : 0_60 , upvalues : Cequipbreakcfg, _ENV
  (Cequipbreakcfg:GetAllIds())
  local equipBreakCfgAllId = nil
  local maxLevel = nil
  for i,value in ipairs(equipBreakCfgAllId) do
    local equipBreakCfgRecorder = Cequipbreakcfg:GetRecorder(value)
    if equipBreakCfgRecorder.pinJi == self:GetPinJiID() and equipBreakCfgRecorder.breaklv == self:GetStage() + 1 then
      maxLevel = equipBreakCfgRecorder.levelmax
      return maxLevel
    end
  end
  return nil
end

Equip.GetBreaKNeedMana = function(self)
  -- function num : 0_61 , upvalues : Cequipbreakcfg, _ENV
  (Cequipbreakcfg:GetAllIds())
  local equipBreakCfgAllId = nil
  local mana = nil
  for i,value in ipairs(equipBreakCfgAllId) do
    local equipBreakCfgRecorder = Cequipbreakcfg:GetRecorder(value)
    if equipBreakCfgRecorder.pinJi == self:GetPinJiID() and equipBreakCfgRecorder.breaklv == self:GetStage() then
      mana = equipBreakCfgRecorder.manaCost
      return mana
    end
  end
end

Equip.GetNextBreakMultiple = function(self)
  -- function num : 0_62 , upvalues : Cequipbreakcfg, _ENV
  local equipBreakCfgAllId = Cequipbreakcfg:GetAllIds()
  local breakMultiple = 0
  for i,value in ipairs(equipBreakCfgAllId) do
    local equipBreakCfgRecorder = Cequipbreakcfg:GetRecorder(value)
    if equipBreakCfgRecorder.pinJi == self:GetPinJiID() and equipBreakCfgRecorder.breaklv <= self:GetStage() then
      breakMultiple = breakMultiple + equipBreakCfgRecorder.breakMultiple
    end
  end
  return breakMultiple
end

Equip.GetCurrentBreakMultiple = function(self)
  -- function num : 0_63 , upvalues : Cequipbreakcfg, _ENV
  if self:GetStage() == 0 or self:GetStage() == nil then
    return 0
  end
  local equipBreakCfgAllId = Cequipbreakcfg:GetAllIds()
  local breakMultiple = 0
  for i,value in ipairs(equipBreakCfgAllId) do
    local equipBreakCfgRecorder = Cequipbreakcfg:GetRecorder(value)
    if equipBreakCfgRecorder.pinJi == self:GetPinJiID() and equipBreakCfgRecorder.breaklv <= self:GetStage() - 1 then
      breakMultiple = breakMultiple + equipBreakCfgRecorder.breakMultiple
    end
  end
  return breakMultiple
end

Equip.GetLastBreakMultiple = function(self)
  -- function num : 0_64 , upvalues : Cequipbreakcfg, _ENV
  if self:GetStage() <= 1 then
    return 0
  end
  local equipBreakCfgAllId = Cequipbreakcfg:GetAllIds()
  local breakMultiple = 0
  for i,value in ipairs(equipBreakCfgAllId) do
    local equipBreakCfgRecorder = Cequipbreakcfg:GetRecorder(value)
    if equipBreakCfgRecorder.pinJi == self:GetPinJiID() and equipBreakCfgRecorder.breaklv <= self:GetStage() - 2 then
      breakMultiple = breakMultiple + equipBreakCfgRecorder.breakMultiple
    end
  end
  return breakMultiple
end

Equip.GetBreaKNeedMaterials = function(self)
  -- function num : 0_65 , upvalues : Cequipbreakcfg, _ENV
  local equipBreakCfgAllId = Cequipbreakcfg:GetAllIds()
  local materials = {}
  for i,value in ipairs(equipBreakCfgAllId) do
    local equipBreakCfgRecorder = Cequipbreakcfg:GetRecorder(value)
    if equipBreakCfgRecorder.pinJi == self:GetPinJiID() and equipBreakCfgRecorder.breaklv == self:GetStage() then
      materials = equipBreakCfgRecorder.itemId
      return materials
    end
  end
end

Equip.GetBreaKNeedMaterialsCount = function(self)
  -- function num : 0_66 , upvalues : Cequipbreakcfg, _ENV
  local equipBreakCfgAllId = Cequipbreakcfg:GetAllIds()
  local MaterialsCount = {}
  for i,value in ipairs(equipBreakCfgAllId) do
    local equipBreakCfgRecorder = Cequipbreakcfg:GetRecorder(value)
    if equipBreakCfgRecorder.pinJi == self:GetPinJiID() and equipBreakCfgRecorder.breaklv == self:GetStage() then
      MaterialsCount = equipBreakCfgRecorder.itemNum
      return MaterialsCount
    end
  end
end

Equip.GetBreaKNeedEquipsCount = function(self)
  -- function num : 0_67 , upvalues : Cequipbreakcfg, _ENV
  (Cequipbreakcfg:GetAllIds())
  local equipBreakCfgAllId = nil
  local count = nil
  for i,value in ipairs(equipBreakCfgAllId) do
    local equipBreakCfgRecorder = Cequipbreakcfg:GetRecorder(value)
    if equipBreakCfgRecorder.pinJi == self:GetPinJiID() and equipBreakCfgRecorder.breaklv == self:GetStage() then
      count = equipBreakCfgRecorder.materialEquipNum
      return count
    end
  end
end

Equip.GetBreaKNeedEquipsPinji = function(self)
  -- function num : 0_68 , upvalues : Cequipbreakcfg, _ENV
  (Cequipbreakcfg:GetAllIds())
  local equipBreakCfgAllId = nil
  local pinji = nil
  for i,value in ipairs(equipBreakCfgAllId) do
    local equipBreakCfgRecorder = Cequipbreakcfg:GetRecorder(value)
    if equipBreakCfgRecorder.pinJi == self:GetPinJiID() and equipBreakCfgRecorder.breaklv == self:GetStage() then
      pinji = equipBreakCfgRecorder.materialEquipPinji
      return pinji
    end
  end
end

Equip.GetBreaKLimitTimes = function(self)
  -- function num : 0_69 , upvalues : Cequipbreakcfg, _ENV
  (Cequipbreakcfg:GetAllIds())
  local equipBreakCfgAllId = nil
  local pinji = nil
  local limitTimes = 0
  for i,value in ipairs(equipBreakCfgAllId) do
    local equipBreakCfgRecorder = Cequipbreakcfg:GetRecorder(value)
    if equipBreakCfgRecorder.pinJi == self:GetPinJiID() and limitTimes < equipBreakCfgRecorder.breaklv then
      limitTimes = equipBreakCfgRecorder.breaklv
    end
  end
  return limitTimes
end

Equip.GetRandomIndex = function(self)
  -- function num : 0_70
  return self._randomIndex
end

Equip.SetRandomIndex = function(self, randomIndex)
  -- function num : 0_71
  self._randomIndex = randomIndex
end

Equip.GetEquipAdditionalSkills = function(self)
  -- function num : 0_72 , upvalues : CEquipSuit
  local temp = {}
  local recorder = CEquipSuit:GetRecorder((self._equipItemRecord).equipSuitid)
  if recorder then
    temp = recorder.suitSkillID
  end
  return temp
end

Equip.GetLuckValue = function(self)
  -- function num : 0_73
  return self._luck
end

Equip.SetLuckValue = function(self, value)
  -- function num : 0_74
  self._luck = value
end

Equip.SetFMRequiredMana = function(self, mana)
  -- function num : 0_75
  self._fmRequiredMana = mana
end

Equip.GetFMRequiredMana = function(self, mana)
  -- function num : 0_76
  return self._fmRequiredMana
end

Equip.SetIsEnchanted = function(self, value)
  -- function num : 0_77
  if value == true then
    self._enchant = 1
  else
    self._enchant = 0
  end
end

Equip.GetIsEnchanted = function(self)
  -- function num : 0_78
  do return self._enchant == 1 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Equip.GetBagInfoBackPinJiImage = function(self)
  -- function num : 0_79 , upvalues : CImagePathTable, _ENV
  if not CImagePathTable:GetRecorder((self._pinJiRecord).equipWorkshop) then
    return DataCommon.DefaultImageAsset
  end
end

Equip.GetEquipSuitId = function(self)
  -- function num : 0_80
  return (self._equipItemRecord).equipSuitid
end

Equip.GetEquipSuitRecorder = function(self)
  -- function num : 0_81 , upvalues : CEquipSuit
  return CEquipSuit:GetRecorder((self._equipItemRecord).equipSuitid)
end

Equip.GetEquipStarStr = function(self)
  -- function num : 0_82 , upvalues : CEquipBreakStar
  if self:GetBreaKLimitTimes() == self._stage then
    return (CEquipBreakStar:GetRecorder(self:GetPinJiID())).brokenstar
  else
    return (CEquipBreakStar:GetRecorder(self:GetPinJiID())).star
  end
end

Equip.GetEquipNotFullStarStr = function(self)
  -- function num : 0_83 , upvalues : CEquipBreakStar
  return (CEquipBreakStar:GetRecorder(self:GetPinJiID())).star
end

Equip.GetEquipFullStarStr = function(self)
  -- function num : 0_84 , upvalues : CEquipBreakStar
  return (CEquipBreakStar:GetRecorder(self:GetPinJiID())).brokenstar
end

return Equip

