-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/skill/skilltipsdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local TableFrame = require("framework.ui.frame.table.tableframe")
local Skill = require("logic.manager.experimental.types.skill")
local SkillTipsDialog = class("SkillTipsDialog", Dialog)
SkillTipsDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
SkillTipsDialog.AssetName = "SkillTips"
SkillTipsDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SkillTipsDialog
  ((SkillTipsDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
  self._skillDetails = {}
end

SkillTipsDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : Skill, TableFrame
  self._back = self:GetChild("Back")
  self._backDeltaWidth = (self._back):GetDeltaSize()
  self._activePanel = self:GetChild("Back/ActiveSkill")
  self._activePanel_skillName = self:GetChild("Back/ActiveSkill/Name")
  self._activePanel_level = self:GetChild("Back/ActiveSkill/Level/Num")
  self._activePanel_yellowCost = self:GetChild("Back/ActiveSkill/Cost/Num1")
  self._activePanel_purpleCost = self:GetChild("Back/ActiveSkill/Cost/Num2")
  self._activePanel_type = self:GetChild("Back/ActiveSkill/Type/Num")
  self._activePanel_range = self:GetChild("Back/ActiveSkill/Range/Num")
  self._activePanel_detail = self:GetChild("Back/ActiveSkill/Detail")
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._skillDetails)[(Skill.Type).Active] = {}
  local map = (self._skillDetails)[(Skill.Type).Active]
  map.panel = self._activePanel
  map.panelAnchoredx = (map.panel):GetAnchoredPosition()
  map.txt = self._activePanel_detail
  map.txt_width = (map.txt):GetRectSize()
  map.anchorMinX = (map.txt):GetAnchorAndOffset()
  self._chargingPanel = self:GetChild(R4_PC72)
  -- DECOMPILER ERROR at PC80: Overwrote pending register: R4 in 'AssignReg'

  self._chargingPanel_skillName = self:GetChild(R4_PC72)
  -- DECOMPILER ERROR at PC84: Overwrote pending register: R4 in 'AssignReg'

  self._chargingPanel_level = self:GetChild(R4_PC72)
  -- DECOMPILER ERROR at PC88: Overwrote pending register: R4 in 'AssignReg'

  self._chargingPanel_markPanel = self:GetChild(R4_PC72)
  -- DECOMPILER ERROR at PC92: Overwrote pending register: R4 in 'AssignReg'

  self._chargingPanel_markIBtn = self:GetChild(R4_PC72)
  -- DECOMPILER ERROR at PC96: Overwrote pending register: R4 in 'AssignReg'

  self._chargingPanel_type = self:GetChild(R4_PC72)
  -- DECOMPILER ERROR at PC100: Overwrote pending register: R4 in 'AssignReg'

  self._chargingPanel_range = self:GetChild(R4_PC72)
  -- DECOMPILER ERROR at PC104: Overwrote pending register: R4 in 'AssignReg'

  self._chargingPanel_detail = self:GetChild(R4_PC72)
  -- DECOMPILER ERROR at PC111: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._skillDetails)[(Skill.Type).Charging], R4_PC72 = R4_PC72, {}
  map = (self._skillDetails)[(Skill.Type).Charging]
  map.panel = self._chargingPanel
  map.panelAnchoredx = (map.panel):GetAnchoredPosition()
  map.txt = self._chargingPanel_detail
  map.txt_width = (map.txt):GetRectSize()
  map.anchorMinX = (map.txt):GetAnchorAndOffset()
  self._chargingPanel_markFrame = (TableFrame.Create)(self._chargingPanel_markPanel, R4_PC72, R5_PC71, R6_PC70)
  -- DECOMPILER ERROR at PC150: Overwrote pending register: R4 in 'AssignReg'

  -- DECOMPILER ERROR at PC151: Overwrote pending register: R5 in 'AssignReg'

  ;
  (self._chargingPanel_markIBtn):Subscribe_PointerClickEvent(R4_PC72, R5_PC71)
  -- DECOMPILER ERROR at PC154: Overwrote pending register: R4 in 'AssignReg'

  self._passivePanel = self:GetChild(R4_PC72)
  -- DECOMPILER ERROR at PC158: Overwrote pending register: R4 in 'AssignReg'

  self._passivePanel_skillName = self:GetChild(R4_PC72)
  -- DECOMPILER ERROR at PC162: Overwrote pending register: R4 in 'AssignReg'

  self._passivePanel_level = self:GetChild(R4_PC72)
  -- DECOMPILER ERROR at PC166: Overwrote pending register: R4 in 'AssignReg'

  self._passivePanel_type = self:GetChild(R4_PC72)
  -- DECOMPILER ERROR at PC170: Overwrote pending register: R4 in 'AssignReg'

  self._passivePanel_detail = self:GetChild(R4_PC72)
  -- DECOMPILER ERROR at PC177: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._skillDetails)[(Skill.Type).Passive], R4_PC72 = R4_PC72, {}
  map = (self._skillDetails)[(Skill.Type).Passive]
  map.panel = self._passivePanel
  map.panelAnchoredx = (map.panel):GetAnchoredPosition()
  map.txt = self._passivePanel_detail
  map.txt_width = (map.txt):GetRectSize()
  map.anchorMinX = (map.txt):GetAnchorAndOffset()
  self._attrPanel = self:GetChild(R4_PC72)
  -- DECOMPILER ERROR at PC212: Overwrote pending register: R4 in 'AssignReg'

  self._attrPanel_skillName = self:GetChild(R4_PC72)
  -- DECOMPILER ERROR at PC216: Overwrote pending register: R4 in 'AssignReg'

  self._attrPanel_type = self:GetChild(R4_PC72)
  -- DECOMPILER ERROR at PC220: Overwrote pending register: R4 in 'AssignReg'

  self._attrPanel_detail = self:GetChild(R4_PC72)
  -- DECOMPILER ERROR at PC227: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._skillDetails)[(Skill.Type).Attribute], R4_PC72 = R4_PC72, {}
  map = (self._skillDetails)[(Skill.Type).Attribute]
  map.panel = self._attrPanel
  map.panelAnchoredx = (map.panel):GetAnchoredPosition()
  map.txt = self._attrPanel_detail
  map.txt_width = (map.txt):GetRectSize()
  map.anchorMinX = (map.txt):GetAnchorAndOffset()
  -- DECOMPILER ERROR at PC260: Overwrote pending register: R5 in 'AssignReg'

  ;
  (self._rootWindow):Subscribe_PointerClickEvent(R4_PC72, R5_PC71)
end

SkillTipsDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._chargingPanel_markFrame):Destroy()
end

SkillTipsDialog.SetSkillAndRoleId = function(self, skillId, skillItemId, roleId)
  -- function num : 0_3 , upvalues : Skill
  local skill = (Skill.Create)(skillId, skillItemId or true)
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
  else
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
      self.chargingMarkNum = skill:GetChargingNumByRoleId(roleId)
      ;
      (self._chargingPanel_markFrame):ReloadAllCell()
    else
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
      else
        if type == (Skill.Type).Attribute then
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
        end
      end
    end
  end
  local map = (self._skillDetails)[type]
  if map then
    (map.txt):SetText(detail)
    local _, textHeight = (map.txt):GetPreferredSize()
    if map.txt_height < textHeight then
      local delta = textHeight - map.txt_height
      ;
      (map.txt):SetAnchorAndOffset(map.anchorMinX, map.anchorMinY, map.anchorMaxX, map.anchorMaxY, map.offsetMinX, map.offsetMinY - delta, map.offsetMaxX, map.offsetMaxY)
      ;
      (self._back):SetDeltaSize(self._backDeltaWidth, self._backDeltaHeight + delta)
      ;
      (map.panel):SetAnchoredPosition(map.panelAnchoredx, map.panelAnchoredy + delta / 2)
    end
  end
end

SkillTipsDialog.NumberOfCell = function(self, frame, index)
  -- function num : 0_4
  if frame == self._chargingPanel_markFrame then
    return self.chargingMarkNum
  end
end

SkillTipsDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  if frame == self._chargingPanel_markFrame then
    return "character.chargingmarkcell"
  end
end

SkillTipsDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  if frame == self._chargingPanel_markFrame then
    return true
  end
end

SkillTipsDialog.OnChargingIBtnClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("skill.chargingskillusageruledialog")
end

SkillTipsDialog.OnRootWindowClicked = function(self, args)
  -- function num : 0_8 , upvalues : UIManager
  if not (UIManager.RectangleContainsScreenPoint)((self._back)._uiObject, (args.position).x, (args.position).y) then
    self:OnBackBtnClicked()
  end
end

SkillTipsDialog.OnBackBtnClicked = function(self)
  -- function num : 0_9
  self:Destroy()
end

return SkillTipsDialog

