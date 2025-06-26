-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/guide/basecharacterinfoskillchangedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BaseCharacterInfoSkillChangeDialog = class("BaseCharacterInfoSkillChangeDialog", Dialog)
BaseCharacterInfoSkillChangeDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
BaseCharacterInfoSkillChangeDialog.AssetName = "BaseCharacterInfoSkillChange2"
BaseCharacterInfoSkillChangeDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BaseCharacterInfoSkillChangeDialog
  ((BaseCharacterInfoSkillChangeDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

BaseCharacterInfoSkillChangeDialog.OnCreate = function(self)
  -- function num : 0_1
  self._skillName = self:GetChild("SkillInfoPanel/SkillName")
  self._skillScore = self:GetChild("SkillInfoPanel/ScoreNum")
  self._equipTxt = self:GetChild("SkillInfoPanel/EquipTxt")
  self._type = self:GetChild("SkillInfoPanel/TypeTxt")
  self._num1 = self:GetChild("SkillInfoPanel/Num1")
  self._num2 = self:GetChild("SkillInfoPanel/Num2")
  self._describe = self:GetChild("SkillInfoPanel/Describe")
  self._skill = self:GetChild("SkillPanel/BaseCharacterInfoSkillChangeCell/Back/BackGround/Skill")
  self._current = self:GetChild("SkillPanel/BaseCharacterInfoSkillChangeCell/Back/Current")
  self._equipTxt = self:GetChild("SkillPanel/BaseCharacterInfoSkillChangeCell/Back/EquipTxt")
  self._rank = self:GetChild("SkillPanel/BaseCharacterInfoSkillChangeCell/Back/Rank")
  self._lv = self:GetChild("SkillPanel/BaseCharacterInfoSkillChangeCell/Back/Level/Num")
  self._describe1 = self:GetChild("SkillPanel/Describe")
  self._describe2 = self:GetChild("SkillPanel/Describe(1)")
  self._changeBtn = self:GetChild("ChangeBtn")
  ;
  (self._changeBtn):Subscribe_PointerClickEvent(self.OnChangeBtnClick, self)
end

BaseCharacterInfoSkillChangeDialog.OnDestroy = function(self)
  -- function num : 0_2
end

BaseCharacterInfoSkillChangeDialog.Init = function(self, key)
  -- function num : 0_3
end

BaseCharacterInfoSkillChangeDialog.OnChangeBtnClick = function(self)
  -- function num : 0_4 , upvalues : _ENV, BaseCharacterInfoSkillChangeDialog
  self:Destroy()
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_GuideGetSkill, BaseCharacterInfoSkillChangeDialog, nil)
end

return BaseCharacterInfoSkillChangeDialog

