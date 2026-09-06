local CstringCfg = BeanManager.GetTableByName("message.cstringres")
local CAttrNameTable = BeanManager.GetTableByName("role.cattreffectidname")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local Cequipbreakcfg = BeanManager.GetTableByName("equip.cequipbreakcfg")
local CEquipItemTable = BeanManager.GetTableByName("item.cequipitem")
local CRandomAbilityLib = BeanManager.GetTableByName("equip.crandomabilitylib")
local CGemSuitTable = BeanManager.GetTableByName("equip.cbaoshisuit")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local UIManager = CS.PixelNeko.UI.UIManager
local UIRootOffsetMax = UIManager.GetUiRootOffsetMax()
local UIRootPanelOffsetMax = UIManager.GetUiRootPanelOffsetMax()
local TableFrame = require("framework.ui.frame.table.tableframe")
local Equip = require("logic.manager.experimental.types.equip")
local EquipTipsPreviewDialog = class("EquipTipsPreviewDialog", Dialog)
EquipTipsPreviewDialog.AssetBundleName = "ui/layouts.equip"
EquipTipsPreviewDialog.AssetName = "EquipTipsNew"

function EquipTipsPreviewDialog:Ctor(...)
  EquipTipsPreviewDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
  self._equip = nil
  self._downDataList = {}
  self._basePropRecord = {}
end

function EquipTipsPreviewDialog:OnCreate()
  self._tipsBack = self:GetChild("TipsBack")
  self._icon = self:GetChild("TipsBack/Top/EquipCell/BackGround/Icon")
  self._characterIcon = self:GetChild("TipsBack/Top/EquipCell/CharPhoto")
  self._characterBack = self:GetChild("TipsBack/Top/EquipCell/CharBack")
  self._equipFrame = self:GetChild("TipsBack/Top/EquipCell/BackGround/Frame")
  self._level = self:GetChild("TipsBack/Top/Level/Num")
  self._levelLabelTxt = self:GetChild("TipsBack/Top/Level/Txt")
  self._levelMax = self:GetChild("TipsBack/Top/Level/NumMax")
  self._equipName = self:GetChild("TipsBack/Top/EquipName")
  self._score = self:GetChild("TipsBack/Top/Fight/Num")
  self._prop1_Icon = self:GetChild("TipsBack/Prop1/Image")
  self._prop1_Name = self:GetChild("TipsBack/Prop1/Name")
  self._prop1_Num = self:GetChild("TipsBack/Prop1/Num")
  self._prop2_Panel = self:GetChild("TipsBack/Prop2")
  self._prop2_Icon = self:GetChild("TipsBack/Prop2/Image")
  self._prop2_Name = self:GetChild("TipsBack/Prop2/Name")
  self._prop2_Num = self:GetChild("TipsBack/Prop2/Num")
  self._panel = self:GetChild("TipsBack/Frame")
  self._jobField = self:GetChild("TipsBack/Top/Job/JobFrame")
  self._jobFullTxt = self:GetChild("TipsBack/Top/Job/Txt")
  self._jobFrame = TableFrame.Create(self._jobField, self, false, false)
  self._frame = TableFrame.Create(self._panel, self, true, true, true)
  self._x, self._ox, self._y, self._oy = self._panel:GetSize()
  self._rootX, self._rootOX, self._rooty, self._rootOY = self:GetRootWindow():GetSize()
  self._tipsBack:Subscribe_PointerClickEvent(self.OnMouseClick, self)
  self._width, self._height = self:GetRootWindow():GetRectSize()
  LuaNotificationCenter.AddObserver(self, self.OnUpdate, Common.n_Update, nil)
  LuaNotificationCenter.AddObserver(self, self.OnEveryWhereClick, Common.n_GlobalPointerWillDown, nil)
  LuaNotificationCenter.AddObserver(self, self.OnScreenPixelChanged, Common.n_ScreenPixelChanged, nil)
end

function EquipTipsPreviewDialog:OnDestroy()
  self._frame:Destroy()
  self._jobFrame:Destroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function EquipTipsPreviewDialog:Init(equipID, showMaxLevel)
  local equip = Equip.Create(equipID)
  self:RefreshInfo(equip, showMaxLevel)
end

function EquipTipsPreviewDialog:RefreshInfo(equip, showMaxLevel)
  self._equip = equip
  self._levelLabelTxt:SetActive(true)
  self._levelMax:SetActive(true)
  local record = self._equip:GetIcon()
  self._icon:SetSprite(record.assetBundle, record.assetName)
  record = self._equip:GetPinJiImage()
  self._equipFrame:SetSprite(record.assetBundle, record.assetName)
  self._equipName:SetText(self._equip:GetName())
  self._characterIcon:SetActive(false)
  self._characterBack:SetActive(false)
  self._jobRecord = {}
  self._jobField:SetActive(true)
  table.insert(self._jobRecord, self._equip:GetApplyVocation())
  local str = TextManager.GetText(CStringRes:GetRecorder(1198).msgTextID)
  self._jobFullTxt:SetText(str)
  self._jobFrame:ReloadAllCell()
  self._basePropRecord = {}
  record = CEquipItemTable:GetRecorder(self._equip:GetID())
  local level = 1
  if showMaxLevel then
    local equipBreakCfgAllId = Cequipbreakcfg:GetAllIds()
    for i, value in ipairs(equipBreakCfgAllId) do
      local equipBreakCfgRecorder = Cequipbreakcfg:GetRecorder(value)
      if equipBreakCfgRecorder.pinJi == self._equip:GetPinJiID() and level < equipBreakCfgRecorder.levelmax then
        level = equipBreakCfgRecorder.levelmax
        self._equip:SetStage(self._equip:GetBreaKLimitTimes())
      end
    end
    self._level:SetText(level)
    self._levelMax:SetText(level)
  else
    self._level:SetText("1")
    self._levelMax:SetText("10")
  end
  local score = record.baseScore * (record.initMagnify + (level - 1))
  self._score:SetText(math.floor(score))
  for i, v in ipairs(record.randomAbility) do
    local libRecord = CRandomAbilityLib:GetRecorder(v)
    if 1 < #libRecord.abilityID then
      local temp = {
        tag = "WordDescribe",
        value = -1
      }
      table.insert(self._downDataList, temp)
    elseif #libRecord.abilityID == 1 then
      local temp = {
        tag = "WordDescribe",
        value = libRecord.abilityID[1]
      }
      table.insert(self._downDataList, temp)
    end
  end
  local suitRecorder = self._equip:GetEquipSuitRecorder()
  if suitRecorder then
    local temp = {}
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
  local baseRate = record.initMagnify + (level - 1) + equip:GetCurrentBreakMultiple()
  for i, v in ipairs(record.abilityID) do
    local temp = {}
    temp.attrId = v
    temp.value = record.abilityValue[i] * baseRate * (1 + equip:GetGemSuitAttrRate(v))
    table.insert(self._basePropRecord, temp)
  end
  table.sort(self._basePropRecord, function(a, b)
    return a.attrId < b.attrId
  end)
  local propIndex = {firseProp = 1, secondProp = 2}
  local value = self._basePropRecord[propIndex.firseProp].value
  record = CAttrNameTable:GetRecorder(self._basePropRecord[propIndex.firseProp].attrId)
  local imageRecord = CImagePathTable:GetRecorder(record.classIcon) or DataCommon.DefaultImageAsset
  self._prop1_Name:SetText(TextManager.GetText(record.classnameTextID))
  self._prop1_Num:SetText(math.ceil(value))
  if self._basePropRecord[propIndex.secondProp] then
    value = self._basePropRecord[propIndex.secondProp].value
    record = CAttrNameTable:GetRecorder(self._basePropRecord[propIndex.secondProp].attrId)
    imageRecord = CImagePathTable:GetRecorder(record.classIcon) or DataCommon.DefaultImageAsset
    self._prop2_Panel:SetActive(true)
    self._prop2_Name:SetText(TextManager.GetText(record.classnameTextID))
    self._prop2_Num:SetText(math.ceil(value))
  else
    self._prop2_Panel:SetActive(false)
  end
  local temp = {
    tag = "Describe",
    value = self._equip:GetDestribe()
  }
  table.insert(self._downDataList, temp)
  self._frame:ReloadAllCell()
  local totallength = self._frame:GetTotalLength()
  local delta = totallength - self._oy
  if delta < 0 then
    self._panel:SetSize(self._x, self._ox, self._y, self._oy + delta)
    self:GetRootWindow():SetSize(self._rootX, self._rootOX, self._rooty, self._rootOY + delta)
    self._frame:SetSlide(false)
  end
  self._frame:MoveToTop()
end

local function SetTipsPosition(self, cell_width, cell_height, posX, posY)
  local newPos = {}
  local rightSpaceWidth = UIRootOffsetMax.x - (posX + cell_width / 2)
  if rightSpaceWidth > self._width then
    newPos.x = posX + cell_width / 2 + self._width / 2
  else
    newPos.x = posX - cell_width / 2 - self._width / 2
  end
  if posY + cell_height / 2 - self._height < -UIRootPanelOffsetMax.y then
    newPos.y = -UIRootPanelOffsetMax.y + self._height / 2
  else
    newPos.y = posY + cell_height / 2 - self._height / 2
  end
  self:GetRootWindow():SetAnchoredPosition(newPos.x, newPos.y)
end

function EquipTipsPreviewDialog:OnUpdate()
  if self._screenPixelChanged then
    self._screenPixelChanged = false
    self._width, self._height = self:GetRootWindow():GetRectSize()
    UIRootOffsetMax = UIManager.GetUiRootPanelOffsetMax()
    if self._parmFunc then
      local parms = self._parmFunc()
      SetTipsPosition(self, parms.width, parms.height, parms.posX, parms.posY)
    end
  end
end

function EquipTipsPreviewDialog:OnScreenPixelChanged()
  self._screenPixelChanged = true
end

function EquipTipsPreviewDialog:SetTipsParmFunc(parmFunc)
  self._parmFunc = parmFunc
  if parmFunc then
    local parms = parmFunc()
    SetTipsPosition(self, parms.width, parms.height, parms.posX, parms.posY)
  end
end

function EquipTipsPreviewDialog:NumberOfCell(frame, index)
  if frame == self._jobFrame then
    return #self._jobRecord
  else
    return #self._downDataList
  end
end

function EquipTipsPreviewDialog:CellAtIndex(frame, index)
  if frame == self._jobFrame then
    return "equip.equipbagjobcell"
  elseif self._downDataList[index].tag == "WordDescribe" then
    return "equip.equiptipworddescribecell"
  elseif self._downDataList[index].tag == "SuitInfo" then
    return "equip.equiptipssuitinfocell"
  elseif self._downDataList[index].tag == "SuitSkill" then
    return "equip.equiptipssuitskillcell"
  elseif self._downDataList[index].tag == "Describe" then
    return "equip.equiptipdescribecell"
  end
end

function EquipTipsPreviewDialog:DataAtIndex(frame, index)
  if frame == self._jobFrame then
    return self._jobRecord[index]
  else
    return self._downDataList[index]
  end
end

function EquipTipsPreviewDialog:OnRootWindowClick()
  self:Destroy()
end

function EquipTipsPreviewDialog:OnEveryWhereClick(args)
  if not UIManager.RectangleContainsScreenPoint(self:GetRootWindow()._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) then
    self:OnBackBtnClicked()
  end
end

function EquipTipsPreviewDialog:ShouldLengthChange()
  return true
end

function EquipTipsPreviewDialog:HasRandomPropOrSuit()
  local record = CEquipItemTable:GetRecorder(self._equip:GetID())
  return #record.randomAbility > 0 or self._equip:GetEquipSuitRecorder()
end

function EquipTipsPreviewDialog:OnBackBtnClicked()
  self:Destroy()
end

return EquipTipsPreviewDialog
