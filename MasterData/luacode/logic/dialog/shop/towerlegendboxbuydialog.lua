local CstringCfg = BeanManager.GetTableByName("message.cstringres")
local CAttrNameTable = BeanManager.GetTableByName("role.cattreffectidname")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local Cequipbreakcfg = BeanManager.GetTableByName("equip.cequipbreakcfg")
local CEquipItemTable = BeanManager.GetTableByName("item.cequipitem")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CGemSuitTable = BeanManager.GetTableByName("equip.cbaoshisuit")
local UIManager = CS.PixelNeko.UI.UIManager
local UIRootOffsetMax = UIManager.GetUiRootOffsetMax()
local UIRootPanelOffsetMax = UIManager.GetUiRootPanelOffsetMax()
local TableFrame = require("framework.ui.frame.table.tableframe")
local Equip = require("logic.manager.experimental.types.equip")
local TowerLegendBoxBuyDialog = class("TowerLegendBoxBuyDialog", Dialog)
TowerLegendBoxBuyDialog.AssetBundleName = "ui/layouts.baseshop"
TowerLegendBoxBuyDialog.AssetName = "TowerLegendBoxBuy"

function TowerLegendBoxBuyDialog:Ctor(...)
  TowerLegendBoxBuyDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
  self._equip = nil
  self._downDataList = {}
  self._basePropRecord = {}
  self._time = 0
  self.showIndex = 0
end

function TowerLegendBoxBuyDialog:OnCreate()
  self._tipsPanel = self:GetChild("EquipTipsNew")
  self._icon = self:GetChild("EquipTipsNew/TipsBack/Top/EquipCell/BackGround/Icon")
  self._equipIcon = self:GetChild("Equip")
  self._characterIcon = self:GetChild("EquipTipsNew/TipsBack/Top/EquipCell/CharPhoto")
  self._characterBack = self:GetChild("EquipTipsNew/TipsBack/Top/EquipCell/CharBack")
  self._equipFrame = self:GetChild("EquipTipsNew/TipsBack/Top/EquipCell/BackGround/Frame")
  self._level = self:GetChild("EquipTipsNew/TipsBack/Top/Level/Num")
  self._levelLabelTxt = self:GetChild("EquipTipsNew/TipsBack/Top/Level/Txt")
  self._levelMax = self:GetChild("EquipTipsNew/TipsBack/Top/Level/NumMax")
  self._equipName = self:GetChild("EquipTipsNew/TipsBack/Top/EquipName")
  self._score = self:GetChild("EquipTipsNew/TipsBack/Top/Fight/Num")
  self._prop1_Icon = self:GetChild("EquipTipsNew/TipsBack/Prop1/Image")
  self._prop1_Name = self:GetChild("EquipTipsNew/TipsBack/Prop1/Name")
  self._prop1_Num = self:GetChild("EquipTipsNew/TipsBack/Prop1/Num")
  self._prop2_Panel = self:GetChild("EquipTipsNew/TipsBack/Prop2")
  self._prop2_Icon = self:GetChild("EquipTipsNew/TipsBack/Prop2/Image")
  self._prop2_Name = self:GetChild("EquipTipsNew/TipsBack/Prop2/Name")
  self._prop2_Num = self:GetChild("EquipTipsNew/TipsBack/Prop2/Num")
  self._panel = self:GetChild("EquipTipsNew/TipsBack/Frame")
  self._shipBtn = self:GetChild("SkipBtn")
  self._jobField = self:GetChild("EquipTipsNew/TipsBack/Top/Job/JobFrame")
  self._jobFullTxt = self:GetChild("EquipTipsNew/TipsBack/Top/Job/Txt")
  self._jobFrame = TableFrame.Create(self._jobField, self, false, false)
  self._frame = TableFrame.Create(self._panel, self, true, true, true)
  self._frame:SetMargin(15, 0)
  self._width, self._height = self:GetRootWindow():GetRectSize()
  LuaNotificationCenter.AddObserver(self, self.OnUpdate, Common.n_Update, nil)
  LuaNotificationCenter.AddObserver(self, self.OnEveryWhereClick, Common.n_GlobalPointerWillDown, nil)
  self._rootWindow:Subscribe_StateExitEvent(self.OnAnimationStateExit, self)
  self._shipBtn:Subscribe_PointerClickEvent(self.OnSkip, self)
end

function TowerLegendBoxBuyDialog:OnDestroy()
  self._frame:Destroy()
  self._jobFrame:Destroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function TowerLegendBoxBuyDialog:Init(equipKey)
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

function TowerLegendBoxBuyDialog:RefreshInfo(equip, isOtherUser)
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
    iteminfo.extra.range = equip.range
    iteminfo.extra.recommend = equip.recommend
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
  self._equipIcon:SetSprite(record.assetBundle, record.assetName)
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
  for i, v in ipairs(record.abilityID) do
    local temp = {}
    temp.attrId = v
    temp.value = record.abilityValue[i] * (record.initMagnify + (self._equip:GetStrengthenLevel() - 1) + self._equip:GetCurrentBreakMultiple()) * (1 + self._equip:GetGemSuitAttrRate(v))
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
  local cequipbreakcfgAll = Cequipbreakcfg:GetAllIds()
  local unLockNumRecord
  for i, id in pairs(cequipbreakcfgAll) do
    local record = Cequipbreakcfg:GetRecorder(id)
    if self._equip:GetPinJiID() == record.pinJi and self._equip:GetStage() == record.breaklv then
      unLockNumRecord = record.unlockAbilityNum
    end
  end
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
    temp = {}
    temp.tag = "Title1"
    temp.titleID = 702682
    table.insert(self._downDataList, temp)
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
      suitNameData.color = "FFFFFF"
      table.insert(self._downDataList, suitNameData)
      local suitEffectData = {}
      suitEffectData.tag = "GemSuit"
      suitEffectData.showText = NekoData.BehaviorManager.BM_Message:GetString(1046, {
        TextManager.GetText(gemSuitCfg.txtid)
      })
      suitEffectData.color = "81C65B"
      table.insert(self._downDataList, suitEffectData)
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
  local temp = {
    tag = "Describe",
    value = self._equip:GetDestribe()
  }
  table.insert(self._downDataList, temp)
  self._frame:ReloadAllCell()
  self._frame:MoveToTop()
  self:GetDownLogicCell()
end

function TowerLegendBoxBuyDialog:OnUpdate(notification)
  if not self.showOneByOneEnd and self._animationEnd then
    self._time = self._time + notification.userInfo.deltaTime
    if self._time > 1 then
      self.showIndex = self.showIndex + 1
      if self._downLogicCell[self.showIndex]._cell then
        self._downLogicCell[self.showIndex]._cell:GetRootWindow():SetActive(true)
      end
      self._time = 0
    end
    if self.showIndex == #self._downLogicCell then
      self.showOneByOneEnd = true
    end
  end
end

function TowerLegendBoxBuyDialog:OnAnimationStateExit(handler, stateName, normalizedTime)
  if stateName == "LegendBoxOpen" then
    self._animationEnd = true
  end
end

function TowerLegendBoxBuyDialog:GetDownLogicCell()
  self._downLogicCell = {}
  for i = 1, #self._downDataList do
    local tempLogicCell = self._frame:GetLogicCell(i)
    if tempLogicCell._cell then
      tempLogicCell._cell:GetRootWindow():SetActive(false)
    end
    table.insert(self._downLogicCell, tempLogicCell)
  end
end

function TowerLegendBoxBuyDialog:OnScreenPixelChanged()
  self._screenPixelChanged = true
end

function TowerLegendBoxBuyDialog:NumberOfCell(frame, index)
  if frame == self._jobFrame then
    return #self._jobRecord
  else
    return #self._downDataList
  end
end

function TowerLegendBoxBuyDialog:CellAtIndex(frame, index)
  if frame == self._jobFrame then
    return "equip.equipbagjobcell"
  elseif self._downDataList[index].tag == "RandomProp" then
    return "equip.equiptiprandompropcell"
  elseif self._downDataList[index].tag == "GemSuit" then
    return "equip.equiptipsgemsuitcell"
  elseif self._downDataList[index].tag == "SuitInfo" then
    return "equip.equiptipssuitinfocell"
  elseif self._downDataList[index].tag == "SuitInfo" then
    return "equip.equiptipssuitinfocell"
  elseif self._downDataList[index].tag == "SuitSkill" then
    return "equip.equiptipssuitskillcell"
  elseif self._downDataList[index].tag == "RandomSkill" then
    return "equip.equiptipskillcell"
  elseif self._downDataList[index].tag == "Describe" then
    return "equip.equiptipdescribecell"
  elseif self._downDataList[index].tag == "Title1" then
    return "equip.equiplisttitlecell1"
  end
end

function TowerLegendBoxBuyDialog:DataAtIndex(frame, index)
  if frame == self._jobFrame then
    return self._jobRecord[index]
  else
    return self._downDataList[index]
  end
end

function TowerLegendBoxBuyDialog:OnEveryWhereClick(args)
  if not UIManager.RectangleContainsScreenPoint(self._tipsPanel._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) then
    self:OnBackBtnClicked()
  end
end

function TowerLegendBoxBuyDialog:OnBackBtnClicked()
  if self.showOneByOneEnd then
    self:Destroy()
  end
end

function TowerLegendBoxBuyDialog:OnSkip()
  self:GetRootWindow():PlayAnimation("LegendBoxHold")
  self.showOneByOneEnd = true
  for i, v in ipairs(self._downLogicCell) do
    if v._cell then
      v._cell:GetRootWindow():SetActive(true)
    end
  end
end

return TowerLegendBoxBuyDialog
