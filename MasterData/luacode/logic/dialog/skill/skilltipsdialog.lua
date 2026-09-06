local UIManager = CS.PixelNeko.UI.UIManager
local TableFrame = require("framework.ui.frame.table.tableframe")
local Skill = require("logic.manager.experimental.types.skill")
local SkillTipsDialog = class("SkillTipsDialog", Dialog)
SkillTipsDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
SkillTipsDialog.AssetName = "SkillTips"

function SkillTipsDialog:Ctor(...)
  SkillTipsDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
  self._skillDetails = {}
end

function SkillTipsDialog:OnCreate()
  self._back = self:GetChild("Back")
  self._backDeltaWidth, self._backDeltaHeight = self._back:GetDeltaSize()
  self._activePanel = self:GetChild("Back/ActiveSkill")
  self._activePanel_skillName = self:GetChild("Back/ActiveSkill/Name")
  self._activePanel_level = self:GetChild("Back/ActiveSkill/Level/Num")
  self._activePanel_yellowCost = self:GetChild("Back/ActiveSkill/Cost/Num1")
  self._activePanel_purpleCost = self:GetChild("Back/ActiveSkill/Cost/Num2")
  self._activePanel_type = self:GetChild("Back/ActiveSkill/Type/Num")
  self._activePanel_range = self:GetChild("Back/ActiveSkill/Range/Num")
  self._activePanel_detail = self:GetChild("Back/ActiveSkill/Detail")
  self._skillDetails[Skill.Type.Active] = {}
  local map = self._skillDetails[Skill.Type.Active]
  map.panel = self._activePanel
  map.panelAnchoredx, map.panelAnchoredy = map.panel:GetAnchoredPosition()
  map.txt = self._activePanel_detail
  map.txt_width, map.txt_height = map.txt:GetRectSize()
  map.anchorMinX, map.anchorMinY, map.anchorMaxX, map.anchorMaxY, map.offsetMinX, map.offsetMinY, map.offsetMaxX, map.offsetMaxY = map.txt:GetAnchorAndOffset()
  self._chargingPanel = self:GetChild("Back/EnergySkill")
  self._chargingPanel_skillName = self:GetChild("Back/EnergySkill/Name")
  self._chargingPanel_level = self:GetChild("Back/EnergySkill/Level/Num")
  self._chargingPanel_markPanel = self:GetChild("Back/EnergySkill/Cost/SkillMarkFrame")
  self._chargingPanel_markIBtn = self:GetChild("Back/EnergySkill/Cost/Ibtn")
  self._chargingPanel_type = self:GetChild("Back/EnergySkill/Type/Num")
  self._chargingPanel_range = self:GetChild("Back/EnergySkill/Range/Num")
  self._chargingPanel_detail = self:GetChild("Back/EnergySkill/Detail")
  self._skillDetails[Skill.Type.Charging] = {}
  map = self._skillDetails[Skill.Type.Charging]
  map.panel = self._chargingPanel
  map.panelAnchoredx, map.panelAnchoredy = map.panel:GetAnchoredPosition()
  map.txt = self._chargingPanel_detail
  map.txt_width, map.txt_height = map.txt:GetRectSize()
  map.anchorMinX, map.anchorMinY, map.anchorMaxX, map.anchorMaxY, map.offsetMinX, map.offsetMinY, map.offsetMaxX, map.offsetMaxY = map.txt:GetAnchorAndOffset()
  self._chargingPanel_markFrame = TableFrame.Create(self._chargingPanel_markPanel, self, false, false)
  self._chargingPanel_markIBtn:Subscribe_PointerClickEvent(self.OnChargingIBtnClicked, self)
  self._passivePanel = self:GetChild("Back/PassiveSkill")
  self._passivePanel_skillName = self:GetChild("Back/PassiveSkill/Name")
  self._passivePanel_level = self:GetChild("Back/PassiveSkill/Level/Num")
  self._passivePanel_type = self:GetChild("Back/PassiveSkill/Type/Num")
  self._passivePanel_detail = self:GetChild("Back/PassiveSkill/Detail")
  self._skillDetails[Skill.Type.Passive] = {}
  map = self._skillDetails[Skill.Type.Passive]
  map.panel = self._passivePanel
  map.panelAnchoredx, map.panelAnchoredy = map.panel:GetAnchoredPosition()
  map.txt = self._passivePanel_detail
  map.txt_width, map.txt_height = map.txt:GetRectSize()
  map.anchorMinX, map.anchorMinY, map.anchorMaxX, map.anchorMaxY, map.offsetMinX, map.offsetMinY, map.offsetMaxX, map.offsetMaxY = map.txt:GetAnchorAndOffset()
  self._attrPanel = self:GetChild("Back/PropSkill")
  self._attrPanel_skillName = self:GetChild("Back/PropSkill/Name")
  self._attrPanel_type = self:GetChild("Back/PropSkill/Type/Num")
  self._attrPanel_detail = self:GetChild("Back/PropSkill/Detail")
  self._skillDetails[Skill.Type.Attribute] = {}
  map = self._skillDetails[Skill.Type.Attribute]
  map.panel = self._attrPanel
  map.panelAnchoredx, map.panelAnchoredy = map.panel:GetAnchoredPosition()
  map.txt = self._attrPanel_detail
  map.txt_width, map.txt_height = map.txt:GetRectSize()
  map.anchorMinX, map.anchorMinY, map.anchorMaxX, map.anchorMaxY, map.offsetMinX, map.offsetMinY, map.offsetMaxX, map.offsetMaxY = map.txt:GetAnchorAndOffset()
  self._rootWindow:Subscribe_PointerClickEvent(self.OnRootWindowClicked, self)
end

function SkillTipsDialog:OnDestroy()
  self._chargingPanel_markFrame:Destroy()
end

function SkillTipsDialog:SetSkillAndRoleId(skillId, skillItemId, roleId)
  local skill = Skill.Create(skillId, skillItemId or true)
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
  elseif type == Skill.Type.Charging then
    self._activePanel:SetActive(false)
    self._chargingPanel:SetActive(true)
    self._passivePanel:SetActive(false)
    self._attrPanel:SetActive(false)
    self._chargingPanel_skillName:SetText(name)
    self._chargingPanel_level:SetText(level)
    self._chargingPanel_type:SetText(typeTxt)
    self._chargingPanel_range:SetText(skill:GetRangeTxt())
    self.chargingMarkNum = skill:GetChargingNumByRoleId(roleId)
    self._chargingPanel_markFrame:ReloadAllCell()
  elseif type == Skill.Type.Passive then
    self._activePanel:SetActive(false)
    self._chargingPanel:SetActive(false)
    self._passivePanel:SetActive(true)
    self._attrPanel:SetActive(false)
    self._passivePanel_skillName:SetText(name)
    self._passivePanel_level:SetText(level)
    self._passivePanel_type:SetText(typeTxt)
  elseif type == Skill.Type.Attribute then
    self._activePanel:SetActive(false)
    self._chargingPanel:SetActive(false)
    self._passivePanel:SetActive(false)
    self._attrPanel:SetActive(true)
    self._attrPanel_skillName:SetText(name)
    self._attrPanel_type:SetText(typeTxt)
  end
  local map = self._skillDetails[type]
  if map then
    map.txt:SetText(detail)
    local _, textHeight = map.txt:GetPreferredSize()
    if textHeight > map.txt_height then
      local delta = textHeight - map.txt_height
      map.txt:SetAnchorAndOffset(map.anchorMinX, map.anchorMinY, map.anchorMaxX, map.anchorMaxY, map.offsetMinX, map.offsetMinY - delta, map.offsetMaxX, map.offsetMaxY)
      self._back:SetDeltaSize(self._backDeltaWidth, self._backDeltaHeight + delta)
      map.panel:SetAnchoredPosition(map.panelAnchoredx, map.panelAnchoredy + delta / 2)
    end
  end
end

function SkillTipsDialog:NumberOfCell(frame, index)
  if frame == self._chargingPanel_markFrame then
    return self.chargingMarkNum
  end
end

function SkillTipsDialog:CellAtIndex(frame, index)
  if frame == self._chargingPanel_markFrame then
    return "character.chargingmarkcell"
  end
end

function SkillTipsDialog:DataAtIndex(frame, index)
  if frame == self._chargingPanel_markFrame then
    return true
  end
end

function SkillTipsDialog:OnChargingIBtnClicked()
  DialogManager.CreateSingletonDialog("skill.chargingskillusageruledialog")
end

function SkillTipsDialog:OnRootWindowClicked(args)
  if not UIManager.RectangleContainsScreenPoint(self._back._uiObject, args.position.x, args.position.y) then
    self:OnBackBtnClicked()
  end
end

function SkillTipsDialog:OnBackBtnClicked()
  self:Destroy()
end

return SkillTipsDialog
