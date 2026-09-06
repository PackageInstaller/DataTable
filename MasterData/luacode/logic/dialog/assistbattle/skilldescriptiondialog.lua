local UIManager = CS.PixelNeko.UI.UIManager
local CSkillShow_Role = BeanManager.GetTableByName("skill.cskillshow_role")
local Skill = require("logic.manager.experimental.types.skill")
local SkillDescriptionDialog = class("SkillDescriptionDialog", Dialog)
SkillDescriptionDialog.AssetBundleName = "ui/layouts.teamedit"
SkillDescriptionDialog.AssetName = "TeamEditChooseAssistDetail"

function SkillDescriptionDialog:Ctor(...)
  SkillDescriptionDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function SkillDescriptionDialog:OnCreate()
  self._back = self:GetChild("BackImage")
  self._text = self:GetChild("BackImage/Text")
  LuaNotificationCenter.AddObserver(self, self.OnGlobalPointerDown, Common.n_GlobalPointerWillDown, nil)
end

function SkillDescriptionDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function SkillDescriptionDialog:Init(skillId, skillItemId)
  local skill = Skill.Create(skillId, skillItemId)
  self._text:SetText(skill:GetDescribeTxt())
end

function SkillDescriptionDialog:OnGlobalPointerDown(args)
  if not UIManager.RectangleContainsScreenPoint(self._back._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) then
    self:OnBackBtnClicked()
  end
end

function SkillDescriptionDialog:OnBackBtnClicked()
  self:Destroy()
end

return SkillDescriptionDialog
