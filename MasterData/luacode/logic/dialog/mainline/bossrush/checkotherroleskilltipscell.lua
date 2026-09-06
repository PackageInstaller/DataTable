local CSkillShow_Role = BeanManager.GetTableByName("skill.cskillshow_role")
local CSKIllTable = BeanManager.GetTableByName("skill.cskill")
local Skill = require("logic.manager.experimental.types.skill")
local CheckOtherRoleSkillTipsCell = class("CheckOtherRoleSkillTipsCell", Dialog)
CheckOtherRoleSkillTipsCell.AssetBundleName = "ui/layouts.basecharacterinfo"
CheckOtherRoleSkillTipsCell.AssetName = "SkillDetailCell"

function CheckOtherRoleSkillTipsCell:Ctor(...)
  CheckOtherRoleSkillTipsCell.super.Ctor(self, ...)
end

function CheckOtherRoleSkillTipsCell:OnCreate()
  self._skillNameBack = self:GetChild("NameBack")
  self._skillName = self:GetChild("Name")
  self._skillLvPanel = self:GetChild("Level")
  self._skillLv = self:GetChild("Level/Num")
  self._skillCostPanel = self:GetChild("Cost")
  self._skillCostYellow = self:GetChild("Cost/Num1")
  self._skillCostPurple = self:GetChild("Cost/Num2")
  self._skillDescribe = self:GetChild("Detail")
  self._skillNameRectX = self._skillName:GetRectSize()
  self._skillNameBackX, self._skillNameBackOX, self._skillNameBackY, self._skillNameBackOY = self._skillNameBack:GetSize()
  self._skillNameX, self._skillNameOX, self._skillNameY, self._skillNameOY = self._skillName:GetSize()
  self._skillLvPanelX, self._skillLvPanelOX, self._skillLvPanelY, self._skillLvPanelOY = self._skillLvPanel:GetPosition()
  self._skillCostPanelX, self._skillCostPanelOX, self._skillCostPanelY, self._skillCostPanelOY = self._skillCostPanel:GetPosition()
  self._skillDescribe:SetText("")
  self._width, self._height = self._skillDescribe:GetRectSize()
  local _ = 0
  _, self._oneline = self._skillDescribe:GetPreferredSize()
  self._skillDescribe_size_x, self._skillDescribe_size_offset_x, self._skillDescribe_size_y, self._skillDescribe_size_offset_y = self._skillDescribe:GetSize()
  self._skillDescribe_pos_x, self._skillDescribe_pos_offset_x, self._skillDescribe_pos_y, self._skillDescribe_pos_offset_y = self._skillDescribe:GetPosition()
  self._rootWindow_size_x, self._rootWindow_size_offset_x, self._rootWindow_size_y, self._rootWindow_size_offset_y = self:GetRootWindow():GetSize()
  self._rootWindow_pos_x, self._rootWindow_pos_offset_x, self._rootWindow_pos_y, self._rootWindow_pos_offset_y = self:GetRootWindow():GetPosition()
end

function CheckOtherRoleSkillTipsCell:OnDestroy()
end

function CheckOtherRoleSkillTipsCell:RefreshCell(data)
  local skillLevelId = data.skillLevelId
  local cSkillTable = CSKIllTable:GetRecorder(skillLevelId)
  self._skillLv:SetText(cSkillTable.skillLevel)
  local skillItem = Skill.Create(skillLevelId, data.itemId)
  self._skillCostYellow:SetText(skillItem:GetYellowCost())
  self._skillCostPurple:SetText(skillItem:GetPurpleCost())
  local show = CSkillShow_Role:GetRecorder(cSkillTable.id)
  if show then
    self._skillName:SetText(tostring(TextManager.GetText(show.nameTextID)))
    local size = self._skillName:GetPreferredSize()
    if size > self._skillNameRectX then
      local delta = size - self._skillNameRectX
      self._skillNameBack:SetSize(self._skillNameBackX, self._skillNameBackOX + delta, self._skillNameBackY, self._skillNameBackOY)
      self._skillName:SetSize(self._skillNameX, size, self._skillNameY, self._skillNameOY)
      self._skillLvPanel:SetPosition(self._skillLvPanelX, self._skillLvPanelOX + delta, self._skillLvPanelY, self._skillLvPanelOY)
      self._skillCostPanel:SetPosition(self._skillCostPanelX, self._skillCostPanelOX + delta, self._skillCostPanelY, self._skillCostPanelOY)
    end
    self._skillDescribe:SetText(NekoData.BehaviorManager.BM_Message:GetRoleSkillDescribe(cSkillTable.id))
    local fontsize = self._skillDescribe:GetFontSize()
    local _, textheight = self._skillDescribe:GetPreferredSize()
    if textheight > self._height then
      delta = textheight - self._height
      self._skillDescribe:SetSize(self._skillDescribe_size_x, self._skillDescribe_size_offset_x, self._skillDescribe_size_y, self._skillDescribe_size_offset_y + delta)
      self._skillDescribe:SetPosition(self._skillDescribe_pos_x, self._skillDescribe_pos_offset_x, self._skillDescribe_pos_y, self._skillDescribe_pos_offset_y - delta)
      self:GetRootWindow():SetSize(self._rootWindow_size_x, self._rootWindow_size_offset_x, self._rootWindow_size_y, self._rootWindow_size_offset_y + delta)
    else
      self._skillDescribe:SetSize(self._skillDescribe_size_x, self._skillDescribe_size_offset_x, self._skillDescribe_size_y, self._skillDescribe_size_offset_y)
      self._skillDescribe:SetPosition(self._skillDescribe_pos_x, self._skillDescribe_pos_offset_x, self._skillDescribe_pos_y, self._skillDescribe_pos_offset_y)
      self:GetRootWindow():SetSize(self._rootWindow_size_x, self._rootWindow_size_offset_x, self._rootWindow_size_y, self._rootWindow_size_offset_y)
    end
  else
    LogErrorFormat("CheckOtherRoleSkillTipsCell", "skill id %s in cskill has no corresponding record in cskillshow_role", cSkillTable.id)
  end
end

return CheckOtherRoleSkillTipsCell
