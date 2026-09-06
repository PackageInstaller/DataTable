local CstringCfg = BeanManager.GetTableByName("message.cstringres")
local CAttrNameTable = BeanManager.GetTableByName("role.cattreffectidname")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CGemSuitTable = BeanManager.GetTableByName("equip.cbaoshisuit")
local CEquipItemTable = BeanManager.GetTableByName("item.cequipitem")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local UIManager = CS.PixelNeko.UI.UIManager
local UIRootOffsetMax
local UIRootPanelOffsetMax = UIManager.GetUiRootPanelOffsetMax()
local TableFrame = require("framework.ui.frame.table.tableframe")
local Equip = require("logic.manager.experimental.types.equip")
local EquipTipsDialog = class("EquipTipsDialog", Dialog)
EquipTipsDialog.AssetBundleName = "ui/layouts.equip"
EquipTipsDialog.AssetName = "EquipTipsNew"

function EquipTipsDialog:Ctor(...)
  EquipTipsDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
  self._equip = nil
  self._downDataList = {}
  self._basePropRecord = {}
  UIRootOffsetMax = UIManager.GetUiRootOffsetMax()
end

function EquipTipsDialog:OnCreate()
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
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnRootWindowClick, self)
  self._width, self._height = self:GetRootWindow():GetRectSize()
  LuaNotificationCenter.AddObserver(self, self.OnUpdate, Common.n_Update, nil)
  LuaNotificationCenter.AddObserver(self, self.OnEveryWhereClick, Common.n_GlobalPointerWillDown, nil)
  LuaNotificationCenter.AddObserver(self, self.OnScreenPixelChanged, Common.n_ScreenPixelChanged, nil)
end

function EquipTipsDialog:OnDestroy()
  self._frame:Destroy()
  self._jobFrame:Destroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function EquipTipsDialog:Init(equipKey)
  local equip = NekoData.BehaviorManager.BM_BagInfo:GetEquipItem(equipKey)
  if not equip:IsChecked() then
    local cviewequip = LuaNetManager.CreateProtocol("protocol.item.cviewequip")
    if cviewequip then
      cviewequip.key = equipKey
      cviewequip:Send()
    end
  end
  self:RefreshInfo(equip)
end

function EquipTipsDialog:RefreshInfo(equip, isOtherUser)
  if isOtherUser then
    self._equip = Equip.Create(equip.itemId)
    local iteminfo = {}
    iteminfo.extra = {}
    iteminfo.extra.equipType = equip.equipType
    iteminfo.extra.level = equip.level
    iteminfo.extra.stage = equip.stage
    iteminfo.extra.power = equip.power
    iteminfo.extra.baseAttr = equip.baseAttr
    iteminfo.extra.finalAttr = equip.finalAttr
    iteminfo.extra.randomEntry = equip.randomEntry
    iteminfo.extra.finalAttrRandomEntry = equip.finalAttrRandomEntry
    iteminfo.extra.range = equip.range
    iteminfo.extra.recommend = equip.recommend
    iteminfo.extra.gems = equip.gems
    iteminfo.extra.gemSuitId = equip.gemSuitId
    self._equip:InitWithFull(iteminfo)
    self._levelLabelTxt:SetActive(false)
    self._levelMax:SetActive(false)
  else
    self._equip = equip
    local roleKey = self._equip:GetRoleKey()
    local role
    if roleKey ~= 0 then
      role = NekoData.BehaviorManager.BM_AllRoles:GetRole(roleKey)
    end
    self._levelLabelTxt:SetActive(true)
    self._levelMax:SetActive(true)
  end
  local record = self._equip:GetIcon()
  self._icon:SetSprite(record.assetBundle, record.assetName)
  record = self._equip:GetPinJiImage()
  self._equipFrame:SetSprite(record.assetBundle, record.assetName)
  self._level:SetText(self._equip:GetStrengthenLevel())
  self._levelMax:SetText(self._equip:GetStrengthenMaxLevel())
  self._equipName:SetText(self._equip:GetName())
  self._score:SetText(self._equip:GetScore())
  local roleKey = self._equip:GetRoleKey()
  if roleKey and roleKey ~= 0 then
    local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(roleKey)
    self._characterIcon:SetActive(true)
    self._characterBack:SetActive(true)
    local imageRecord = role:GetSkillHeadImageRecord()
    self._characterIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    self._characterIcon:SetActive(false)
    self._characterBack:SetActive(false)
  end
  self._jobRecord = {}
  self._jobField:SetActive(true)
  table.insert(self._jobRecord, self._equip:GetApplyVocation())
  local str = TextManager.GetText(CStringRes:GetRecorder(1198).msgTextID)
  self._jobFullTxt:SetText(str)
  self._jobFrame:ReloadAllCell()
  self._basePropRecord = {}
  record = CEquipItemTable:GetRecorder(self._equip:GetID())
  local baseRate = record.initMagnify + (self._equip:GetStrengthenLevel() - 1) + self._equip:GetCurrentBreakMultiple()
  for i, v in ipairs(record.abilityID) do
    local temp = {}
    temp.attrId = v
    temp.value = record.abilityValue[i] * baseRate * (1 + self._equip:GetGemSuitAttrRate(v))
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
  local randomWordList = self._equip:GetRandomEntry()
  self._downDataList = {}
  for i, v in pairs(randomWordList) do
    local temp = {}
    temp.tag = "RandomProp"
    temp.attrId = v.attr
    temp.value = v.attrValue
    temp.randomAbilityId = v.randomId
    temp.randomIndex = v.index
    temp.kind = v.kind
    table.insert(self._downDataList, temp)
  end
  local gemsAttr = self._equip:GetGemAttr()
  if 0 < table.nums(gemsAttr) then
    local gemShowAttrs = {}
    for attr, attrValue in pairs(gemsAttr) do
      temp = {}
      temp.tag = "GemProp"
      temp.attrId = attr
      temp.value = attrValue
      table.insert(gemShowAttrs, temp)
    end
    table.sort(gemShowAttrs, function(a, b)
      return a.attrId < b.attrId
    end)
    for _, v in ipairs(gemShowAttrs) do
      table.insert(self._downDataList, v)
    end
    local gemSuitID = self._equip:GetGemSuitId()
    if 0 < gemSuitID then
      local gemSuitCfg = CGemSuitTable:GetRecorder(gemSuitID)
      local suitNameData = {}
      suitNameData.tag = "GemSuit"
      suitNameData.showText = TextManager.GetText(gemSuitCfg.nameid)
      table.insert(self._downDataList, suitNameData)
      local suitEffectData = {}
      suitEffectData.tag = "GemSuit"
      suitEffectData.showText = NekoData.BehaviorManager.BM_Message:GetString(1046, {
        TextManager.GetText(gemSuitCfg.txtid)
      })
      table.insert(self._downDataList, suitEffectData)
    end
  end
  local suit = self._equip:GetEquipSuitRecorder()
  if suit then
    local temp = {}
    temp.tag = "SuitInfo"
    temp.suitName = suit.suitName
    temp.suitImg = suit.suitImg
    table.insert(self._downDataList, temp)
    local skillIDs = suit.suitSkillID
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

function EquipTipsDialog:OnUpdate()
  if self._screenPixelChanged then
    self._screenPixelChanged = false
    self._width, self._height = self:GetRootWindow():GetRectSize()
    UIRootOffsetMax = UIManager.GetUiRootOffsetMax()
    if self._parmFunc then
      local parms = self._parmFunc()
      SetTipsPosition(self, parms.width, parms.height, parms.posX, parms.posY)
    end
  end
end

function EquipTipsDialog:OnScreenPixelChanged()
  self._screenPixelChanged = true
end

function EquipTipsDialog:SetTipsParmFunc(parmFunc)
  self._parmFunc = parmFunc
  if parmFunc then
    local parms = parmFunc()
    SetTipsPosition(self, parms.width, parms.height, parms.posX, parms.posY)
  end
end

function EquipTipsDialog:NumberOfCell(frame, index)
  if frame == self._jobFrame then
    return #self._jobRecord
  else
    return #self._downDataList
  end
end

function EquipTipsDialog:CellAtIndex(frame, index)
  if frame == self._jobFrame then
    return "equip.equipbagjobcell"
  elseif self._downDataList[index].tag == "RandomProp" then
    return "equip.equiptiprandompropcell"
  elseif self._downDataList[index].tag == "GemProp" then
    return "equip.equiptipsgempropcell"
  elseif self._downDataList[index].tag == "GemSuit" then
    return "equip.equiptipsgemsuitcell"
  elseif self._downDataList[index].tag == "SuitInfo" then
    return "equip.equiptipssuitinfocell"
  elseif self._downDataList[index].tag == "SuitSkill" then
    return "equip.equiptipssuitskillcell"
  elseif self._downDataList[index].tag == "Describe" then
    return "equip.equiptipdescribecell"
  elseif self._downDataList[index].tag == "Title1" then
    return "equip.equiplisttitlecell1"
  end
end

function EquipTipsDialog:DataAtIndex(frame, index)
  if frame == self._jobFrame then
    return self._jobRecord[index]
  else
    return self._downDataList[index]
  end
end

function EquipTipsDialog:OnRootWindowClick()
  self:Destroy()
end

function EquipTipsDialog:OnEveryWhereClick(args)
  if not UIManager.RectangleContainsScreenPoint(self:GetRootWindow()._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) then
    self:OnBackBtnClicked()
  end
end

function EquipTipsDialog:ShouldLengthChange()
  return true
end

function EquipTipsDialog:HasRandomPropOrSuit()
  return #self._equip:GetRandomEntry() > 0 or self._equip:GetEquipSuitRecorder()
end

function EquipTipsDialog:OnBackBtnClicked()
  self:Destroy()
end

return EquipTipsDialog
