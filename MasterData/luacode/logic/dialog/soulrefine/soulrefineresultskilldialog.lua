local CSkillTable = BeanManager.GetTableByName("skill.cskill")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CSkillItemTable = BeanManager.GetTableByName("item.cskillitem")
local CCostSkillTable = BeanManager.GetTableByName("skill.ccostskill")
local SoulRefineResultSkillDialog = class("SoulRefineResultSkillDialog", Dialog)
SoulRefineResultSkillDialog.AssetBundleName = "ui/layouts.baseskill"
SoulRefineResultSkillDialog.AssetName = "BaseSkillChangeResultSkill"

function SoulRefineResultSkillDialog:Ctor(...)
  SoulRefineResultSkillDialog.super.Ctor(self, ...)
  self._fastMenuDialogStatus = false
  self._groupName = "Modal"
  self._skillItem = nil
end

function SoulRefineResultSkillDialog:OnCreate()
  self._skill = self:GetChild("SkillCell/Back/BackGround/Skill")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnMouseClicked, self)
end

function SoulRefineResultSkillDialog:OnDestroy()
end

function SoulRefineResultSkillDialog:SetData(skillKey)
end

function SoulRefineResultSkillDialog:OnMouseClicked()
  self:Destroy()
end

return SoulRefineResultSkillDialog
