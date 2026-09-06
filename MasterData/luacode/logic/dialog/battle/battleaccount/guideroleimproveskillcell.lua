local Skill = require("logic.manager.experimental.types.skill")
local GuideRoleImproveSkillCell = class("GuideRoleImproveSkillCell", Dialog)
GuideRoleImproveSkillCell.AssetBundleName = "ui/layouts.battlelose"
GuideRoleImproveSkillCell.AssetName = "DefeatGuideSkillCell"

function GuideRoleImproveSkillCell:Ctor(...)
  GuideRoleImproveSkillCell.super.Ctor(self, ...)
end

function GuideRoleImproveSkillCell:OnCreate()
  self._frame = self:GetChild("CharSmallCell/Frame")
  self._photo = self:GetChild("CharSmallCell/Photo")
  self._downRankBack = self:GetChild("CharSmallCell/DownRankBack")
  self._level = self:GetChild("CharSmallCell/Level/Num")
  self._rankBack = self:GetChild("CharSmallCell/RankBack")
  self._rank = self:GetChild("CharSmallCell/Rank")
  self._job = self:GetChild("CharSmallCell/Job")
  self._breakLevelBackBlack = self:GetChild("CharSmallCell/BreakLevelBackBlack")
  self._breakLevelBack = self:GetChild("CharSmallCell/BreakLevelBack")
  self._breakLevelNum = self:GetChild("CharSmallCell/BreakLevelNum")
  self._breakLevel = self:GetChild("CharSmallCell/BreakLevel")
  self._element = self:GetChild("CharSmallCell/Element")
  self._grey = self:GetChild("CharSmallCell/Grey")
  self._select = self:GetChild("CharSmallCell/Select")
  self._skillCells = {}
  for i = 1, 2 do
    self._skillCells[i] = DialogManager.CreateDialog("skill.skillcell", self:GetChild("SkillCell" .. i)._uiObject)
  end
  self._txt = self:GetChild("Txt")
  self._goBtn = self:GetChild("GoBtn")
  self._goBtn:Subscribe_PointerClickEvent(self.OnGoBtnClick, self)
end

function GuideRoleImproveSkillCell:OnDestroy()
end

local function RefreshSkills(self)
  for i = 1, 2 do
    if self._cellData.showSkills[i] then
      local skillInfo = self._cellData.role:GetShowSkillDataByIndex(i)
      local skill = Skill.Create(skillInfo.skillId, skillInfo.skillItemId or true)
      self._skillCells[i]._rootWindow:SetActive(true)
      self._skillCells[i]:Init(skill, skillInfo.unlock)
    else
      self._skillCells[i]._rootWindow:SetActive(false)
    end
  end
end

function GuideRoleImproveSkillCell:RefreshCell(data)
  local str = TextManager.GetText(701096)
  str = string.gsub(str, "%$parameter1%$", self._delegate._selectGuideType.recommendSkillLevel)
  self._txt:SetText(str)
  local image = data.role:GetShapeLittleHeadImageRecord()
  self._photo:SetSprite(image.assetBundle, image.assetName)
  image = data.role:GetSmallRarityFrameRecord()
  self._frame:SetSprite(image.assetBundle, image.assetName)
  image = data.role:GetRarityBottomBackRecord()
  self._downRankBack:SetSprite(image.assetBundle, image.assetName)
  self._level:SetText(data.role:GetShowLv())
  image = data.role:GetRarityImageRecord()
  self._rank:SetSprite(image.assetBundle, image.assetName)
  image = data.role:GetVocationImageRecord()
  self._job:SetSprite(image.assetBundle, image.assetName)
  local breakLv = data.role:GetBreakLv()
  self._breakLevelBackBlack:SetActive(breakLv == 0)
  self._breakLevelBack:SetActive(0 < breakLv)
  self._breakLevelNum:SetActive(0 < breakLv)
  if 0 < breakLv then
    image = data.role:GetCurBreakFrame1ImageRecord()
    self._breakLevelBack:SetSprite(image.assetBundle, image.assetName)
    self._breakLevelNum:SetText(breakLv)
  end
  image = data.role:GetElementImageRecord()
  self._element:SetSprite(image.assetBundle, image.assetName)
  RefreshSkills(self)
end

function GuideRoleImproveSkillCell:OnGoBtnClick()
  DialogManager.CreateSingletonDialog("character.characterskilldialog"):SetData(self._cellData.role:GetId())
end

function GuideRoleImproveSkillCell:OnEvent(eventName, arg)
  if eventName == "RefreshSkill" then
    self._cellData.role = NekoData.BehaviorManager.BM_AllRoles:GetRole(self._cellData.role:GetId())
    RefreshSkills(self)
  end
end

return GuideRoleImproveSkillCell
