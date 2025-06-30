-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/dungeon/dungeonskillbanner.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DungeonSkillBanner = class("DungeonSkillBanner", Dialog)
local CInitiativeSkill = (BeanManager.GetTableByName)("skill.cinitiativeskill")
local CPerform = (BeanManager.GetTableByName)("sceneinteractive.cinteractiveperformanceconfig")
local Role = require("logic.manager.experimental.types.role")
DungeonSkillBanner.AssetBundleName = "ui/layouts.dungeon"
DungeonSkillBanner.AssetName = "DungeonSkillBanner"
DungeonSkillBanner.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DungeonSkillBanner
  ((DungeonSkillBanner.super).Ctor)(self, ...)
  self._groupName = "Default"
end

DungeonSkillBanner.OnCreate = function(self)
  -- function num : 0_1
  self._back = self:GetChild("SkillBack")
  self._photo = self:GetChild("Photo")
  self._skillName = self:GetChild("SkillName")
  self._charname = self:GetChild("CharName")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnSelfClick, self)
  ;
  (self:GetRootWindow()):Subscribe_StateExitEvent(self.OnBannerShowStateExit, self)
end

DungeonSkillBanner.OnDestroy = function(self)
  -- function num : 0_2
end

DungeonSkillBanner.SetData = function(self, data, roleId)
  -- function num : 0_3 , upvalues : _ENV, CInitiativeSkill, CPerform, Role
  self._data = data
  self._roleId = roleId
  local skill = CMapSkill:GetRecorder(self._data)
  if not skill then
    skill = CInitiativeSkill:GetRecorder(self._data)
  end
  ;
  (self._skillName):SetText(skill.name)
  local perform = CPerform:GetRecorder(skill.animation)
  ;
  (self._charname):SetText(perform.CharacterName)
  local role = (Role.Create)(self._roleId)
  local record = role:GetShapeLiHuiImageRecord()
  ;
  (self._photo):SetSprite(record.assetBundle, record.assetName)
  ;
  (self:GetRootWindow()):PlayAnimation("SkillBannerShow")
end

DungeonSkillBanner.OnBannerShowStateExit = function(self, arg1, arg2)
  -- function num : 0_4
  if arg2 == "aniEnd" then
    self:Destroy()
  end
end

return DungeonSkillBanner

