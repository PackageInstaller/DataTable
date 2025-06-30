-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/equipforge/breakequiptabcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local CItemAttrTable = (BeanManager.GetTableByName)("item.citemattr")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CItemPinji = (BeanManager.GetTableByName)("item.citempinji")
local CAttrEffectidNameTable = (BeanManager.GetTableByName)("role.cattreffectidname")
local CRandomAbilityTable = (BeanManager.GetTableByName)("equip.crandomability")
local Cequipbreakcfg = (BeanManager.GetTableByName)("equip.cequipbreakcfg")
local CSkillShow_Common = (BeanManager.GetTableByName)("skill.cskillshow_common")
local CVarconfig = (BeanManager.GetTableByName)("var.cvarconfig")
local CWordColor = (BeanManager.GetTableByName)("message.cwordcolor")
local CMessageTip = (BeanManager.GetTableByName)("message.cmessagetip")
local CEquipItemTable = (BeanManager.GetTableByName)("item.cequipitem")
local BreakTimesString = {(TextManager.GetText)((CMessageTip:GetRecorder(100147)).msgTextID), (TextManager.GetText)((CMessageTip:GetRecorder(100148)).msgTextID), (TextManager.GetText)((CMessageTip:GetRecorder(100149)).msgTextID), (TextManager.GetText)((CMessageTip:GetRecorder(100150)).msgTextID); [0] = (TextManager.GetText)((CMessageTip:GetRecorder(100146)).msgTextID)}
local BreakEquipTabCell = class("BreakEquipTabCell", Dialog)
local Item = require("logic.manager.experimental.types.item")
local ReplacePercent = function(str)
  -- function num : 0_0 , upvalues : _ENV
  str = (string.gsub)(str, "%%", "%%%%")
  return str
end

BreakEquipTabCell.AssetBundleName = "ui/layouts.equip"
BreakEquipTabCell.AssetName = "EquipTP"
BreakEquipTabCell.Ctor = function(self, ...)
  -- function num : 0_1 , upvalues : BreakEquipTabCell
  ((BreakEquipTabCell.super).Ctor)(self, ...)
  self._equip = nil
  self.isLevelEnough = false
  self._selectedItem = {}
  self._effectHandler = nil
  self._haveEnoughItem = false
  self._needMaterials = {}
  self._attrData = {}
end

BreakEquipTabCell.OnCreate = function(self)
  -- function num : 0_2 , upvalues : TableFrame, _ENV
  self._equipIcon = self:GetChild("EquipCell/BackGround/Icon")
  self._frame = self:GetChild("EquipCell/BackGround/Frame")
  self._equipPoint = self:GetChild("EquipCell/BreakPoint")
  self._effect = self:GetChild("Frame3/Effect")
  self._equipName = self:GetChild("EquipName")
  self._leftLV = self:GetChild("Up/LeftPanel/LevelNum")
  self._leftLVRed = self:GetChild("Up/LeftPanel/LevelNumRed")
  self._leftLVMax = self:GetChild("Up/LeftPanel/LevelMax")
  self._leftBreakPoint = self:GetChild("Up/LeftPanel/BreakPoint1")
  self._rightPanel = self:GetChild("Up/RightPanel")
  self._rightLV = self:GetChild("Up/RightPanel/LevelNum")
  self._rightLVMax = self:GetChild("Up/RightPanel/LevelMax")
  self._rightBreakPoint = self:GetChild("Up/RightPanel/BreakPoint2")
  self._lock = self:GetChild("Up/Lock")
  self._lockName = self:GetChild("Up/Lock/Txt1")
  self._lockNum = self:GetChild("Up/Lock/Num")
  self._lockRange = self:GetChild("Up/Lock/Txt2")
  self._biggestBreakTxt = self:GetChild("Up/Max")
  ;
  (self._biggestBreakTxt):SetActive(false)
  self._attrPalel = self:GetChild("Up/Frame")
  self._attrFrame = (TableFrame.Create)(self._attrPalel, self, true, false)
  self._needMoneyNum = self:GetChild("Frame/NumBack1/Num")
  self._needMoneyNumRed = self:GetChild("Frame/NumBack1/NumRed")
  ;
  (self._needMoneyNumRed):SetActive(false)
  self._breakNeed = self:GetChild("Frame/Need")
  self._breakNeedTxt = self:GetChild("Frame/Need/Num")
  self._materials = {}
  for i = 1, 3 do
    do
      -- DECOMPILER ERROR at PC119: Confused about usage of register: R5 in 'UnsetPending'

      (self._materials)[i] = self:GetChild("Frame/Material" .. i)
      ;
      ((self._materials)[i]):SetActive(false)
    end
  end
  self._materialsIcon = {}
  for i = 1, 3 do
    -- DECOMPILER ERROR at PC139: Confused about usage of register: R5 in 'UnsetPending'

    (self._materialsIcon)[i] = self:GetChild("Frame/Material" .. i .. "/_BackGround/Icon")
    ;
    ((self._materialsIcon)[i]):Subscribe_PointerClickEvent(function()
    -- function num : 0_2_0 , upvalues : self, i
    self:OnMaterialsIcon(i)
  end
)
  end
  self._materialsNum = {}
  for i = 1, 3 do
    -- DECOMPILER ERROR at PC160: Confused about usage of register: R5 in 'UnsetPending'

    (self._materialsNum)[i] = self:GetChild("Frame/Material" .. i .. "/_Count/Num")
  end
  self._materialsNumRed = {}
  for i = 1, 3 do
    -- DECOMPILER ERROR at PC175: Confused about usage of register: R5 in 'UnsetPending'

    (self._materialsNumRed)[i] = self:GetChild("Frame/Material" .. i .. "/_Count/NumRed")
  end
  self._materialsNumNeed = {}
  for i = 1, 3 do
    -- DECOMPILER ERROR at PC190: Confused about usage of register: R5 in 'UnsetPending'

    (self._materialsNumNeed)[i] = self:GetChild("Frame/Material" .. i .. "/_Count/Max")
  end
  self._materialsFrame = {}
  for i = 1, 3 do
    -- DECOMPILER ERROR at PC205: Confused about usage of register: R5 in 'UnsetPending'

    (self._materialsFrame)[i] = self:GetChild("Frame/Material" .. i .. "/_BackGround/Frame")
  end
  self._itemPanel = self:GetChild("Frame/ItemFrame")
  self._itemFrame = (TableFrame.Create)(self._itemPanel, self, false, false)
  self._startBtn = self:GetChild("Frame/StartBtn")
  self._greyBtn = self:GetChild("Frame/greyBtn")
  ;
  (self._startBtn):Subscribe_PointerClickEvent(self.OnStartBtn, self)
  ;
  (self._greyBtn):Subscribe_PointerClickEvent(self.OnGreyBtn, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefresh, Common.n_EquipBreak, nil)
end

BreakEquipTabCell.OnDestroy = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (self._itemFrame):Destroy()
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
  if self._effectHandler then
    (self._effect):ReleaseEffect(self._effectHandler)
    self._effectHandler = nil
  end
  ;
  (self._attrFrame):Destroy()
end

BreakEquipTabCell.OnHidden = function(self)
  -- function num : 0_4
  if self._effectHandler then
    (self._effect):ReleaseEffect(self._effectHandler)
    self._effectHandler = nil
  end
end

BreakEquipTabCell.OnRefresh = function(self, notification)
  -- function num : 0_5 , upvalues : _ENV
  local equipKey = (notification.userInfo).equipKey
  if equipKey == (self._equip):GetKey() then
    local dialog = (DialogManager.CreateSingletonDialog)("equipforge.equipbreaksuccessdialog")
    if dialog then
      dialog:SetData(self._equip)
    end
    self:Init(equipKey)
  end
end

BreakEquipTabCell.RefreshTabCell = function(self)
  -- function num : 0_6
end

BreakEquipTabCell.Init = function(self, equipKey)
  -- function num : 0_7 , upvalues : _ENV, Cequipbreakcfg, CRandomAbilityTable, CAttrEffectidNameTable, CStringRes, ReplacePercent, CSkillShow_Common, CItemPinji, CItemAttrTable, CImagePathTable, Item, CEquipItemTable
  self._equip = ((NekoData.BehaviorManager).BM_BagInfo):GetEquipItem(equipKey)
  ;
  (self._startBtn):SetInteractable(false)
  for i = 1, (self._equip):GetBreaKNeedEquipsCount() do
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R6 in 'UnsetPending'

    (self._selectedItem)[i] = -1
  end
  local randomWordList = (self._equip):GetRandomEntry()
  local cequipbreakcfgAll = (Cequipbreakcfg:GetAllIds())
  local currentStageUnlockCount, nextStageUnlockIndex, nextStageUnlockWord, currentBreakCfgRecorder = nil, nil, nil, nil
  for i,id in pairs(cequipbreakcfgAll) do
    local record = Cequipbreakcfg:GetRecorder(id)
    local pinjiFlg = (self._equip):GetPinJiID() == record.pinJi
    local stageFlg = (self._equip):GetStage() == record.breaklv
    if pinjiFlg and stageFlg then
      currentStageUnlockCount = record.unlockAbilityNum
      currentBreakCfgRecorder = record
      break
    end
  end
  for i,id in pairs(cequipbreakcfgAll) do
    local record = Cequipbreakcfg:GetRecorder(id)
    local pinjiFlg = (self._equip):GetPinJiID() == record.pinJi
    local stageFlg = (self._equip):GetStage() + 1 == record.breaklv
    if pinjiFlg and stageFlg then
      nextStageUnlockIndex = record.unlockAbilityNum
      break
    end
  end
  if nextStageUnlockIndex and nextStageUnlockIndex ~= currentStageUnlockCount then
    for key,value in pairs(randomWordList) do
      if value.index == nextStageUnlockIndex then
        nextStageUnlockWord = value
        if nextStageUnlockWord.kind == 1 then
          (self._lock):SetActive(true)
          local attrRangeRecord = (CRandomAbilityTable:GetRecorder(nextStageUnlockWord.randomId)).attrRange
          local num1, num2 = (string.match)(attrRangeRecord, "(%d+);(%d+)")
          local attrId = nextStageUnlockWord.attr - (math.fmod)(tonumber(nextStageUnlockWord.attr), 10)
          local attrRecord = CAttrEffectidNameTable:GetRecorder(attrId)
          local attrValue = nextStageUnlockWord.attrValue
          do
            if attrRecord.isDecimal == 1 then
              local str = (TextManager.GetText)((CStringRes:GetRecorder(1286)).msgTextID)
              attrValue = attrValue / 1000 * 100
              attrValue = (string.gsub)(str, "%$parameter1%$", attrValue)
              num1 = num1 / 1000 * 100
              num1 = (string.gsub)(str, "%$parameter1%$", tostring(num1))
              num2 = num2 / 1000 * 100
              num2 = (string.gsub)(str, "%$parameter1%$", tostring(num2))
            end
            do
              local str = (TextManager.GetText)((CStringRes:GetRecorder(1200)).msgTextID)
              str = (string.gsub)(str, "%$parameter1%$", ReplacePercent(num1))
              str = (string.gsub)(str, "%$parameter2%$", ReplacePercent(num2))
              ;
              (self._lockRange):SetText(str)
              ;
              (self._lockNum):SetText(attrValue)
              ;
              (self._lockName):SetText((TextManager.GetText)(attrRecord.classnameTextID))
              do break end
              if nextStageUnlockWord.kind == 2 then
                (self._lock):SetActive(true)
                ;
                (self._lockNum):SetText("")
                ;
                (self._lockRange):SetText("")
                local name = (CSkillShow_Common:GetRecorder(nextStageUnlockWord.skill)).nameTextID
                name = (TextManager.GetText)(name)
                ;
                (self._lockName):SetText(name)
                break
              end
              -- DECOMPILER ERROR at PC251: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC251: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC251: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC251: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC251: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC251: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    end
  else
    (self._lock):SetActive(false)
  end
  local record = (self._equip):GetIcon()
  ;
  (self._equipIcon):SetSprite(record.assetBundle, record.assetName)
  ;
  (self._equipPoint):SetText((self._equip):GetEquipStarStr())
  record = (self._equip):GetPinJiImage()
  ;
  (self._frame):SetSprite(record.assetBundle, record.assetName)
  local equipName = (self._equip):GetName()
  ;
  (self._equipName):SetText(equipName)
  local curLv = (self._equip):GetStrengthenLevel()
  local maxLv = (self._equip):GetMaxLevel()
  if curLv == maxLv then
    self.isLevelEnough = true
  else
    self.isLevelEnough = false
  end
  ;
  (self._greyBtn):SetActive(not self.isLevelEnough)
  ;
  (self._startBtn):SetActive(self.isLevelEnough)
  local nextMaxLv = (self._equip):GetBreakMaxLevel()
  if self.isLevelEnough then
    (self._leftLV):SetText(curLv)
    ;
    (self._leftLVRed):SetActive(false)
    ;
    (self._leftLV):SetActive(true)
  else
    (self._leftLVRed):SetText(curLv)
    ;
    (self._leftLV):SetActive(false)
    ;
    (self._leftLVRed):SetActive(true)
  end
  ;
  (self._leftLVMax):SetText(maxLv)
  ;
  (self._rightLV):SetText(curLv)
  if nextMaxLv then
    (self._rightLVMax):SetText(nextMaxLv)
    local a = (self._equip):GetStage() + 1
    local b = (self._equip):GetBreaKLimitTimes()
    if (self._equip):GetStage() + 1 == (self._equip):GetBreaKLimitTimes() then
      (self._leftBreakPoint):SetText((self._equip):GetEquipStarStr())
      ;
      (self._rightBreakPoint):SetText((self._equip):GetEquipFullStarStr())
      ;
      (self._rightBreakPoint):SetActive(true)
      ;
      (self._leftBreakPoint):SetActive(true)
    else
      (self._rightBreakPoint):SetActive(false)
      ;
      (self._leftBreakPoint):SetActive(false)
    end
    ;
    (self._delegate):OnEquipBreakNotFull()
    ;
    (self._breakNeed):SetActive(true)
    local pinjiName = (CStringRes:GetRecorder((CItemPinji:GetRecorder(currentBreakCfgRecorder.materialEquipPinji)).name)).msgTextID
    pinjiName = (TextManager.GetText)(pinjiName)
    local str = (TextManager.GetText)((CStringRes:GetRecorder(1184)).msgTextID)
    ;
    (self._breakNeedTxt):SetText((string.gsub)(str, "%$parameter1%$", pinjiName))
  else
    (self._rightPanel):SetActive(false)
    ;
    (self._leftBreakPoint):SetActive(false)
    ;
    (self._biggestBreakTxt):SetActive(true)
    ;
    (self._breakNeed):SetActive(false)
    ;
    (self._attrPalel):SetActive(false)
    ;
    (self._delegate):OnEquipBreakFull()
  end
  local mana = (self._equip):GetBreaKNeedMana()
  if ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.ManaID) < mana then
    (self._needMoneyNum):SetActive(false)
    ;
    (self._needMoneyNumRed):SetActive(true)
    ;
    (self._needMoneyNumRed):SetNumber((math.ceil)(mana))
  else
    (self._needMoneyNum):SetActive(true)
    ;
    (self._needMoneyNumRed):SetActive(false)
    ;
    (self._needMoneyNum):SetNumber((math.ceil)(mana))
  end
  local needMaterialsCounts = (self._equip):GetBreaKNeedMaterialsCount()
  self._haveEnoughItem = true
  self._needMaterialsId = {}
  for i,id in ipairs((self._equip):GetBreaKNeedMaterials()) do
    if id ~= 0 then
      (table.insert)(self._needMaterialsId, id)
      local imageId = (CItemAttrTable:GetRecorder(id)).icon
      local imageRecord = CImagePathTable:GetRecorder(imageId)
      ;
      ((self._materialsIcon)[i]):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      ;
      ((self._materials)[i]):SetActive(true)
      local needCount = needMaterialsCounts[i]
      local haveCount = ((NekoData.BehaviorManager).BM_BagInfo):GetItemCountById(id)
      -- DECOMPILER ERROR at PC550: Confused about usage of register: R24 in 'UnsetPending'

      ;
      (self._needMaterials)[id] = needCount
      local item = (Item.Create)(id)
      imageRecord = item:GetPinJiImage()
      ;
      ((self._materialsFrame)[i]):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      if needCount <= haveCount then
        ((self._materialsNumNeed)[i]):SetText(needCount)
        ;
        ((self._materialsNum)[i]):SetText(haveCount)
        ;
        ((self._materialsNum)[i]):SetActive(true)
        ;
        ((self._materialsNumRed)[i]):SetActive(false)
      else
        ((self._materialsNumNeed)[i]):SetText(needCount)
        ;
        ((self._materialsNumRed)[i]):SetText(haveCount)
        ;
        ((self._materialsNum)[i]):SetActive(false)
        ;
        ((self._materialsNumRed)[i]):SetActive(true)
        self._haveEnoughItem = false
      end
    else
      ((self._materials)[i]):SetActive(false)
    end
  end
  ;
  (self._itemFrame):ReloadAllCell()
  ;
  (self._itemFrame):MoveToLeft()
  if nextMaxLv then
    self._attrData = {}
    record = CEquipItemTable:GetRecorder((self._equip):GetID())
    for i,v in ipairs(record.abilityID) do
      local temp = {}
      temp.attrId = v
      temp.currentValue = (record.abilityValue)[i] * (record.initMagnify + ((self._equip):GetMaxLevel() - 1) + (self._equip):GetCurrentBreakMultiple())
      temp.nextValue = (record.abilityValue)[i] * (record.initMagnify + ((self._equip):GetMaxLevel() - 1) + (self._equip):GetNextBreakMultiple())
      ;
      (table.insert)(self._attrData, temp)
    end
    ;
    (self._attrFrame):ReloadAllCell()
  end
  -- DECOMPILER ERROR: 28 unprocessed JMP targets
end

BreakEquipTabCell.RefreshItemFrame = function(self, items)
  -- function num : 0_8 , upvalues : _ENV
  self._selectedItem = {}
  for i,value in ipairs(items) do
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R7 in 'UnsetPending'

    (self._selectedItem)[i] = value
  end
  ;
  (self._itemFrame):ReloadAllCell()
  ;
  (self._itemFrame):MoveToLeft()
  local mana = (self._equip):GetBreaKNeedMana()
  local haveEnoughMana = mana <= ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.ManaID)
  if self._selectedItem and #self._selectedItem == (self._equip):GetBreaKNeedEquipsCount() and self._haveEnoughItem and haveEnoughMana and self.isLevelEnough and (self._equip):GetBreakMaxLevel() then
    (self._startBtn):SetInteractable(true)
  else
    (self._startBtn):SetInteractable(false)
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

BreakEquipTabCell.OnStartBtn = function(self)
  -- function num : 0_9 , upvalues : _ENV
  local hasStrengthened = false
  local hasHighPinJi = false
  for key,value in pairs(self._selectedItem) do
    local equip = ((NekoData.BehaviorManager).BM_BagInfo):GetEquipItem(value)
    if equip:GetStrengthenLevel() > 1 or equip:GetEquipExp() > 0 then
      hasStrengthened = true
    end
    if equip:GetPinJiID() > 2 then
      hasHighPinJi = true
    end
  end
  if hasStrengthened and not hasHighPinJi then
    ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(56, nil, function()
    -- function num : 0_9_0 , upvalues : self
    self:SendCBreakThroughEquip()
  end
)
    return 
  end
  if not hasStrengthened and hasHighPinJi then
    ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(57, nil, function()
    -- function num : 0_9_1 , upvalues : self
    self:SendCBreakThroughEquip()
  end
)
    return 
  end
  if hasStrengthened and hasHighPinJi then
    ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(58, nil, function()
    -- function num : 0_9_2 , upvalues : self
    self:SendCBreakThroughEquip()
  end
)
    return 
  end
  self:SendCBreakThroughEquip()
end

BreakEquipTabCell.OnGreyBtn = function(self)
  -- function num : 0_10 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Message):AddMessageTip((TextManager.GetText)(701159))
end

BreakEquipTabCell.SendCBreakThroughEquip = function(self)
  -- function num : 0_11 , upvalues : _ENV
  local cbreakthroughequip = (LuaNetManager.CreateProtocol)("protocol.item.cbreakthroughequip")
  if cbreakthroughequip then
    cbreakthroughequip.equipKey = (self._equip):GetKey()
    cbreakthroughequip.costEquipKeys = self._selectedItem
    cbreakthroughequip:Send()
  end
end

BreakEquipTabCell.OnMaterialsIcon = function(self, index)
  -- function num : 0_12 , upvalues : _ENV, Item
  local width, height = ((self._materials)[index]):GetRectSize()
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    local temp = {}
    temp.item = (Item.Create)((self._needMaterialsId)[index])
    tipsDialog:Init(temp)
    tipsDialog:SetTipsPosition(width, height, ((self._materials)[index]):GetLocalPointInUiRootPanel())
  end
end

BreakEquipTabCell.OnCellLongPress = function(self)
  -- function num : 0_13 , upvalues : _ENV
  local tipsDialog = (DialogManager.CreateSingletonDialog)("equip.equiptipsdialog")
  if tipsDialog then
    tipsDialog:Init((self._equip):GetKey())
    tipsDialog:SetTipsParmFunc(function()
    -- function num : 0_13_0 , upvalues : self
    local width, height = (self._itemFrame):GetRectSize()
    local pos = (self._itemFrame):GetLocalPointInUiRootPanel()
    return {width = width, height = height, posX = pos.x, posY = pos.y}
  end
)
  end
end

BreakEquipTabCell.NumberOfCell = function(self, frame)
  -- function num : 0_14
  if frame == self._attrFrame then
    return #self._attrData
  end
  return (self._equip):GetBreaKNeedEquipsCount()
end

BreakEquipTabCell.CellAtIndex = function(self, frame, index)
  -- function num : 0_15
  if frame == self._attrFrame then
    return "equipforge.equipbreakpropcell"
  end
  return "equipforge.equiptpitemcell"
end

BreakEquipTabCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_16
  if frame == self._attrFrame then
    return (self._attrData)[index]
  end
  return (self._selectedItem)[index]
end

return BreakEquipTabCell

