local TableFrame = require("framework.ui.frame.table.tableframe")
local MainCityState = require("logic.fsm.gamefsm.maincity")
local UIManager = CS.PixelNeko.UI.UIManager
local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local SingletonSlideFrame = require("logic.dialog.activity.starmirage.singletonslideframe")
local Skill = require("logic.manager.experimental.types.skill")
local Item = require("logic.manager.experimental.types.item")
local CharacterSkillDialog = class("CharacterSkillDialog", Dialog)
CharacterSkillDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
CharacterSkillDialog.AssetName = "CharSkillNew"

local function FinishGuide(self)
  if NekoData.BehaviorManager.BM_Guide:IsCurrentStage(14, 2) then
    LuaNotificationCenter.RemoveObserver(self, Common.n_GuideResponseClick)
    NekoData.BehaviorManager.BM_Guide:FinishGuide(14)
  end
end

function CharacterSkillDialog:Ctor(...)
  CharacterSkillDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._skillDetails = {}
  self._rowCellList = {}
  self._skillNodePosData = {}
  self._skillNodeLineCells = {}
  self._costItemList = {}
end

function CharacterSkillDialog:OnCreate()
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._manaBtn = self:GetChild("TopGroup/Num1")
  self._manaTxt = self:GetChild("TopGroup/Num1/Text")
  self._diamondBtn = self:GetChild("TopGroup/Num2")
  self._diamondTxt = self:GetChild("TopGroup/Num2/Text")
  self._diamondAddBtn = self:GetChild("TopGroup/Num2/Add")
  self._treePanel = self:GetChild("Frame/SkillFrame")
  self._treePanel_lineArea = self:GetChild("Frame/SkillFrame/FrameLine")
  self._treePanel_nodeArea = self:GetChild("Frame/SkillFrame/Frame")
  self._initLocal_posX, self._initLocal_posY, self._initLocal_posZ = self._treePanel:GetLocalPosition()
  self._activePanel = self:GetChild("Back/ActiveSkill")
  self._activePanel_skillName = self:GetChild("Back/ActiveSkill/SkillName")
  self._activePanel_level = self:GetChild("Back/ActiveSkill/Level/Txt3")
  self._activePanel_yellowCost = self:GetChild("Back/ActiveSkill/Cost/Num1")
  self._activePanel_purpleCost = self:GetChild("Back/ActiveSkill/Cost/Num2")
  self._activePanel_type = self:GetChild("Back/ActiveSkill/Type/Num")
  self._activePanel_range = self:GetChild("Back/ActiveSkill/Range/Num")
  self._activePanel_detail = self:GetChild("Back/ActiveSkill/Frame/Detail")
  self._skillDetails[Skill.Type.Active] = {}
  local map = self._skillDetails[Skill.Type.Active]
  map.panel = self._activePanel_detail
  map.initLocal_posX, map.initLocal_posY, map.initLocal_posZ = map.panel:GetLocalPosition()
  map.width, map.height = map.panel:GetRectSize()
  map.skillCell = DialogManager.CreateDialog("skill.skillcell", self:GetChild("Back/ActiveSkill/Skill")._uiObject)
  map.skillCell:HideFromCharacterSkillDialog()
  self._chargingPanel = self:GetChild("Back/EnergySkill")
  self._chargingPanel_skillName = self:GetChild("Back/EnergySkill/SkillName")
  self._chargingPanel_level = self:GetChild("Back/EnergySkill/Level/Txt3")
  self._chargingPanel_markPanel = self:GetChild("Back/EnergySkill/Cost/SkillMarkFrame")
  self._chargingPanel_markIBtn = self:GetChild("Back/EnergySkill/Cost/Ibtn")
  self._chargingPanel_type = self:GetChild("Back/EnergySkill/Type/Num")
  self._chargingPanel_range = self:GetChild("Back/EnergySkill/Range/Num")
  self._chargingPanel_detail = self:GetChild("Back/EnergySkill/Frame/Detail")
  self._skillDetails[Skill.Type.Charging] = {}
  local map = self._skillDetails[Skill.Type.Charging]
  map.panel = self._chargingPanel_detail
  map.initLocal_posX, map.initLocal_posY, map.initLocal_posZ = map.panel:GetLocalPosition()
  map.width, map.height = map.panel:GetRectSize()
  map.skillCell = DialogManager.CreateDialog("skill.skillcell", self:GetChild("Back/EnergySkill/Skill")._uiObject)
  map.skillCell:HideFromCharacterSkillDialog()
  self._chargingPanel_markFrame = TableFrame.Create(self._chargingPanel_markPanel, self, false, false)
  self._chargingPanel_markIBtn:Subscribe_PointerClickEvent(self.OnChargingIBtnClicked, self)
  self._passivePanel = self:GetChild("Back/PassiveSkill")
  self._passivePanel_skillName = self:GetChild("Back/PassiveSkill/SkillName")
  self._passivePanel_level = self:GetChild("Back/PassiveSkill/Level/Txt3")
  self._passivePanel_type = self:GetChild("Back/PassiveSkill/Type/Num")
  self._passivePanel_detail = self:GetChild("Back/PassiveSkill/Frame/Detail")
  self._skillDetails[Skill.Type.Passive] = {}
  local map = self._skillDetails[Skill.Type.Passive]
  map.panel = self._passivePanel_detail
  map.initLocal_posX, map.initLocal_posY, map.initLocal_posZ = map.panel:GetLocalPosition()
  map.width, map.height = map.panel:GetRectSize()
  map.skillCell = DialogManager.CreateDialog("skill.skillcell", self:GetChild("Back/PassiveSkill/Skill")._uiObject)
  map.skillCell:HideFromCharacterSkillDialog()
  self._attrPanel = self:GetChild("Back/PropSkill")
  self._attrPanel_skillName = self:GetChild("Back/PropSkill/SkillName")
  self._attrPanel_type = self:GetChild("Back/PropSkill/Type/Num")
  self._attrPanel_detail = self:GetChild("Back/PropSkill/Frame/Detail")
  self._skillDetails[Skill.Type.Attribute] = {}
  local map = self._skillDetails[Skill.Type.Attribute]
  map.panel = self._attrPanel_detail
  map.initLocal_posX, map.initLocal_posY, map.initLocal_posZ = map.panel:GetLocalPosition()
  map.width, map.height = map.panel:GetRectSize()
  map.skillCell = DialogManager.CreateDialog("skill.skillcell", self:GetChild("Back/PropSkill/Skill")._uiObject)
  map.skillCell:HideFromCharacterSkillDialog()
  self._lockPanel = self:GetChild("Back/Down")
  self._lockPanel_lvNotEnough = self:GetChild("Back/Down/Lock1")
  self._lockPanel_lvNotEnough_needLv = self:GetChild("Back/Down/Lock1/Level/Num")
  self._lockPanel_lvNotEnough_needBreakLvBack = self:GetChild("Back/Down/Lock1/BreakLevelBack")
  self._lockPanel_lvNotEnough_needBreakLv = self:GetChild("Back/Down/Lock1/BreakLevelNum")
  self._lockPanel_frontNodeLock = self:GetChild("Back/Down/Lock2")
  self:GetChild("Back/Down/Lock2/Txt"):SetText(NekoData.BehaviorManager.BM_Message:GetString(1482))
  self._lockPanel_costMana = self:GetChild("Back/Down/Need")
  self._lockPanel_costManaNum = self:GetChild("Back/Down/Need/Txt2")
  self._lockPanel_costManaNumRed = self:GetChild("Back/Down/Need/Txt2Red")
  self._lockPanel_costItemPanel = self:GetChild("Back/Down/Need/ItemFrame")
  self._lockPanel_btn = self:GetChild("Back/Down/Btn")
  self._lockPanel_btnTxt = self:GetChild("Back/Down/Btn/_Text")
  self._lockPanel_costItemFrame = TableFrame.Create(self._lockPanel_costItemPanel, self, false, false)
  self._lockPanel_btn:Subscribe_PointerClickEvent(self.OnUnlockBtnClicked, self)
  self._unlockPanel = self:GetChild("Back/UnLock")
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._manaBtn:Subscribe_PointerClickEvent(self.OnManaBtnClick, self)
  self._diamondBtn:Subscribe_PointerClickEvent(self.OnDiamondBtnClick, self)
  self._diamondAddBtn:Subscribe_PointerClickEvent(self.OnDiamondAddBtnClick, self)
  self:OnAPChange()
  local cellDialog = DialogManager.CreateDialog("character.characterskillrowcell", nil)
  self._rowCellWidth, self._rowCellHeight = cellDialog._rootWindow:GetRectSize()
  cellDialog:RootWindowDestroy()
  LuaNotificationCenter.AddObserver(self, self.OnAPChange, Common.n_RefreshCurrency, nil)
  LuaNotificationCenter.AddObserver(self, self.OnSkillUnlock, Common.n_ImproveSkill, nil)
  LuaNotificationCenter.AddObserver(self, self.OnScreenPixelChanged, Common.n_ScreenPixelChanged, nil)
  LuaNotificationCenter.AddObserver(self, self.OnUpdate, Common.n_Update, nil)
  LuaNotificationCenter.AddObserver(self, FinishGuide, Common.n_GuideResponseClick, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRedPointNumChanged, Common.n_RedPointNumChanged, nil)
  local dialog = DialogManager.GetDialog("battle.battleaccount.battlelosetextdialog")
  if dialog then
    self._menuBtn:SetActive(false)
    self._diamondAddBtn:SetActive(false)
  end
  if GlobalGameFSM and GlobalGameFSM:GetCurrentState() == "MainCityBattle" and MainCityState.uIBackManagerIsActive then
    UIBackManager.SetActive(true)
  else
    UIBackManager.SetUIBackShow(true)
    UIBackManager.SetUIModalBackColor(2)
  end
end

function CharacterSkillDialog:OnDestroy()
  if GlobalGameFSM and GlobalGameFSM:GetCurrentState() == "MainCityBattle" and MainCityState.uIBackManagerIsActive then
    UIBackManager.SetActive(false)
  else
    UIBackManager.SetUIBackShow(false)
  end
  LuaNotificationCenter.RemoveObserver(self)
  self._chargingPanel_markFrame:Destroy()
  self._lockPanel_costItemFrame:Destroy()
  while self._rowCellList[#self._rowCellList] do
    local dialog = self._rowCellList[#self._rowCellList]
    dialog:Destroy()
    dialog:RootWindowDestroy()
    table.remove(self._rowCellList, #self._rowCellList)
  end
  while self._skillNodeLineCells[#self._skillNodeLineCells] do
    local dialog = self._skillNodeLineCells[#self._skillNodeLineCells]
    dialog:Destroy()
    dialog:RootWindowDestroy()
    table.remove(self._skillNodeLineCells, #self._skillNodeLineCells)
  end
end

function CharacterSkillDialog:OnSkillUnlock(notification)
  if notification.userInfo.roleId == self._role:GetId() then
    self._sendProtocol = false
    self._role = NekoData.BehaviorManager.BM_AllRoles:GetRole(self._role:GetId())
    self._unlockSkillNodes = self._role:GetUnlockSkillNodes()
    self:RefreshSkillNode()
    self:RefreshDetailPanel()
  end
end

local function BuildRowNodeData(self)
  local rowNum
  local map = {}
  for k, v in pairs(self._allSkillNodes) do
    local posList = string.split(v.position, ";")
    local row = tonumber(posList[1])
    if not rowNum or rowNum < row then
      rowNum = row
    end
    local frontList
    if v.frontNode ~= "-1" then
      frontList = string.split(v.frontNode, ";")
    end
    local frontNodeList = {}
    if frontList then
      for _, nodeId in ipairs(frontList) do
        table.insert(frontNodeList, tonumber(nodeId))
      end
    end
    local column = tonumber(posList[2])
    self._skillNodePosData[v.id] = {
      pos = {row = row, column = column},
      frontNodeList = frontNodeList
    }
    if not map[row] then
      map[row] = {}
    end
    map[row][column] = true
  end
  local skillRowCell = DialogManager.CreateDialog("character.characterskillrowcell", self._treePanel_nodeArea._uiObject)
  for i = 1, rowNum do
    local dialog = DialogManager.CopyDialog("character.characterskillrowcell", skillRowCell._rootWindow._uiObject, self._treePanel_nodeArea._uiObject)
    dialog:GetRootWindow():SetAnchoredPosition(0, -((i - 1) * self._rowCellHeight))
    dialog:Init(self, i, map[i])
    table.insert(self._rowCellList, dialog)
  end
  skillRowCell:RootWindowDestroy()
  local width, height = self._treePanel:GetDeltaSize()
  self._treePanel:SetDeltaSize(width, self._rowCellHeight * rowNum)
  local local_maxPosY = self._initLocal_posY + self._rowCellHeight * rowNum - height
  self._singletonSlideFrame = SingletonSlideFrame.Create(self._treePanel, true, self._initLocal_posY, local_maxPosY)
  local x, y, z = self._treePanel:GetLocalPosition()
  local posY = y + (self._skillNodePosData[self._selectNodeId].pos.row - 3) * self._rowCellHeight
  if posY < self._initLocal_posY then
    posY = self._initLocal_posY
  elseif local_maxPosY < posY then
    posY = local_maxPosY
  end
  self._treePanel:SetLocalPosition(x, posY, self._local_posZ)
end

local function BuildSkillNodeLines(self)
  local skillLineCell = DialogManager.CreateDialog("character.characterskilllinecell", self._treePanel_lineArea._uiObject)
  for k, v in pairs(self._allSkillNodes) do
    local data = self._skillNodePosData[k]
    if #data.frontNodeList > 0 then
      for _, frontNodeId in ipairs(data.frontNodeList) do
        local startLocation = self._skillNodePosData[frontNodeId].pos
        local startChild = self._rowCellList[startLocation.row]._posChilds[startLocation.column].panel
        local endLocation = self._skillNodePosData[k].pos
        local endChild = self._rowCellList[endLocation.row]._posChilds[endLocation.column].panel
        local startPos = UIManager.InverseTransformPoint(self._treePanel_lineArea._uiObject, CS.UnityEngine.Vector3(TransformStaticFunctions.GetPosition(startChild._uiObject)))
        local endPos = UIManager.InverseTransformPoint(self._treePanel_lineArea._uiObject, CS.UnityEngine.Vector3(TransformStaticFunctions.GetPosition(endChild._uiObject)))
        local deltaX = endPos.x - startPos.x
        local deltaY = endPos.y - startPos.y
        local len = (deltaX ^ 2 + deltaY ^ 2) ^ 0.5
        local dialog = DialogManager.CopyDialog("character.characterskilllinecell", skillLineCell._rootWindow._uiObject, self._treePanel_lineArea._uiObject)
        dialog._rootWindow:SetWidth(0, len)
        dialog._rootWindow:SetZRotation(1, 0, deltaX, deltaY)
        TransformStaticFunctions.SetLocalPosition(dialog._rootWindow._uiObject, (startPos.x + endPos.x) / 2, (startPos.y + endPos.y) / 2, startPos.z)
        table.insert(self._skillNodeLineCells, dialog)
      end
    end
  end
  skillLineCell:RootWindowDestroy()
end

function CharacterSkillDialog:SetData(roleId)
  self._role = NekoData.BehaviorManager.BM_AllRoles:GetRole(roleId)
  self._selectNodeId = self._role:GetFirstSelectNodeId()
  self._allSkillNodes = self._role:GetAllSkillNodes()
  self._unlockSkillNodes = self._role:GetUnlockSkillNodes()
  BuildRowNodeData(self)
  BuildSkillNodeLines(self)
  self:RefreshSkillNode()
  self:RefreshDetailPanel()
  LuaNotificationCenter.PostNotification(Common.n_TriggerGuide, self, nil)
end

function CharacterSkillDialog:RefreshSkillNode()
  for k, v in pairs(self._allSkillNodes) do
    local data = self._skillNodePosData[k]
    self._rowCellList[data.pos.row]:Refresh(v)
  end
  for i, v in ipairs(self._rowCellList) do
    v:AllSkillNodesRefreshFinished()
  end
end

function CharacterSkillDialog:OnScreenPixelChanged()
  self._screenPixelChanged = true
end

function CharacterSkillDialog:OnUpdate()
  if self._screenPixelChanged then
    self._screenPixelChanged = false
    local nodeRecord = self._allSkillNodes[self._selectNodeId]
    local skillId = nodeRecord.skillID
    local skill
    if NekoData.BehaviorManager.BM_Game:IsSkillItemId(skillId) then
      skill = Skill.Create(skillId)
      skill:SetLevel(nodeRecord.skillLevel)
    else
      skill = Skill.Create(skillId, true)
    end
    local type = skill:GetType()
    local map = self._skillDetails[type]
    if map then
      if map.slideFrame then
        map.slideFrame:Destroy()
        map.slideFrame = nil
      end
      local _, textHeight = map.panel:GetPreferredSize()
      if textHeight > map.height then
        local delta = textHeight - map.height
        map.panel:SetDeltaSize(map.width, textHeight)
        map.panel:SetLocalPosition(map.initLocal_posX, map.initLocal_posY, map.initLocal_posZ)
        map.slideFrame = SingletonSlideFrame.Create(map.panel, true, map.initLocal_posY, map.initLocal_posY + delta)
      else
        map.panel:SetDeltaSize(map.width, map.height)
        map.panel:SetLocalPosition(map.initLocal_posX, map.initLocal_posY, map.initLocal_posZ)
      end
    end
  end
end

function CharacterSkillDialog:RefreshDetailPanel()
  local nodeRecord = self._allSkillNodes[self._selectNodeId]
  local skillId = nodeRecord.skillID
  local skill
  if NekoData.BehaviorManager.BM_Game:IsSkillItemId(skillId) then
    skill = Skill.Create(skillId)
    skill:SetLevel(nodeRecord.skillLevel)
  else
    skill = Skill.Create(skillId, true)
  end
  local type = skill:GetType()
  local level = skill:GetSkillLevel()
  local name = skill:GetSkillName()
  local typeTxt = skill:GetTypeTxt()
  local detail = skill:GetDescribeTxt()
  if type == Skill.Type.Active then
    self._activePanel:SetActive(true)
    self._chargingPanel:SetActive(false)
    self._passivePanel:SetActive(false)
    self._attrPanel:SetActive(false)
    self._activePanel_skillName:SetText(name)
    self._activePanel_level:SetText(level)
    self._activePanel_yellowCost:SetText(skill:GetYellowCost())
    self._activePanel_purpleCost:SetText(skill:GetPurpleCost())
    self._activePanel_type:SetText(typeTxt)
    self._activePanel_range:SetText(skill:GetRangeTxt())
    self._activePanel_detail:SetText(detail)
    local maxlevel = skill:GetSkillMaxLevel()
    if level >= maxlevel then
    end
  elseif type == Skill.Type.Charging then
    self._activePanel:SetActive(false)
    self._chargingPanel:SetActive(true)
    self._passivePanel:SetActive(false)
    self._attrPanel:SetActive(false)
    self._chargingPanel_skillName:SetText(name)
    self._chargingPanel_level:SetText(level)
    self._chargingPanel_type:SetText(typeTxt)
    self._chargingPanel_range:SetText(skill:GetRangeTxt())
    self._chargingPanel_detail:SetText(detail)
    self.chargingMarkNum = skill:GetChargingNumByRoleId(self._role:GetId())
    self._chargingPanel_markFrame:ReloadAllCell()
    local maxlevel = skill:GetSkillMaxLevel()
    if level >= maxlevel then
    end
  elseif type == Skill.Type.Passive then
    self._activePanel:SetActive(false)
    self._chargingPanel:SetActive(false)
    self._passivePanel:SetActive(true)
    self._attrPanel:SetActive(false)
    self._passivePanel_skillName:SetText(name)
    self._passivePanel_level:SetText(level)
    self._passivePanel_type:SetText(typeTxt)
    self._passivePanel_detail:SetText(detail)
    local maxlevel = skill:GetSkillMaxLevel()
    if level >= maxlevel then
    end
  elseif type == Skill.Type.Attribute then
    self._activePanel:SetActive(false)
    self._chargingPanel:SetActive(false)
    self._passivePanel:SetActive(false)
    self._attrPanel:SetActive(true)
    self._attrPanel_skillName:SetText(name)
    self._attrPanel_type:SetText(typeTxt)
    self._attrPanel_detail:SetText(detail)
  end
  local map = self._skillDetails[type]
  if map then
    if map.slideFrame then
      map.slideFrame:Destroy()
      map.slideFrame = nil
    end
    local _, textHeight = map.panel:GetPreferredSize()
    if textHeight > map.height then
      local delta = textHeight - map.height
      map.panel:SetDeltaSize(map.width, textHeight)
      map.panel:SetLocalPosition(map.initLocal_posX, map.initLocal_posY, map.initLocal_posZ)
      map.slideFrame = SingletonSlideFrame.Create(map.panel, true, map.initLocal_posY, map.initLocal_posY + delta)
    else
      map.panel:SetDeltaSize(map.width, map.height)
      map.panel:SetLocalPosition(map.initLocal_posX, map.initLocal_posY, map.initLocal_posZ)
    end
    map.skillCell:Init(skill)
  end
  self:RefreshCostPanel()
end

function CharacterSkillDialog:RefreshCostPanel()
  local nodeRecord = self._allSkillNodes[self._selectNodeId]
  local unlock = self._unlockSkillNodes[nodeRecord.id]
  if unlock then
    self._lockPanel:SetActive(false)
    self._unlockPanel:SetActive(true)
  else
    self._lockPanel:SetActive(true)
    self._unlockPanel:SetActive(false)
    local isSpecialUnlock = nodeRecord.serverUnlock ~= 0
    if not isSpecialUnlock then
      self._lockPanel_costMana:SetActive(true)
      local roleLvEnough = self._role:GetLevel() >= nodeRecord.roleSkill
      if not roleLvEnough then
        self._lockPanel_lvNotEnough:SetActive(true)
        self._lockPanel_frontNodeLock:SetActive(false)
        self._lockPanel_costMana:SetActive(false)
        self._lockPanel_btn:SetActive(false)
        local breakRecorder
        local breakRecordList = self._role:GetBreakRecordList()
        for i, recorder in ipairs(breakRecordList) do
          if nodeRecord.roleSkill <= recorder.levelmax then
            breakRecorder = recorder
            break
          end
        end
        self._lockPanel_lvNotEnough_needBreakLvBack:SetActive(0 < breakRecorder.breaklv)
        self._lockPanel_lvNotEnough_needBreakLv:SetActive(0 < breakRecorder.breaklv)
        if 0 < breakRecorder.breaklv then
          self._lockPanel_lvNotEnough_needBreakLv:SetText(breakRecorder.breaklv)
        end
        self._lockPanel_lvNotEnough_needLv:SetText(nodeRecord.roleSkill - breakRecorder.levelmin)
        return
      end
      local frontNodesUnlock = true
      local frontNodeList = self._skillNodePosData[self._selectNodeId].frontNodeList
      for _, v in ipairs(frontNodeList) do
        if not self._unlockSkillNodes[v] then
          frontNodesUnlock = false
          break
        end
      end
      if not frontNodesUnlock then
        self._lockPanel_lvNotEnough:SetActive(false)
        self._lockPanel_frontNodeLock:SetActive(true)
        self._lockPanel_costMana:SetActive(false)
        self._lockPanel_btn:SetActive(false)
        return
      end
      local costEnough = true
      self._lockPanel_lvNotEnough:SetActive(false)
      self._lockPanel_frontNodeLock:SetActive(false)
      self._lockPanel_costMana:SetActive(true)
      self._lockPanel_btn:SetActive(true)
      self._lockPanel_btnTxt:SetText(NekoData.BehaviorManager.BM_Message:GetString(1483))
      local mana = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.ManaID)
      if mana < nodeRecord.money then
        self._lockPanel_costManaNum:SetActive(false)
        self._lockPanel_costManaNumRed:SetActive(true)
        self._lockPanel_costManaNumRed:SetText(nodeRecord.money)
        costEnough = false
      else
        self._lockPanel_costManaNum:SetActive(true)
        self._lockPanel_costManaNumRed:SetActive(false)
        self._lockPanel_costManaNum:SetText(nodeRecord.money)
      end
      while self._costItemList[#self._costItemList] do
        table.remove(self._costItemList, #self._costItemList)
      end
      for i, v in ipairs(nodeRecord.itemID) do
        local num = nodeRecord.itemNum[i]
        table.insert(self._costItemList, {itemId = v, itemNum = num})
        if costEnough then
          local haveNum = NekoData.BehaviorManager.BM_BagInfo:GetItemCountById(v)
          costEnough = num <= haveNum
        end
      end
      self._lockPanel_costItemFrame:ReloadAllCell()
      if not costEnough then
        self._lockPanel_btn:SetInteractable(false)
      else
        self._lockPanel_btn:SetInteractable(true)
      end
    else
      self._lockPanel_lvNotEnough:SetActive(false)
      self._lockPanel_frontNodeLock:SetActive(false)
      self._lockPanel_costMana:SetActive(false)
      self._lockPanel_btn:SetActive(true)
      self._lockPanel_btn:SetInteractable(false)
      self._lockPanel_btnTxt:SetText(NekoData.BehaviorManager.BM_Message:GetString(nodeRecord.serverUnlockText))
    end
  end
end

function CharacterSkillDialog:SelectSkillNode(skillNodeId)
  if self._selectNodeId ~= skillNodeId then
    self._selectNodeId = skillNodeId
    for i, v in ipairs(self._rowCellList) do
      v:OnEvent("SetSelected")
    end
    self:RefreshDetailPanel()
  end
end

function CharacterSkillDialog:OnRedPointNumChanged(notification)
  if notification.userInfo.redPointID == 4 then
    for i, v in ipairs(self._rowCellList) do
      v:OnEvent("RefreshRedDot")
    end
  end
end

function CharacterSkillDialog:NumberOfCell(frame, index)
  if frame == self._chargingPanel_markFrame then
    return self.chargingMarkNum
  elseif frame == self._lockPanel_costItemFrame then
    return #self._costItemList
  end
end

function CharacterSkillDialog:CellAtIndex(frame, index)
  if frame == self._chargingPanel_markFrame then
    return "character.chargingmarkcell"
  elseif frame == self._lockPanel_costItemFrame then
    return "skill.skillitemcell"
  end
end

function CharacterSkillDialog:DataAtIndex(frame, index)
  if frame == self._chargingPanel_markFrame then
    return true
  elseif frame == self._lockPanel_costItemFrame then
    return self._costItemList[index]
  end
end

function CharacterSkillDialog:OnUnlockBtnClicked()
  if not self._sendProtocol then
    local csend = LuaNetManager.CreateProtocol("protocol.skill.cimproveskill")
    csend.roleId = self._role:GetRoleId()
    csend.unlockNode = self._selectNodeId
    csend:Send()
    self._sendProtocol = true
  end
end

function CharacterSkillDialog:OnAPChange()
  self._manaTxt:SetNumber(NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.ManaID))
  self._diamondTxt:SetNumber(NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.DiamodID))
end

function CharacterSkillDialog:OnManaBtnClick()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = Item.Create(DataCommon.ManaID)
    })
    local width, height = self._manaBtn:GetRectSize()
    tipsDialog:SetTipsPosition(width, height, self._manaBtn:GetLocalPointInUiRootPanel())
  end
end

function CharacterSkillDialog:OnDiamondBtnClick()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = Item.Create(DataCommon.DiamodID)
    })
    local width, height = self._diamondBtn:GetRectSize()
    tipsDialog:SetTipsPosition(width, height, self._diamondBtn:GetLocalPointInUiRootPanel())
  end
end

function CharacterSkillDialog:OnDiamondAddBtnClick()
  if not NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Shop) then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100192)
  else
    local baseSceneController = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.Base)
    if baseSceneController then
      DialogManager.GetGroup("Modal"):ReturnModalDialog()
      NekoData.DataManager.DM_Shop:ClientSetOpenShopID(4)
      baseSceneController:SetCameraAnimatorState(0)
      local protocol = LuaNetManager.CreateProtocol("protocol.shop.copenshop")
      if protocol then
        protocol:Send()
      end
    end
  end
end

function CharacterSkillDialog:OnChargingIBtnClicked()
  DialogManager.CreateSingletonDialog("skill.chargingskillusageruledialog")
end

function CharacterSkillDialog:OnBackBtnClicked()
  self:Destroy()
end

function CharacterSkillDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

return CharacterSkillDialog
