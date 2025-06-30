-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/handbook/equipbookdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CEquipBookCfg = (BeanManager.GetTableByName)("handbook.cequip_handbook")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CEquipSuit = (BeanManager.GetTableByName)("equip.cequipsuit")
local CRandomAbilityLib = (BeanManager.GetTableByName)("equip.crandomabilitylib")
local PinJiTable = (BeanManager.GetTableByName)("item.citempinji")
local CScreeningConditions = (BeanManager.GetTableByName)("equip.cequipscreeningconditions")
local EquipTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.equiptype")
local HandBookTypeEnum = (LuaNetManager.GetBeanDef)("protocol.user.handbooktype")
local TableFrame = require("framework.ui.frame.table.tableframe")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local EquipBookDialog = class("EquipBookDialog", Dialog)
EquipBookDialog.AssetBundleName = "ui/layouts.tujian"
EquipBookDialog.AssetName = "EquipBook"
EquipBookDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : EquipBookDialog
  ((EquipBookDialog.super).Ctor)(self, ...)
  self._selectId = 0
  self._equipList = {}
  self._downDataList = {}
  self._screeningConditions = {}
end

EquipBookDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, GridFrame, _ENV
  self._datailBack = self:GetChild("Detail")
  self._equipCell = self:GetChild("Detail/Equip")
  self._icon = self:GetChild("Detail/Equip/Icon")
  self._frame = self:GetChild("Detail/Equip/Back")
  self._lockEquipIcon = self:GetChild("Detail/Equip/Icon_black")
  self._lockIcon = self:GetChild("Detail/Equip/Lock")
  self._equipName = self:GetChild("Detail/Name")
  self._equipNum = self:GetChild("Detail/Equip/Num")
  self._lockText = self:GetChild("Detail/LockTxt")
  self._equipDescribeTxt = self:GetChild("Detail/DescribeTxt")
  self._detailPanel = self:GetChild("Detail/Frame")
  self._detailframe = (TableFrame.Create)(self._detailPanel, self, true, true, true)
  ;
  (self._detailframe):SetMargin(15, 0)
  self._equipPanel = self:GetChild("Frame")
  self._equipFrame = (GridFrame.Create)(self._equipPanel, self, true, 4)
  ;
  (self._equipFrame):SetMargin(15, 0)
  self._scrollBar = self:GetChild("Scrollbar")
  ;
  (self._scrollBar):SetScrollDirection(3)
  self._filterBtn = self:GetChild("FliterBtn")
  ;
  (self._filterBtn):Subscribe_PointerClickEvent(self.OnFilterBtnClick, self)
  self._filterPanel = self:GetChild("BaseCharacterListFliterNew")
  self._filterDlg = ((require("logic.dialog.common.filterdialog")).Create)(self._filterPanel)
end

EquipBookDialog.SetScreeningConditions = function(self, screeningConditions)
  -- function num : 0_2
  self._screeningConditions = screeningConditions
  self:Refresh()
end

EquipBookDialog.OnDestroy = function(self)
  -- function num : 0_3
  (self._detailframe):Destroy()
  ;
  (self._equipFrame):Destroy()
  if self._filterDlg then
    (self._filterDlg):Destroy()
    self._filterDlg = nil
  end
end

EquipBookDialog.Refresh = function(self)
  -- function num : 0_4 , upvalues : _ENV, EquipTypeEnum, CEquipBookCfg, HandBookTypeEnum
  local typeList = {}
  local select = false
  for k,v in pairs(self._screeningConditions) do
    for index,value in ipairs(v) do
      if value.nameid == 1500043 then
        select = true
        typeList[EquipTypeEnum.WEAPON] = true
      end
      if value.nameid == 1500044 then
        select = true
        typeList[EquipTypeEnum.ARMOR] = true
      end
      if value.nameid == 1500045 then
        select = true
        typeList[EquipTypeEnum.JEWELRY] = true
      end
    end
  end
  self._equipList = {}
  local firstUnlockRecord = nil
  local firstUnLockIndex = 0
  for _,v in ipairs(CEquipBookCfg:GetAllIds()) do
    local record = CEquipBookCfg:GetRecorder(R12_PC45)
    if (not select or typeList[record.itemType]) and record.isShow == 1 then
      (table.insert)(R12_PC45, record)
      -- DECOMPILER ERROR at PC65: Overwrote pending register: R12 in 'AssignReg'

      if not firstUnlockRecord and ((NekoData.BehaviorManager).BM_HandBook):IsBookUnLock(R13_PC68, HandBookTypeEnum.EQUIP) then
        firstUnlockRecord = record
        firstUnLockIndex = #self._equipList
      end
    end
  end
  ;
  (self._equipFrame):ReloadAllCell()
  if not firstUnlockRecord then
    firstUnlockRecord = (self._equipList)[1]
    firstUnLockIndex = 1
  end
  if firstUnlockRecord then
    (self._equipFrame):FireEvent("ChooseEquip", firstUnlockRecord.id)
    self:OnSelectEquip(firstUnlockRecord)
    ;
    (self._equipFrame):MoveDownToIndex(firstUnLockIndex, false)
  else
    ;
    (self._datailBack):SetActive(false)
  end
end

EquipBookDialog.OnSelectEquip = function(self, equipBookInfo)
  -- function num : 0_5 , upvalues : _ENV, CImagePathTable, HandBookTypeEnum, PinJiTable, CRandomAbilityLib, CEquipSuit
  self._selectId = equipBookInfo.id
  ;
  (self._datailBack):SetActive(true)
  ;
  (self._equipNum):SetText(equipBookInfo.equipNumber)
  ;
  (self._equipDescribeTxt):SetText((TextManager.GetText)(equipBookInfo.destribeTextID))
  if not CImagePathTable:GetRecorder(equipBookInfo.icon) then
    local record = DataCommon.DefaultImageAsset
  end
  if not ((NekoData.BehaviorManager).BM_HandBook):IsBookUnLock(equipBookInfo.id, HandBookTypeEnum.EQUIP) then
    (self._equipCell):SetActive(false)
    ;
    (self._icon):SetActive(false)
    ;
    (self._lockIcon):SetActive(true)
    ;
    (self._lockEquipIcon):SetActive(true)
    ;
    (self._lockEquipIcon):SetSprite(record.assetBundle, record.assetName)
    ;
    (self._equipName):SetText("")
    ;
    (self._lockText):SetActive(true)
    ;
    (self._detailPanel):SetActive(false)
    ;
    (self._equipDescribeTxt):SetActive(false)
    local str = (TextManager.GetText)(501674)
    ;
    (self._lockText):SetText(str)
    ;
    (self._equipFrame):FireEvent("ChooseEquip", equipBookInfo.id)
    return 
  end
  do
    ;
    (self._equipCell):SetActive(true)
    ;
    (self._icon):SetActive(true)
    ;
    (self._lockEquipIcon):SetActive(false)
    ;
    (self._lockIcon):SetActive(false)
    ;
    (self._lockText):SetActive(false)
    ;
    (self._detailPanel):SetActive(true)
    ;
    (self._equipDescribeTxt):SetActive(true)
    ;
    (self._equipName):SetText((TextManager.GetText)(equipBookInfo.nameTextID))
    ;
    (self._icon):SetSprite(record.assetBundle, record.assetName)
    local rarityRecorder = PinJiTable:GetRecorder(equipBookInfo.rarity)
    record = CImagePathTable:GetRecorder(rarityRecorder.imageDir)
    ;
    (self._frame):SetSprite(record.assetBundle, record.assetName)
    self._downDataList = {}
    local attrList = {}
    for index,v in ipairs(equipBookInfo.abilityID) do
      local temp = {}
      temp.attrId = v
      temp.attrValue = (math.ceil)((equipBookInfo.abilityValue)[index] * equipBookInfo.initMagnify)
      ;
      (table.insert)(attrList, temp)
      temp = {}
      temp.attrId = v
      temp.attrGrowthValue = (math.ceil)((equipBookInfo.abilityValue)[index])
      ;
      (table.insert)(attrList, temp)
    end
    local temp = {}
    temp.tag = "Attribute"
    temp.value = attrList
    ;
    (table.insert)(self._downDataList, temp)
    local randomAbility = {}
    for i,v in ipairs(equipBookInfo.randomAbility) do
      local libRecord = CRandomAbilityLib:GetRecorder(v)
      if #libRecord.abilityID > 1 then
        local temp = {value = -1}
        ;
        (table.insert)(randomAbility, temp)
      else
        do
          do
            if #libRecord.abilityID == 1 then
              local temp = {value = (libRecord.abilityID)[1]}
              ;
              (table.insert)(randomAbility, temp)
            end
            -- DECOMPILER ERROR at PC219: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC219: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC219: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
    if #randomAbility > 0 then
      temp = {tag = "WordDescribe", value = randomAbility}
      ;
      (table.insert)(self._downDataList, temp)
    end
    local suitRecorder = CEquipSuit:GetRecorder(equipBookInfo.equipSuitid)
    if suitRecorder then
      temp = {}
      temp.tag = "SuitInfo"
      temp.suitName = suitRecorder.suitName
      temp.suitImg = suitRecorder.suitImg
      ;
      (table.insert)(self._downDataList, temp)
      local skillIDs = suitRecorder.suitSkillID
      for i,v in ipairs(skillIDs) do
        if v ~= 0 then
          temp = {}
          temp.tag = "SuitSkill"
          temp.count = i
          temp.skillID = v
          ;
          (table.insert)(self._downDataList, temp)
        end
      end
    end
    do
      ;
      (self._detailframe):ReloadAllCell()
      ;
      (self._detailframe):MoveToTop()
      ;
      (self._equipFrame):FireEvent("ChooseEquip", equipBookInfo.id)
    end
  end
end

EquipBookDialog.NumberOfCell = function(self, frame, index)
  -- function num : 0_6
  if frame == self._equipFrame then
    return #self._equipList
  else
    if frame == self._detailframe then
      return #self._downDataList
    end
  end
end

EquipBookDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_7
  if frame == self._equipFrame then
    return "handbook.equipbookcell"
  else
    if ((self._downDataList)[index]).tag == "Attribute" then
      return "handbook.equipbookattrframecell"
    else
      if ((self._downDataList)[index]).tag == "WordDescribe" then
        return "handbook.equipbookworddescribeframe"
      else
        if ((self._downDataList)[index]).tag == "SuitInfo" then
          return "handbook.equipbooksuitinfocell"
        else
          if ((self._downDataList)[index]).tag == "SuitSkill" then
            return "handbook.equipbooksuitskillcell"
          else
            if ((self._downDataList)[index]).tag == "Describe" then
              return "handbook.equipbookdescribecell"
            end
          end
        end
      end
    end
  end
end

EquipBookDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_8
  if frame == self._equipFrame then
    return (self._equipList)[index]
  else
    return (self._downDataList)[index]
  end
end

EquipBookDialog.OnFilterBtnClick = function(self)
  -- function num : 0_9 , upvalues : _ENV
  if not self._filterDlg then
    LogError("[Dialog]: ", "Common filter dlg create error")
    return 
  end
  ;
  (self._filterDlg):SetData(self, 1, "EquipBook", self._screeningConditions)
end

EquipBookDialog.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_10
  if frame == self._equipFrame then
    local width, height = (self._equipPanel):GetRectSize()
    local total = (self._equipFrame):GetTotalLength()
    if height < total then
      (self._scrollBar):SetActive(true)
      ;
      (self._scrollBar):SetScrollSize(height / total)
      ;
      (self._scrollBar):SetScrollValue(proportion)
    else
      ;
      (self._scrollBar):SetActive(false)
    end
  end
end

return EquipBookDialog

