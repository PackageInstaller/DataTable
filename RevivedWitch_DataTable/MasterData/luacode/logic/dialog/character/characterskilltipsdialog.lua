-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/character/characterskilltipsdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local Skill = require("logic.manager.experimental.types.skill")
local CSkillShow_Role = (BeanManager.GetTableByName)("skill.cskillshow_role")
local CSkillTable = (BeanManager.GetTableByName)("skill.cskill")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CSkillItemTable = (BeanManager.GetTableByName)("item.cskillitem")
local CCostSkillTable = (BeanManager.GetTableByName)("skill.ccostskill")
local CharacterSkillTipsDialog = class("CharacterSkillTipsDialog", Dialog)
CharacterSkillTipsDialog.AssetBundleName = "ui/layouts.baseskill"
CharacterSkillTipsDialog.AssetName = "SkillTips"
CharacterSkillTipsDialog.SkillType = {ContractSkill = 1, OrderSkill = 2}
CharacterSkillTipsDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : CharacterSkillTipsDialog
  ((CharacterSkillTipsDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

CharacterSkillTipsDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._skill = self:GetChild("SkillBack/Skill")
  self._skillName = self:GetChild("SkillName")
  self._lv = self:GetChild("Level/Num")
  self._num1 = self:GetChild("Cost/Num1")
  self._num2 = self:GetChild("Cost/Num2")
  self._describeName = self:GetChild("PropertyPanel/SkillTips/CellPanel/SkillTipsCell/PropertyName")
  self._describe = self:GetChild("PropertyPanel/SkillTips/CellPanel/SkillTipsCell/PropertyNum")
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnEveryWhereClick, Common.n_GlobalPointerWillDown, nil)
end

CharacterSkillTipsDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

CharacterSkillTipsDialog.Init = function(self, skillId)
  -- function num : 0_3 , upvalues : CSkillTable, CImagePathTable, _ENV, CSkillShow_Role
  local cSkillTable = CSkillTable:GetRecorder(skillId)
  if not CImagePathTable:GetRecorder(cSkillTable.icon) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._skill):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local show = CSkillShow_Role:GetRecorder(skillId)
  ;
  (self._skillName):SetText(tostring((TextManager.GetText)(show.nameTextID)))
  ;
  (self._describeName):SetText(tostring((TextManager.GetText)(show.nameTextID)))
  ;
  (self._describe):SetText(((NekoData.BehaviorManager).BM_Message):GetRoleSkillDescribe(skillId))
end

CharacterSkillTipsDialog.SetData = function(self, skillTable)
  -- function num : 0_4 , upvalues : CSkillTable, CImagePathTable, _ENV, CSkillShow_Role, CCostSkillTable, Skill, CSkillItemTable
  local skillId = skillTable.skillLevel
  local cSkillTable = CSkillTable:GetRecorder(skillId)
  if not CImagePathTable:GetRecorder(cSkillTable.icon) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._skill):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local show = CSkillShow_Role:GetRecorder(skillId)
  ;
  (self._skillName):SetText(tostring((TextManager.GetText)(show.nameTextID)))
  ;
  (self._describeName):SetText(tostring((TextManager.GetText)(show.nameTextID)))
  ;
  (self._describe):SetText(((NekoData.BehaviorManager).BM_Message):GetRoleSkillDescribe(skillId))
  local record = CCostSkillTable:GetRecorder(skillId)
  ;
  (self._num1):SetText(record.ChaosCost)
  ;
  (self._num2):SetText(record.OrderCost)
  local record = {}
  local skillItem = nil
  if skillTable.type == (self.SkillType).ContractSkill then
    skillItem = (Skill.Create)(skillTable.onlyMark)
    record = CSkillItemTable:GetRecorder(skillTable.onlyMark)
  end
  for i,si in ipairs(record.skillID) do
    if si == skillTable.skillLevel then
      (self._lv):SetText(i)
    end
  end
end

CharacterSkillTipsDialog.OnEveryWhereClick = function(self, args)
  -- function num : 0_5 , upvalues : UIManager
  if not (UIManager.RectangleContainsScreenPoint)((self:GetRootWindow())._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) then
    self:OnBackBtnClicked()
  end
end

CharacterSkillTipsDialog.OnBackBtnClicked = function(self)
  -- function num : 0_6
  self:Destroy()
end

return CharacterSkillTipsDialog

