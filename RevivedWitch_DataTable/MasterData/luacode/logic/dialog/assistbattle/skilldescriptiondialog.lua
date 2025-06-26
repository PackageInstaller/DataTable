-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/assistbattle/skilldescriptiondialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local CSkillShow_Role = (BeanManager.GetTableByName)("skill.cskillshow_role")
local Skill = require("logic.manager.experimental.types.skill")
local SkillDescriptionDialog = class("SkillDescriptionDialog", Dialog)
SkillDescriptionDialog.AssetBundleName = "ui/layouts.teamedit"
SkillDescriptionDialog.AssetName = "TeamEditChooseAssistDetail"
SkillDescriptionDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SkillDescriptionDialog
  ((SkillDescriptionDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

SkillDescriptionDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._back = self:GetChild("BackImage")
  self._text = self:GetChild("BackImage/Text")
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnGlobalPointerDown, Common.n_GlobalPointerWillDown, nil)
end

SkillDescriptionDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

SkillDescriptionDialog.Init = function(self, skillId, skillItemId)
  -- function num : 0_3 , upvalues : Skill
  local skill = (Skill.Create)(skillId, skillItemId)
  ;
  (self._text):SetText(skill:GetDescribeTxt())
end

SkillDescriptionDialog.OnGlobalPointerDown = function(self, args)
  -- function num : 0_4 , upvalues : UIManager
  if not (UIManager.RectangleContainsScreenPoint)((self._back)._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) then
    self:OnBackBtnClicked()
  end
end

SkillDescriptionDialog.OnBackBtnClicked = function(self)
  -- function num : 0_5
  self:Destroy()
end

return SkillDescriptionDialog

