-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/character/characterskilldialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local MainCityState = require("logic.fsm.gamefsm.maincity")
local UIManager = ((CS.PixelNeko).UI).UIManager
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local SingletonSlideFrame = require("logic.dialog.activity.starmirage.singletonslideframe")
local Skill = require("logic.manager.experimental.types.skill")
local Item = require("logic.manager.experimental.types.item")
local CharacterSkillDialog = class("CharacterSkillDialog", Dialog)
CharacterSkillDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
CharacterSkillDialog.AssetName = "CharSkillNew"
local FinishGuide = function(self)
  -- function num : 0_0 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_Guide):IsCurrentStage(14, 2) then
    (LuaNotificationCenter.RemoveObserver)(self, Common.n_GuideResponseClick)
    ;
    ((NekoData.BehaviorManager).BM_Guide):FinishGuide(14)
  end
end

CharacterSkillDialog.Ctor = function(self, ...)
  -- function num : 0_1 , upvalues : CharacterSkillDialog
  ((CharacterSkillDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._skillDetails = {}
  self._rowCellList = {}
  self._skillNodePosData = {}
  self._skillNodeLineCells = {}
  self._costItemList = {}
end

CharacterSkillDialog.OnCreate = function(self)
  -- function num : 0_2 , upvalues : Skill, _ENV, TableFrame, FinishGuide, MainCityState
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
  self._initLocal_posX = (self._treePanel):GetLocalPosition()
  self._activePanel = self:GetChild("Back/ActiveSkill")
  self._activePanel_skillName = self:GetChild("Back/ActiveSkill/SkillName")
  self._activePanel_level = self:GetChild("Back/ActiveSkill/Level/Txt3")
  self._activePanel_yellowCost = self:GetChild("Back/ActiveSkill/Cost/Num1")
  self._activePanel_purpleCost = self:GetChild("Back/ActiveSkill/Cost/Num2")
  self._activePanel_type = self:GetChild("Back/ActiveSkill/Type/Num")
  self._activePanel_range = self:GetChild("Back/ActiveSkill/Range/Num")
  self._activePanel_detail = self:GetChild("Back/ActiveSkill/Frame/Detail")
  -- DECOMPILER ERROR at PC82: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._skillDetails)[(Skill.Type).Active] = {}
  local map = (self._skillDetails)[(Skill.Type).Active]
  map.panel = self._activePanel_detail
  map.initLocal_posX = (map.panel):GetLocalPosition()
  map.width = (map.panel):GetRectSize()
  -- DECOMPILER ERROR at PC106: Overwrote pending register: R4 in 'AssignReg'

  map.skillCell = (DialogManager.CreateDialog)("skill.skillcell", R4_PC92)
  ;
  (map.skillCell):HideFromCharacterSkillDialog()
  -- DECOMPILER ERROR at PC113: Overwrote pending register: R4 in 'AssignReg'

  self._chargingPanel = self:GetChild(R4_PC92)
  -- DECOMPILER ERROR at PC117: Overwrote pending register: R4 in 'AssignReg'

  self._chargingPanel_skillName = self:GetChild(R4_PC92)
  -- DECOMPILER ERROR at PC121: Overwrote pending register: R4 in 'AssignReg'

  self._chargingPanel_level = self:GetChild(R4_PC92)
  -- DECOMPILER ERROR at PC125: Overwrote pending register: R4 in 'AssignReg'

  self._chargingPanel_markPanel = self:GetChild(R4_PC92)
  -- DECOMPILER ERROR at PC129: Overwrote pending register: R4 in 'AssignReg'

  self._chargingPanel_markIBtn = self:GetChild(R4_PC92)
  -- DECOMPILER ERROR at PC133: Overwrote pending register: R4 in 'AssignReg'

  self._chargingPanel_type = self:GetChild(R4_PC92)
  -- DECOMPILER ERROR at PC137: Overwrote pending register: R4 in 'AssignReg'

  self._chargingPanel_range = self:GetChild(R4_PC92)
  -- DECOMPILER ERROR at PC141: Overwrote pending register: R4 in 'AssignReg'

  self._chargingPanel_detail = self:GetChild(R4_PC92)
  -- DECOMPILER ERROR at PC148: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._skillDetails)[(Skill.Type).Charging], R4_PC92 = R4_PC92, {}
  local map = (self._skillDetails)[(Skill.Type).Charging]
  map.panel = self._chargingPanel_detail
  map.initLocal_posX = (map.panel):GetLocalPosition()
  -- DECOMPILER ERROR at PC162: Overwrote pending register: R4 in 'AssignReg'

  map.width = (map.panel):GetRectSize()
  -- DECOMPILER ERROR at PC168: Overwrote pending register: R4 in 'AssignReg'

  map.skillCell = (DialogManager.CreateDialog)(R4_PC92, (self:GetChild("Back/EnergySkill/Skill"))._uiObject)
  -- DECOMPILER ERROR at PC176: Overwrote pending register: R4 in 'AssignReg'

  ;
  (map.skillCell):HideFromCharacterSkillDialog()
  -- DECOMPILER ERROR at PC179: Overwrote pending register: R4 in 'AssignReg'

  self._chargingPanel_markFrame = (TableFrame.Create)(R4_PC92, self, false, false)
  -- DECOMPILER ERROR at PC186: Overwrote pending register: R4 in 'AssignReg'

  ;
  (self._chargingPanel_markIBtn):Subscribe_PointerClickEvent(self.OnChargingIBtnClicked, self)
  -- DECOMPILER ERROR at PC190: Overwrote pending register: R4 in 'AssignReg'

  self._passivePanel = self:GetChild("Back/PassiveSkill")
  -- DECOMPILER ERROR at PC194: Overwrote pending register: R4 in 'AssignReg'

  self._passivePanel_skillName = self:GetChild("Back/PassiveSkill/SkillName")
  -- DECOMPILER ERROR at PC198: Overwrote pending register: R4 in 'AssignReg'

  self._passivePanel_level = self:GetChild("Back/PassiveSkill/Level/Txt3")
  -- DECOMPILER ERROR at PC202: Overwrote pending register: R4 in 'AssignReg'

  self._passivePanel_type = self:GetChild("Back/PassiveSkill/Type/Num")
  -- DECOMPILER ERROR at PC206: Overwrote pending register: R4 in 'AssignReg'

  self._passivePanel_detail = self:GetChild("Back/PassiveSkill/Frame/Detail")
  -- DECOMPILER ERROR at PC211: Overwrote pending register: R4 in 'AssignReg'

  -- DECOMPILER ERROR at PC212: Overwrote pending register: R4 in 'AssignReg'

  -- DECOMPILER ERROR at PC214: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._skillDetails)[R4_PC92] = {}
  -- DECOMPILER ERROR at PC216: Overwrote pending register: R4 in 'AssignReg'

  -- DECOMPILER ERROR at PC217: Overwrote pending register: R4 in 'AssignReg'

  local map = (self._skillDetails)[R4_PC92]
  -- DECOMPILER ERROR at PC219: Overwrote pending register: R4 in 'AssignReg'

  map.panel = R4_PC92
  -- DECOMPILER ERROR at PC221: Overwrote pending register: R4 in 'AssignReg'

  -- DECOMPILER ERROR at PC222: Overwrote pending register: R4 in 'AssignReg'

  R4_PC92 = R4_PC92(R4_PC92)
  map.initLocal_posZ = self
  map.initLocal_posY = R4_PC92
  map.initLocal_posX = R4_PC92
  R4_PC92 = map.panel
  R4_PC92 = R4_PC92(R4_PC92)
  map.height = R4_PC92
  map.width = R4_PC92
  R4_PC92 = DialogManager
  R4_PC92 = R4_PC92.CreateDialog
  R4_PC92 = R4_PC92("skill.skillcell", (self:GetChild("Back/PassiveSkill/Skill"))._uiObject)
  map.skillCell = R4_PC92
  R4_PC92 = map.skillCell
  R4_PC92(R4_PC92)
  -- DECOMPILER ERROR at PC244: Overwrote pending register: R4 in 'AssignReg'

  R4_PC92 = R4_PC92(self, "Back/PropSkill")
  self._attrPanel = R4_PC92
  R4_PC92 = R4_PC92(self, "Back/PropSkill/SkillName")
  self._attrPanel_skillName = R4_PC92
  R4_PC92 = R4_PC92(self, "Back/PropSkill/Type/Num")
  self._attrPanel_type = R4_PC92
  R4_PC92 = R4_PC92(self, "Back/PropSkill/Frame/Detail")
  self._attrPanel_detail = R4_PC92
  R4_PC92 = self._skillDetails
  R4_PC92[(Skill.Type).Attribute] = {}
  R4_PC92 = self._skillDetails
  R4_PC92 = R4_PC92[(Skill.Type).Attribute]
  local map = nil
  map.panel = self._attrPanel_detail
  map.initLocal_posX = (map.panel):GetLocalPosition()
  map.width = (map.panel):GetRectSize()
  map.skillCell = (DialogManager.CreateDialog)("skill.skillcell", (self:GetChild("Back/PropSkill/Skill"))._uiObject)
  ;
  (map.skillCell):HideFromCharacterSkillDialog()
  self._lockPanel = self:GetChild("Back/Down")
  self._lockPanel_lvNotEnough = self:GetChild("Back/Down/Lock1")
  self._lockPanel_lvNotEnough_needLv = self:GetChild("Back/Down/Lock1/Level/Num")
  self._lockPanel_lvNotEnough_needBreakLvBack = self:GetChild("Back/Down/Lock1/BreakLevelBack")
  self._lockPanel_lvNotEnough_needBreakLv = self:GetChild("Back/Down/Lock1/BreakLevelNum")
  self._lockPanel_frontNodeLock = self:GetChild("Back/Down/Lock2")
  ;
  (self:GetChild("Back/Down/Lock2/Txt")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1482))
  self._lockPanel_costMana = self:GetChild("Back/Down/Need")
  self._lockPanel_costManaNum = self:GetChild("Back/Down/Need/Txt2")
  self._lockPanel_costManaNumRed = self:GetChild("Back/Down/Need/Txt2Red")
  self._lockPanel_costItemPanel = self:GetChild("Back/Down/Need/ItemFrame")
  self._lockPanel_btn = self:GetChild("Back/Down/Btn")
  self._lockPanel_btnTxt = self:GetChild("Back/Down/Btn/_Text")
  self._lockPanel_costItemFrame = (TableFrame.Create)(self._lockPanel_costItemPanel, self, false, false)
  ;
  (self._lockPanel_btn):Subscribe_PointerClickEvent(self.OnUnlockBtnClicked, self)
  self._unlockPanel = self:GetChild("Back/UnLock")
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  ;
  (self._manaBtn):Subscribe_PointerClickEvent(self.OnManaBtnClick, self)
  ;
  (self._diamondBtn):Subscribe_PointerClickEvent(self.OnDiamondBtnClick, self)
  ;
  (self._diamondAddBtn):Subscribe_PointerClickEvent(self.OnDiamondAddBtnClick, self)
  self:OnAPChange()
  local cellDialog = (DialogManager.CreateDialog)("character.characterskillrowcell", nil)
  self._rowCellWidth = (cellDialog._rootWindow):GetRectSize()
  cellDialog:RootWindowDestroy()
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnAPChange, Common.n_RefreshCurrency, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSkillUnlock, Common.n_ImproveSkill, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnScreenPixelChanged, Common.n_ScreenPixelChanged, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnUpdate, Common.n_Update, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, FinishGuide, Common.n_GuideResponseClick, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRedPointNumChanged, Common.n_RedPointNumChanged, nil)
  local dialog = (DialogManager.GetDialog)("battle.battleaccount.battlelosetextdialog")
  if dialog then
    (self._menuBtn):SetActive(false)
    ;
    (self._diamondAddBtn):SetActive(false)
  end
  if GlobalGameFSM and GlobalGameFSM:GetCurrentState() == "MainCityBattle" and MainCityState.uIBackManagerIsActive then
    (UIBackManager.SetActive)(true)
  else
    ;
    (UIBackManager.SetUIBackShow)(true)
    ;
    (UIBackManager.SetUIModalBackColor)(2)
  end
end

CharacterSkillDialog.OnDestroy = function(self)
  -- function num : 0_3 , upvalues : _ENV, MainCityState
  if GlobalGameFSM and GlobalGameFSM:GetCurrentState() == "MainCityBattle" and MainCityState.uIBackManagerIsActive then
    (UIBackManager.SetActive)(false)
  else
    ;
    (UIBackManager.SetUIBackShow)(false)
  end
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (self._chargingPanel_markFrame):Destroy()
  ;
  (self._lockPanel_costItemFrame):Destroy()
  do
    while (self._rowCellList)[#self._rowCellList] do
      local dialog = (self._rowCellList)[#self._rowCellList]
      dialog:Destroy()
      dialog:RootWindowDestroy()
      ;
      (table.remove)(self._rowCellList, #self._rowCellList)
    end
    while (self._skillNodeLineCells)[#self._skillNodeLineCells] do
      local dialog = (self._skillNodeLineCells)[#self._skillNodeLineCells]
      dialog:Destroy()
      dialog:RootWindowDestroy()
      ;
      (table.remove)(self._skillNodeLineCells, #self._skillNodeLineCells)
    end
  end
end

CharacterSkillDialog.OnSkillUnlock = function(self, notification)
  -- function num : 0_4 , upvalues : _ENV
  if (notification.userInfo).roleId == (self._role):GetId() then
    self._sendProtocol = false
    self._role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole((self._role):GetId())
    self._unlockSkillNodes = (self._role):GetUnlockSkillNodes()
    self:RefreshSkillNode()
    self:RefreshDetailPanel()
  end
end

local BuildRowNodeData = function(self)
  -- function num : 0_5 , upvalues : _ENV, SingletonSlideFrame
  local rowNum = nil
  local map = {}
  for k,v in pairs(self._allSkillNodes) do
    local posList = (string.split)(v.position, ";")
    local row = tonumber(posList[1])
    if not rowNum or rowNum < row then
      rowNum = row
    end
    local frontList = nil
    if v.frontNode ~= "-1" then
      frontList = (string.split)(v.frontNode, ";")
    end
    local frontNodeList = {}
    if frontList then
      for _,nodeId in ipairs(frontList) do
        (table.insert)(frontNodeList, tonumber(nodeId))
      end
    end
    do
      do
        local column = tonumber(posList[2])
        -- DECOMPILER ERROR at PC56: Confused about usage of register: R13 in 'UnsetPending'

        ;
        (self._skillNodePosData)[v.id] = {
pos = {row = row, column = column}
, frontNodeList = frontNodeList}
        if not map[row] then
          map[row] = {}
        end
        -- DECOMPILER ERROR at PC63: Confused about usage of register: R13 in 'UnsetPending'

        ;
        (map[row])[column] = true
        -- DECOMPILER ERROR at PC64: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  local skillRowCell = (DialogManager.CreateDialog)("character.characterskillrowcell", (self._treePanel_nodeArea)._uiObject)
  for i = 1, rowNum do
    local dialog = (DialogManager.CopyDialog)("character.characterskillrowcell", (skillRowCell._rootWindow)._uiObject, (self._treePanel_nodeArea)._uiObject)
    ;
    (dialog:GetRootWindow()):SetAnchoredPosition(0, -((i - 1) * self._rowCellHeight))
    dialog:Init(self, i, map[i])
    ;
    (table.insert)(self._rowCellList, dialog)
  end
  skillRowCell:RootWindowDestroy()
  local width, height = (self._treePanel):GetDeltaSize()
  ;
  (self._treePanel):SetDeltaSize(width, self._rowCellHeight * rowNum)
  local local_maxPosY = self._initLocal_posY + self._rowCellHeight * rowNum - height
  self._singletonSlideFrame = (SingletonSlideFrame.Create)(self._treePanel, true, self._initLocal_posY, local_maxPosY)
  local x, y, z = (self._treePanel):GetLocalPosition()
  local posY = y + ((((self._skillNodePosData)[self._selectNodeId]).pos).row - 3) * self._rowCellHeight
  if posY < self._initLocal_posY then
    posY = self._initLocal_posY
  else
    if local_maxPosY < posY then
      posY = local_maxPosY
    end
  end
  ;
  (self._treePanel):SetLocalPosition(x, posY, self._local_posZ)
end

local BuildSkillNodeLines = function(self)
  -- function num : 0_6 , upvalues : _ENV, UIManager, TransformStaticFunctions
  local skillLineCell = (DialogManager.CreateDialog)("character.characterskilllinecell", (self._treePanel_lineArea)._uiObject)
  for k,v in pairs(self._allSkillNodes) do
    local data = (self._skillNodePosData)[k]
    if #data.frontNodeList > 0 then
      for _,frontNodeId in ipairs(data.frontNodeList) do
        local startLocation = ((self._skillNodePosData)[frontNodeId]).pos
        local startChild = ((((self._rowCellList)[startLocation.row])._posChilds)[startLocation.column]).panel
        local endLocation = ((self._skillNodePosData)[k]).pos
        local endChild = ((((self._rowCellList)[endLocation.row])._posChilds)[endLocation.column]).panel
        local startPos = (UIManager.InverseTransformPoint)((self._treePanel_lineArea)._uiObject, ((CS.UnityEngine).Vector3)((TransformStaticFunctions.GetPosition)(startChild._uiObject)))
        local endPos = (UIManager.InverseTransformPoint)((self._treePanel_lineArea)._uiObject, ((CS.UnityEngine).Vector3)((TransformStaticFunctions.GetPosition)(endChild._uiObject)))
        local deltaX = endPos.x - startPos.x
        local deltaY = endPos.y - startPos.y
        local len = deltaX ^ 2 + deltaY ^ 2 ^ 0.5
        local dialog = (DialogManager.CopyDialog)("character.characterskilllinecell", (skillLineCell._rootWindow)._uiObject, (self._treePanel_lineArea)._uiObject)
        ;
        (dialog._rootWindow):SetWidth(0, len)
        ;
        (dialog._rootWindow):SetZRotation(1, 0, deltaX, deltaY)
        ;
        (TransformStaticFunctions.SetLocalPosition)((dialog._rootWindow)._uiObject, (startPos.x + endPos.x) / 2, (startPos.y + endPos.y) / 2, startPos.z)
        ;
        (table.insert)(self._skillNodeLineCells, dialog)
      end
    end
  end
  skillLineCell:RootWindowDestroy()
end

CharacterSkillDialog.SetData = function(self, roleId)
  -- function num : 0_7 , upvalues : _ENV, BuildRowNodeData, BuildSkillNodeLines
  self._role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(roleId)
  self._selectNodeId = (self._role):GetFirstSelectNodeId()
  self._allSkillNodes = (self._role):GetAllSkillNodes()
  self._unlockSkillNodes = (self._role):GetUnlockSkillNodes()
  BuildRowNodeData(self)
  BuildSkillNodeLines(self)
  self:RefreshSkillNode()
  self:RefreshDetailPanel()
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_TriggerGuide, self, nil)
end

CharacterSkillDialog.RefreshSkillNode = function(self)
  -- function num : 0_8 , upvalues : _ENV
  for k,v in pairs(self._allSkillNodes) do
    local data = (self._skillNodePosData)[k]
    ;
    ((self._rowCellList)[(data.pos).row]):Refresh(v)
  end
  for i,v in ipairs(self._rowCellList) do
    v:AllSkillNodesRefreshFinished()
  end
end

CharacterSkillDialog.OnScreenPixelChanged = function(self)
  -- function num : 0_9
  self._screenPixelChanged = true
end

CharacterSkillDialog.OnUpdate = function(self)
  -- function num : 0_10 , upvalues : _ENV, Skill, SingletonSlideFrame
  if self._screenPixelChanged then
    self._screenPixelChanged = false
    local nodeRecord = (self._allSkillNodes)[self._selectNodeId]
    local skillId = nodeRecord.skillID
    local skill = nil
    if ((NekoData.BehaviorManager).BM_Game):IsSkillItemId(skillId) then
      skill = (Skill.Create)(skillId)
      skill:SetLevel(nodeRecord.skillLevel)
    else
      skill = (Skill.Create)(skillId, true)
    end
    local type = skill:GetType()
    local map = (self._skillDetails)[type]
    if map then
      if map.slideFrame then
        (map.slideFrame):Destroy()
        map.slideFrame = nil
      end
      local _, textHeight = (map.panel):GetPreferredSize()
      if map.height < textHeight then
        local delta = textHeight - map.height
        ;
        (map.panel):SetDeltaSize(map.width, textHeight)
        ;
        (map.panel):SetLocalPosition(map.initLocal_posX, map.initLocal_posY, map.initLocal_posZ)
        map.slideFrame = (SingletonSlideFrame.Create)(map.panel, true, map.initLocal_posY, map.initLocal_posY + delta)
      else
        do
          ;
          (map.panel):SetDeltaSize(map.width, map.height)
          ;
          (map.panel):SetLocalPosition(map.initLocal_posX, map.initLocal_posY, map.initLocal_posZ)
        end
      end
    end
  end
end

CharacterSkillDialog.RefreshDetailPanel = function(self)
  -- function num : 0_11 , upvalues : _ENV, Skill, SingletonSlideFrame
  local nodeRecord = (self._allSkillNodes)[self._selectNodeId]
  local skillId = nodeRecord.skillID
  local skill = nil
  if ((NekoData.BehaviorManager).BM_Game):IsSkillItemId(skillId) then
    skill = (Skill.Create)(skillId)
    skill:SetLevel(nodeRecord.skillLevel)
  else
    skill = (Skill.Create)(skillId, true)
  end
  local type = skill:GetType()
  local level = skill:GetSkillLevel()
  local name = skill:GetSkillName()
  local typeTxt = skill:GetTypeTxt()
  local detail = skill:GetDescribeTxt()
  if type == (Skill.Type).Active then
    (self._activePanel):SetActive(true)
    ;
    (self._chargingPanel):SetActive(false)
    ;
    (self._passivePanel):SetActive(false)
    ;
    (self._attrPanel):SetActive(false)
    ;
    (self._activePanel_skillName):SetText(name)
    ;
    (self._activePanel_level):SetText(level)
    ;
    (self._activePanel_yellowCost):SetText(skill:GetYellowCost())
    ;
    (self._activePanel_purpleCost):SetText(skill:GetPurpleCost())
    ;
    (self._activePanel_type):SetText(typeTxt)
    ;
    (self._activePanel_range):SetText(skill:GetRangeTxt())
    ;
    (self._activePanel_detail):SetText(detail)
    local maxlevel = skill:GetSkillMaxLevel()
  else
    do
      if maxlevel <= level then
        if type == (Skill.Type).Charging then
          (self._activePanel):SetActive(false)
          ;
          (self._chargingPanel):SetActive(true)
          ;
          (self._passivePanel):SetActive(false)
          ;
          (self._attrPanel):SetActive(false)
          ;
          (self._chargingPanel_skillName):SetText(name)
          ;
          (self._chargingPanel_level):SetText(level)
          ;
          (self._chargingPanel_type):SetText(typeTxt)
          ;
          (self._chargingPanel_range):SetText(skill:GetRangeTxt())
          ;
          (self._chargingPanel_detail):SetText(detail)
          self.chargingMarkNum = skill:GetChargingNumByRoleId((self._role):GetId())
          ;
          (self._chargingPanel_markFrame):ReloadAllCell()
          local maxlevel = skill:GetSkillMaxLevel()
        else
          do
            if maxlevel <= level then
              if type == (Skill.Type).Passive then
                (self._activePanel):SetActive(false)
                ;
                (self._chargingPanel):SetActive(false)
                ;
                (self._passivePanel):SetActive(true)
                ;
                (self._attrPanel):SetActive(false)
                ;
                (self._passivePanel_skillName):SetText(name)
                ;
                (self._passivePanel_level):SetText(level)
                ;
                (self._passivePanel_type):SetText(typeTxt)
                ;
                (self._passivePanel_detail):SetText(detail)
                local maxlevel = skill:GetSkillMaxLevel()
              else
                do
                  if maxlevel <= level and type == (Skill.Type).Attribute then
                    (self._activePanel):SetActive(false)
                    ;
                    (self._chargingPanel):SetActive(false)
                    ;
                    (self._passivePanel):SetActive(false)
                    ;
                    (self._attrPanel):SetActive(true)
                    ;
                    (self._attrPanel_skillName):SetText(name)
                    ;
                    (self._attrPanel_type):SetText(typeTxt)
                    ;
                    (self._attrPanel_detail):SetText(detail)
                  end
                  local map = (self._skillDetails)[type]
                  if map then
                    if map.slideFrame then
                      (map.slideFrame):Destroy()
                      map.slideFrame = nil
                    end
                    local _, textHeight = (map.panel):GetPreferredSize()
                    if map.height < textHeight then
                      local delta = textHeight - map.height
                      ;
                      (map.panel):SetDeltaSize(map.width, textHeight)
                      ;
                      (map.panel):SetLocalPosition(map.initLocal_posX, map.initLocal_posY, map.initLocal_posZ)
                      map.slideFrame = (SingletonSlideFrame.Create)(map.panel, true, map.initLocal_posY, map.initLocal_posY + delta)
                    else
                      do
                        do
                          ;
                          (map.panel):SetDeltaSize(map.width, map.height)
                          ;
                          (map.panel):SetLocalPosition(map.initLocal_posX, map.initLocal_posY, map.initLocal_posZ)
                          ;
                          (map.skillCell):Init(skill)
                          self:RefreshCostPanel()
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

CharacterSkillDialog.RefreshCostPanel = function(self)
  -- function num : 0_12 , upvalues : _ENV
  local nodeRecord = (self._allSkillNodes)[self._selectNodeId]
  local unlock = (self._unlockSkillNodes)[nodeRecord.id]
  if unlock then
    (self._lockPanel):SetActive(false)
    ;
    (self._unlockPanel):SetActive(true)
  else
    ;
    (self._lockPanel):SetActive(true)
    ;
    (self._unlockPanel):SetActive(false)
    local isSpecialUnlock = nodeRecord.serverUnlock ~= 0
    if not isSpecialUnlock then
      (self._lockPanel_costMana):SetActive(true)
      local roleLvEnough = nodeRecord.roleSkill <= (self._role):GetLevel()
      if not roleLvEnough then
        (self._lockPanel_lvNotEnough):SetActive(true)
        ;
        (self._lockPanel_frontNodeLock):SetActive(false)
        ;
        (self._lockPanel_costMana):SetActive(false)
        ;
        (self._lockPanel_btn):SetActive(false)
        local breakRecorder = nil
        local breakRecordList = (self._role):GetBreakRecordList()
        for i,recorder in ipairs(breakRecordList) do
          if nodeRecord.roleSkill <= recorder.levelmax then
            breakRecorder = recorder
            break
          end
        end
        ;
        (self._lockPanel_lvNotEnough_needBreakLvBack):SetActive(breakRecorder.breaklv > 0)
        ;
        (self._lockPanel_lvNotEnough_needBreakLv):SetActive(breakRecorder.breaklv > 0)
        if breakRecorder.breaklv > 0 then
          (self._lockPanel_lvNotEnough_needBreakLv):SetText(breakRecorder.breaklv)
        end
        ;
        (self._lockPanel_lvNotEnough_needLv):SetText(nodeRecord.roleSkill - breakRecorder.levelmin)
        return 
      end
      local frontNodesUnlock = true
      local frontNodeList = ((self._skillNodePosData)[self._selectNodeId]).frontNodeList
      for _,v in ipairs(frontNodeList) do
        if not (self._unlockSkillNodes)[v] then
          frontNodesUnlock = false
          break
        end
      end
      if not frontNodesUnlock then
        (self._lockPanel_lvNotEnough):SetActive(false)
        ;
        (self._lockPanel_frontNodeLock):SetActive(true)
        ;
        (self._lockPanel_costMana):SetActive(false)
        ;
        (self._lockPanel_btn):SetActive(false)
        return 
      end
      local costEnough = true
      ;
      (self._lockPanel_lvNotEnough):SetActive(false)
      ;
      (self._lockPanel_frontNodeLock):SetActive(false)
      ;
      (self._lockPanel_costMana):SetActive(true)
      ;
      (self._lockPanel_btn):SetActive(true)
      ;
      (self._lockPanel_btnTxt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1483))
      local mana = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.ManaID)
      if mana < nodeRecord.money then
        (self._lockPanel_costManaNum):SetActive(false)
        ;
        (self._lockPanel_costManaNumRed):SetActive(true)
        ;
        (self._lockPanel_costManaNumRed):SetText(nodeRecord.money)
        costEnough = false
      else
        (self._lockPanel_costManaNum):SetActive(true)
        ;
        (self._lockPanel_costManaNumRed):SetActive(false)
        ;
        (self._lockPanel_costManaNum):SetText(nodeRecord.money)
      end
      while (self._costItemList)[#self._costItemList] do
        (table.remove)(self._costItemList, #self._costItemList)
      end
      for i,v in ipairs(nodeRecord.itemID) do
        local num = (nodeRecord.itemNum)[i]
        ;
        (table.insert)(self._costItemList, {itemId = v, itemNum = num})
        if costEnough then
          local haveNum = ((NekoData.BehaviorManager).BM_BagInfo):GetItemCountById(v)
          costEnough = num <= haveNum
        end
      end
      ;
      (self._lockPanel_costItemFrame):ReloadAllCell()
      if not costEnough then
        (self._lockPanel_btn):SetInteractable(false)
      else
        (self._lockPanel_btn):SetInteractable(true)
      end
    else
      (self._lockPanel_lvNotEnough):SetActive(false)
      ;
      (self._lockPanel_frontNodeLock):SetActive(false)
      ;
      (self._lockPanel_costMana):SetActive(false)
      ;
      (self._lockPanel_btn):SetActive(true)
      ;
      (self._lockPanel_btn):SetInteractable(false)
      ;
      (self._lockPanel_btnTxt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(nodeRecord.serverUnlockText))
    end
  end
  -- DECOMPILER ERROR: 19 unprocessed JMP targets
end

CharacterSkillDialog.SelectSkillNode = function(self, skillNodeId)
  -- function num : 0_13 , upvalues : _ENV
  if self._selectNodeId ~= skillNodeId then
    self._selectNodeId = skillNodeId
    for i,v in ipairs(self._rowCellList) do
      v:OnEvent("SetSelected")
    end
    self:RefreshDetailPanel()
  end
end

CharacterSkillDialog.OnRedPointNumChanged = function(self, notification)
  -- function num : 0_14 , upvalues : _ENV
  if (notification.userInfo).redPointID == 4 then
    for i,v in ipairs(self._rowCellList) do
      v:OnEvent("RefreshRedDot")
    end
  end
end

CharacterSkillDialog.NumberOfCell = function(self, frame, index)
  -- function num : 0_15
  if frame == self._chargingPanel_markFrame then
    return self.chargingMarkNum
  else
    if frame == self._lockPanel_costItemFrame then
      return #self._costItemList
    end
  end
end

CharacterSkillDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_16
  if frame == self._chargingPanel_markFrame then
    return "character.chargingmarkcell"
  else
    if frame == self._lockPanel_costItemFrame then
      return "skill.skillitemcell"
    end
  end
end

CharacterSkillDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_17
  if frame == self._chargingPanel_markFrame then
    return true
  else
    if frame == self._lockPanel_costItemFrame then
      return (self._costItemList)[index]
    end
  end
end

CharacterSkillDialog.OnUnlockBtnClicked = function(self)
  -- function num : 0_18 , upvalues : _ENV
  if not self._sendProtocol then
    local csend = (LuaNetManager.CreateProtocol)("protocol.skill.cimproveskill")
    csend.roleId = (self._role):GetRoleId()
    csend.unlockNode = self._selectNodeId
    csend:Send()
    self._sendProtocol = true
  end
end

CharacterSkillDialog.OnAPChange = function(self)
  -- function num : 0_19 , upvalues : _ENV
  (self._manaTxt):SetNumber(((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.ManaID))
  ;
  (self._diamondTxt):SetNumber(((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.DiamodID))
end

CharacterSkillDialog.OnManaBtnClick = function(self)
  -- function num : 0_20 , upvalues : _ENV, Item
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = (Item.Create)(DataCommon.ManaID)})
    local width, height = (self._manaBtn):GetRectSize()
    tipsDialog:SetTipsPosition(width, height, (self._manaBtn):GetLocalPointInUiRootPanel())
  end
end

CharacterSkillDialog.OnDiamondBtnClick = function(self)
  -- function num : 0_21 , upvalues : _ENV, Item
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = (Item.Create)(DataCommon.DiamodID)})
    local width, height = (self._diamondBtn):GetRectSize()
    tipsDialog:SetTipsPosition(width, height, (self._diamondBtn):GetLocalPointInUiRootPanel())
  end
end

CharacterSkillDialog.OnDiamondAddBtnClick = function(self)
  -- function num : 0_22 , upvalues : _ENV
  if not ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).Shop) then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100192)
  else
    local baseSceneController = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).Base)
    if baseSceneController then
      ((DialogManager.GetGroup)("Modal")):ReturnModalDialog()
      ;
      ((NekoData.DataManager).DM_Shop):ClientSetOpenShopID(4)
      baseSceneController:SetCameraAnimatorState(0)
      local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.copenshop")
      if protocol then
        protocol:Send()
      end
    end
  end
end

CharacterSkillDialog.OnChargingIBtnClicked = function(self)
  -- function num : 0_23 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("skill.chargingskillusageruledialog")
end

CharacterSkillDialog.OnBackBtnClicked = function(self)
  -- function num : 0_24
  self:Destroy()
end

CharacterSkillDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_25 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

return CharacterSkillDialog

