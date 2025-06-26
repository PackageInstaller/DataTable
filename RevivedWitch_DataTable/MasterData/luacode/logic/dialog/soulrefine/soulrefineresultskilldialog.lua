-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/soulrefine/soulrefineresultskilldialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CSkillTable = (BeanManager.GetTableByName)("skill.cskill")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CSkillItemTable = (BeanManager.GetTableByName)("item.cskillitem")
local CCostSkillTable = (BeanManager.GetTableByName)("skill.ccostskill")
local SoulRefineResultSkillDialog = class("SoulRefineResultSkillDialog", Dialog)
SoulRefineResultSkillDialog.AssetBundleName = "ui/layouts.baseskill"
SoulRefineResultSkillDialog.AssetName = "BaseSkillChangeResultSkill"
SoulRefineResultSkillDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SoulRefineResultSkillDialog
  ((SoulRefineResultSkillDialog.super).Ctor)(self, ...)
  self._fastMenuDialogStatus = false
  self._groupName = "Modal"
  self._skillItem = nil
end

SoulRefineResultSkillDialog.OnCreate = function(self)
  -- function num : 0_1
  self._skill = self:GetChild("SkillCell/Back/BackGround/Skill")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnMouseClicked, self)
end

SoulRefineResultSkillDialog.OnDestroy = function(self)
  -- function num : 0_2
end

SoulRefineResultSkillDialog.SetData = function(self, skillKey)
  -- function num : 0_3
end

SoulRefineResultSkillDialog.OnMouseClicked = function(self)
  -- function num : 0_4
  self:Destroy()
end

return SoulRefineResultSkillDialog

