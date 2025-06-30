-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/bossrush/checkotherroleskilltipscell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CSkillShow_Role = (BeanManager.GetTableByName)("skill.cskillshow_role")
local CSKIllTable = (BeanManager.GetTableByName)("skill.cskill")
local Skill = require("logic.manager.experimental.types.skill")
local CheckOtherRoleSkillTipsCell = class("CheckOtherRoleSkillTipsCell", Dialog)
CheckOtherRoleSkillTipsCell.AssetBundleName = "ui/layouts.basecharacterinfo"
CheckOtherRoleSkillTipsCell.AssetName = "SkillDetailCell"
CheckOtherRoleSkillTipsCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : CheckOtherRoleSkillTipsCell
  ((CheckOtherRoleSkillTipsCell.super).Ctor)(self, ...)
end

CheckOtherRoleSkillTipsCell.OnCreate = function(self)
  -- function num : 0_1
  self._skillNameBack = self:GetChild("NameBack")
  self._skillName = self:GetChild("Name")
  self._skillLvPanel = self:GetChild("Level")
  self._skillLv = self:GetChild("Level/Num")
  self._skillCostPanel = self:GetChild("Cost")
  self._skillCostYellow = self:GetChild("Cost/Num1")
  self._skillCostPurple = self:GetChild("Cost/Num2")
  self._skillDescribe = self:GetChild("Detail")
  self._skillNameRectX = (self._skillName):GetRectSize()
  self._skillNameBackX = (self._skillNameBack):GetSize()
  self._skillNameX = (self._skillName):GetSize()
  self._skillLvPanelX = (self._skillLvPanel):GetPosition()
  self._skillCostPanelX = (self._skillCostPanel):GetPosition()
  ;
  (self._skillDescribe):SetText("")
  self._width = (self._skillDescribe):GetRectSize()
  local _ = 0
  _ = (self._skillDescribe):GetPreferredSize()
  self._skillDescribe_size_x = (self._skillDescribe):GetSize()
  self._skillDescribe_pos_x = (self._skillDescribe):GetPosition()
  self._rootWindow_size_x = (self:GetRootWindow()):GetSize()
  self._rootWindow_pos_x = (self:GetRootWindow()):GetPosition()
end

CheckOtherRoleSkillTipsCell.OnDestroy = function(self)
  -- function num : 0_2
end

CheckOtherRoleSkillTipsCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CSKIllTable, Skill, CSkillShow_Role, _ENV
  local skillLevelId = data.skillLevelId
  local cSkillTable = CSKIllTable:GetRecorder(skillLevelId)
  ;
  (self._skillLv):SetText(cSkillTable.skillLevel)
  local skillItem = (Skill.Create)(skillLevelId, data.itemId)
  ;
  (self._skillCostYellow):SetText(skillItem:GetYellowCost())
  ;
  (self._skillCostPurple):SetText(skillItem:GetPurpleCost())
  local show = CSkillShow_Role:GetRecorder(cSkillTable.id)
  if show then
    (self._skillName):SetText(tostring((TextManager.GetText)(show.nameTextID)))
    local size = (self._skillName):GetPreferredSize()
    do
      if self._skillNameRectX < size then
        local delta = size - self._skillNameRectX
        ;
        (self._skillNameBack):SetSize(self._skillNameBackX, self._skillNameBackOX + delta, self._skillNameBackY, self._skillNameBackOY)
        ;
        (self._skillName):SetSize(self._skillNameX, size, self._skillNameY, self._skillNameOY)
        ;
        (self._skillLvPanel):SetPosition(self._skillLvPanelX, self._skillLvPanelOX + delta, self._skillLvPanelY, self._skillLvPanelOY)
        ;
        (self._skillCostPanel):SetPosition(self._skillCostPanelX, self._skillCostPanelOX + delta, self._skillCostPanelY, self._skillCostPanelOY)
      end
      ;
      (self._skillDescribe):SetText(((NekoData.BehaviorManager).BM_Message):GetRoleSkillDescribe(cSkillTable.id))
      local fontsize = (self._skillDescribe):GetFontSize()
      do
        local _, textheight = (self._skillDescribe):GetPreferredSize()
        if self._height < textheight then
          delta = textheight - self._height
          ;
          (self._skillDescribe):SetSize(self._skillDescribe_size_x, self._skillDescribe_size_offset_x, self._skillDescribe_size_y, self._skillDescribe_size_offset_y + delta)
          ;
          (self._skillDescribe):SetPosition(self._skillDescribe_pos_x, self._skillDescribe_pos_offset_x, self._skillDescribe_pos_y, self._skillDescribe_pos_offset_y - delta)
          ;
          (self:GetRootWindow()):SetSize(self._rootWindow_size_x, self._rootWindow_size_offset_x, self._rootWindow_size_y, self._rootWindow_size_offset_y + delta)
        else
          ;
          (self._skillDescribe):SetSize(self._skillDescribe_size_x, self._skillDescribe_size_offset_x, self._skillDescribe_size_y, self._skillDescribe_size_offset_y)
          ;
          (self._skillDescribe):SetPosition(self._skillDescribe_pos_x, self._skillDescribe_pos_offset_x, self._skillDescribe_pos_y, self._skillDescribe_pos_offset_y)
          ;
          (self:GetRootWindow()):SetSize(self._rootWindow_size_x, self._rootWindow_size_offset_x, self._rootWindow_size_y, self._rootWindow_size_offset_y)
        end
        LogErrorFormat("CheckOtherRoleSkillTipsCell", "skill id %s in cskill has no corresponding record in cskillshow_role", cSkillTable.id)
      end
    end
  end
end

return CheckOtherRoleSkillTipsCell

