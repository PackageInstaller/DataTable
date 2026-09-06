local DungeonSkillBanner = class("DungeonSkillBanner", Dialog)
local CInitiativeSkill = BeanManager.GetTableByName("skill.cinitiativeskill")
local CPerform = BeanManager.GetTableByName("sceneinteractive.cinteractiveperformanceconfig")
local Role = require("logic.manager.experimental.types.role")
DungeonSkillBanner.AssetBundleName = "ui/layouts.dungeon"
DungeonSkillBanner.AssetName = "DungeonSkillBanner"

function DungeonSkillBanner:Ctor(...)
  DungeonSkillBanner.super.Ctor(self, ...)
  self._groupName = "Default"
end

function DungeonSkillBanner:OnCreate()
  self._back = self:GetChild("SkillBack")
  self._photo = self:GetChild("Photo")
  self._skillName = self:GetChild("SkillName")
  self._charname = self:GetChild("CharName")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnSelfClick, self)
  self:GetRootWindow():Subscribe_StateExitEvent(self.OnBannerShowStateExit, self)
end

function DungeonSkillBanner:OnDestroy()
end

function DungeonSkillBanner:SetData(data, roleId)
  self._data = data
  self._roleId = roleId
  local skill = CMapSkill:GetRecorder(self._data)
  skill = skill or CInitiativeSkill:GetRecorder(self._data)
  self._skillName:SetText(skill.name)
  local perform = CPerform:GetRecorder(skill.animation)
  self._charname:SetText(perform.CharacterName)
  local role = Role.Create(self._roleId)
  local record = role:GetShapeLiHuiImageRecord()
  self._photo:SetSprite(record.assetBundle, record.assetName)
  self:GetRootWindow():PlayAnimation("SkillBannerShow")
end

function DungeonSkillBanner:OnBannerShowStateExit(arg1, arg2)
  if arg2 == "aniEnd" then
    self:Destroy()
  end
end

return DungeonSkillBanner
