local UIManager = CS.PixelNeko.UI.UIManager
local Skill = require("logic.manager.experimental.types.skill")
local CSkillShow_Role = BeanManager.GetTableByName("skill.cskillshow_role")
local CSkillTable = BeanManager.GetTableByName("skill.cskill")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CSkillItemTable = BeanManager.GetTableByName("item.cskillitem")
local CCostSkillTable = BeanManager.GetTableByName("skill.ccostskill")
local CharacterSkillTipsDialog = class("CharacterSkillTipsDialog", Dialog)
CharacterSkillTipsDialog.AssetBundleName = "ui/layouts.baseskill"
CharacterSkillTipsDialog.AssetName = "SkillTips"
CharacterSkillTipsDialog.SkillType = {ContractSkill = 1, OrderSkill = 2}

function CharacterSkillTipsDialog:Ctor(...)
  CharacterSkillTipsDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function CharacterSkillTipsDialog:OnCreate()
  self._skill = self:GetChild("SkillBack/Skill")
  self._skillName = self:GetChild("SkillName")
  self._lv = self:GetChild("Level/Num")
  self._num1 = self:GetChild("Cost/Num1")
  self._num2 = self:GetChild("Cost/Num2")
  self._describeName = self:GetChild("PropertyPanel/SkillTips/CellPanel/SkillTipsCell/PropertyName")
  self._describe = self:GetChild("PropertyPanel/SkillTips/CellPanel/SkillTipsCell/PropertyNum")
  LuaNotificationCenter.AddObserver(self, self.OnEveryWhereClick, Common.n_GlobalPointerWillDown, nil)
end

function CharacterSkillTipsDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function CharacterSkillTipsDialog:Init(skillId)
  local cSkillTable = CSkillTable:GetRecorder(skillId)
  local imageRecord = CImagePathTable:GetRecorder(cSkillTable.icon) or DataCommon.DefaultImageAsset
  self._skill:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local show = CSkillShow_Role:GetRecorder(skillId)
  self._skillName:SetText(tostring(TextManager.GetText(show.nameTextID)))
  self._describeName:SetText(tostring(TextManager.GetText(show.nameTextID)))
  self._describe:SetText(NekoData.BehaviorManager.BM_Message:GetRoleSkillDescribe(skillId))
end

function CharacterSkillTipsDialog:SetData(skillTable)
  local skillId = skillTable.skillLevel
  local cSkillTable = CSkillTable:GetRecorder(skillId)
  local imageRecord = CImagePathTable:GetRecorder(cSkillTable.icon) or DataCommon.DefaultImageAsset
  self._skill:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local show = CSkillShow_Role:GetRecorder(skillId)
  self._skillName:SetText(tostring(TextManager.GetText(show.nameTextID)))
  self._describeName:SetText(tostring(TextManager.GetText(show.nameTextID)))
  self._describe:SetText(NekoData.BehaviorManager.BM_Message:GetRoleSkillDescribe(skillId))
  local record = CCostSkillTable:GetRecorder(skillId)
  self._num1:SetText(record.ChaosCost)
  self._num2:SetText(record.OrderCost)
  local record = {}
  local skillItem
  if skillTable.type == self.SkillType.ContractSkill then
    skillItem = Skill.Create(skillTable.onlyMark)
    record = CSkillItemTable:GetRecorder(skillTable.onlyMark)
  end
  for i, si in ipairs(record.skillID) do
    if si == skillTable.skillLevel then
      self._lv:SetText(i)
    end
  end
end

function CharacterSkillTipsDialog:OnEveryWhereClick(args)
  if not UIManager.RectangleContainsScreenPoint(self:GetRootWindow()._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) then
    self:OnBackBtnClicked()
  end
end

function CharacterSkillTipsDialog:OnBackBtnClicked()
  self:Destroy()
end

return CharacterSkillTipsDialog
