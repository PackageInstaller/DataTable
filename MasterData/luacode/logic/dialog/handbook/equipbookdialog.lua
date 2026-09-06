local CEquipBookCfg = BeanManager.GetTableByName("handbook.cequip_handbook")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CEquipSuit = BeanManager.GetTableByName("equip.cequipsuit")
local CRandomAbilityLib = BeanManager.GetTableByName("equip.crandomabilitylib")
local PinJiTable = BeanManager.GetTableByName("item.citempinji")
local CScreeningConditions = BeanManager.GetTableByName("equip.cequipscreeningconditions")
local EquipTypeEnum = LuaNetManager.GetBeanDef("protocol.item.equiptype")
local HandBookTypeEnum = LuaNetManager.GetBeanDef("protocol.user.handbooktype")
local TableFrame = require("framework.ui.frame.table.tableframe")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local EquipBookDialog = class("EquipBookDialog", Dialog)
EquipBookDialog.AssetBundleName = "ui/layouts.tujian"
EquipBookDialog.AssetName = "EquipBook"

function EquipBookDialog:Ctor(...)
  EquipBookDialog.super.Ctor(self, ...)
  self._selectId = 0
  self._equipList = {}
  self._downDataList = {}
  self._screeningConditions = {}
end

function EquipBookDialog:OnCreate()
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
  self._detailframe = TableFrame.Create(self._detailPanel, self, true, true, true)
  self._detailframe:SetMargin(15, 0)
  self._equipPanel = self:GetChild("Frame")
  self._equipFrame = GridFrame.Create(self._equipPanel, self, true, 4)
  self._equipFrame:SetMargin(15, 0)
  self._scrollBar = self:GetChild("Scrollbar")
  self._scrollBar:SetScrollDirection(3)
  self._filterBtn = self:GetChild("FliterBtn")
  self._filterBtn:Subscribe_PointerClickEvent(self.OnFilterBtnClick, self)
  self._filterPanel = self:GetChild("BaseCharacterListFliterNew")
  self._filterDlg = require("logic.dialog.common.filterdialog").Create(self._filterPanel)
end

function EquipBookDialog:SetScreeningConditions(screeningConditions)
  self._screeningConditions = screeningConditions
  self:Refresh()
end

function EquipBookDialog:OnDestroy()
  self._detailframe:Destroy()
  self._equipFrame:Destroy()
  if self._filterDlg then
    self._filterDlg:Destroy()
    self._filterDlg = nil
  end
end

function EquipBookDialog:Refresh()
  local typeList = {}
  local select = false
  for k, v in pairs(self._screeningConditions) do
    for index, value in ipairs(v) do
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
  local firstUnlockRecord
  local firstUnLockIndex = 0
  for _, v in ipairs(CEquipBookCfg:GetAllIds()) do
    local record = CEquipBookCfg:GetRecorder(v)
    if (not select or typeList[record.itemType]) and record.isShow == 1 then
      table.insert(self._equipList, record)
      if not firstUnlockRecord and NekoData.BehaviorManager.BM_HandBook:IsBookUnLock(v, HandBookTypeEnum.EQUIP) then
        firstUnlockRecord = record
        firstUnLockIndex = #self._equipList
      end
    end
  end
  self._equipFrame:ReloadAllCell()
  if not firstUnlockRecord then
    firstUnlockRecord = self._equipList[1]
    firstUnLockIndex = 1
  end
  if firstUnlockRecord then
    self._equipFrame:FireEvent("ChooseEquip", firstUnlockRecord.id)
    self:OnSelectEquip(firstUnlockRecord)
    self._equipFrame:MoveDownToIndex(firstUnLockIndex, false)
  else
    self._datailBack:SetActive(false)
  end
end

function EquipBookDialog:OnSelectEquip(equipBookInfo)
  self._selectId = equipBookInfo.id
  self._datailBack:SetActive(true)
  self._equipNum:SetText(equipBookInfo.equipNumber)
  self._equipDescribeTxt:SetText(TextManager.GetText(equipBookInfo.destribeTextID))
  local record = CImagePathTable:GetRecorder(equipBookInfo.icon) or DataCommon.DefaultImageAsset
  if not NekoData.BehaviorManager.BM_HandBook:IsBookUnLock(equipBookInfo.id, HandBookTypeEnum.EQUIP) then
    self._equipCell:SetActive(false)
    self._icon:SetActive(false)
    self._lockIcon:SetActive(true)
    self._lockEquipIcon:SetActive(true)
    self._lockEquipIcon:SetSprite(record.assetBundle, record.assetName)
    self._equipName:SetText("")
    self._lockText:SetActive(true)
    self._detailPanel:SetActive(false)
    self._equipDescribeTxt:SetActive(false)
    local str = TextManager.GetText(501674)
    self._lockText:SetText(str)
    self._equipFrame:FireEvent("ChooseEquip", equipBookInfo.id)
    return
  end
  self._equipCell:SetActive(true)
  self._icon:SetActive(true)
  self._lockEquipIcon:SetActive(false)
  self._lockIcon:SetActive(false)
  self._lockText:SetActive(false)
  self._detailPanel:SetActive(true)
  self._equipDescribeTxt:SetActive(true)
  self._equipName:SetText(TextManager.GetText(equipBookInfo.nameTextID))
  self._icon:SetSprite(record.assetBundle, record.assetName)
  local rarityRecorder = PinJiTable:GetRecorder(equipBookInfo.rarity)
  record = CImagePathTable:GetRecorder(rarityRecorder.imageDir)
  self._frame:SetSprite(record.assetBundle, record.assetName)
  self._downDataList = {}
  local attrList = {}
  for index, v in ipairs(equipBookInfo.abilityID) do
    local temp = {}
    temp.attrId = v
    temp.attrValue = math.ceil(equipBookInfo.abilityValue[index] * equipBookInfo.initMagnify)
    table.insert(attrList, temp)
    temp = {}
    temp.attrId = v
    temp.attrGrowthValue = math.ceil(equipBookInfo.abilityValue[index])
    table.insert(attrList, temp)
  end
  local temp = {}
  temp.tag = "Attribute"
  temp.value = attrList
  table.insert(self._downDataList, temp)
  local randomAbility = {}
  for i, v in ipairs(equipBookInfo.randomAbility) do
    local libRecord = CRandomAbilityLib:GetRecorder(v)
    if #libRecord.abilityID > 1 then
      local temp = {value = -1}
      table.insert(randomAbility, temp)
    elseif #libRecord.abilityID == 1 then
      local temp = {
        value = libRecord.abilityID[1]
      }
      table.insert(randomAbility, temp)
    end
  end
  if 0 < #randomAbility then
    temp = {
      tag = "WordDescribe",
      value = randomAbility
    }
    table.insert(self._downDataList, temp)
  end
  local suitRecorder = CEquipSuit:GetRecorder(equipBookInfo.equipSuitid)
  if suitRecorder then
    temp = {}
    temp.tag = "SuitInfo"
    temp.suitName = suitRecorder.suitName
    temp.suitImg = suitRecorder.suitImg
    table.insert(self._downDataList, temp)
    local skillIDs = suitRecorder.suitSkillID
    for i, v in ipairs(skillIDs) do
      if v ~= 0 then
        temp = {}
        temp.tag = "SuitSkill"
        temp.count = i
        temp.skillID = v
        table.insert(self._downDataList, temp)
      end
    end
  end
  self._detailframe:ReloadAllCell()
  self._detailframe:MoveToTop()
  self._equipFrame:FireEvent("ChooseEquip", equipBookInfo.id)
end

function EquipBookDialog:NumberOfCell(frame, index)
  if frame == self._equipFrame then
    return #self._equipList
  elseif frame == self._detailframe then
    return #self._downDataList
  end
end

function EquipBookDialog:CellAtIndex(frame, index)
  if frame == self._equipFrame then
    return "handbook.equipbookcell"
  elseif self._downDataList[index].tag == "Attribute" then
    return "handbook.equipbookattrframecell"
  elseif self._downDataList[index].tag == "WordDescribe" then
    return "handbook.equipbookworddescribeframe"
  elseif self._downDataList[index].tag == "SuitInfo" then
    return "handbook.equipbooksuitinfocell"
  elseif self._downDataList[index].tag == "SuitSkill" then
    return "handbook.equipbooksuitskillcell"
  elseif self._downDataList[index].tag == "Describe" then
    return "handbook.equipbookdescribecell"
  end
end

function EquipBookDialog:DataAtIndex(frame, index)
  if frame == self._equipFrame then
    return self._equipList[index]
  else
    return self._downDataList[index]
  end
end

function EquipBookDialog:OnFilterBtnClick()
  if not self._filterDlg then
    LogError("[Dialog]: ", "Common filter dlg create error")
    return
  end
  self._filterDlg:SetData(self, 1, "EquipBook", self._screeningConditions)
end

function EquipBookDialog:OnCurPosChange(frame, proportion)
  if frame == self._equipFrame then
    local width, height = self._equipPanel:GetRectSize()
    local total = self._equipFrame:GetTotalLength()
    if height < total then
      self._scrollBar:SetActive(true)
      self._scrollBar:SetScrollSize(height / total)
      self._scrollBar:SetScrollValue(proportion)
    else
      self._scrollBar:SetActive(false)
    end
  end
end

return EquipBookDialog
