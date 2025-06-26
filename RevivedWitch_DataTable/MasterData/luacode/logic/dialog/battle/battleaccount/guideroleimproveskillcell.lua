-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/battle/battleaccount/guideroleimproveskillcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Skill = require("logic.manager.experimental.types.skill")
local GuideRoleImproveSkillCell = class("GuideRoleImproveSkillCell", Dialog)
GuideRoleImproveSkillCell.AssetBundleName = "ui/layouts.battlelose"
GuideRoleImproveSkillCell.AssetName = "DefeatGuideSkillCell"
GuideRoleImproveSkillCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GuideRoleImproveSkillCell
  ((GuideRoleImproveSkillCell.super).Ctor)(self, ...)
end

GuideRoleImproveSkillCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
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
    -- DECOMPILER ERROR at PC73: Confused about usage of register: R5 in 'UnsetPending'

    (self._skillCells)[i] = (DialogManager.CreateDialog)("skill.skillcell", (self:GetChild("SkillCell" .. i))._uiObject)
  end
  self._txt = self:GetChild("Txt")
  self._goBtn = self:GetChild("GoBtn")
  ;
  (self._goBtn):Subscribe_PointerClickEvent(self.OnGoBtnClick, self)
end

GuideRoleImproveSkillCell.OnDestroy = function(self)
  -- function num : 0_2
end

local RefreshSkills = function(self)
  -- function num : 0_3 , upvalues : Skill
  for i = 1, 2 do
    if ((self._cellData).showSkills)[i] then
      local skillInfo = ((self._cellData).role):GetShowSkillDataByIndex(i)
      local skill = (Skill.Create)(skillInfo.skillId, skillInfo.skillItemId or true)
      ;
      (((self._skillCells)[i])._rootWindow):SetActive(true)
      ;
      ((self._skillCells)[i]):Init(skill, skillInfo.unlock)
    else
      do
        do
          ;
          (((self._skillCells)[i])._rootWindow):SetActive(false)
          -- DECOMPILER ERROR at PC40: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC40: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC40: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
end

GuideRoleImproveSkillCell.RefreshCell = function(self, data)
  -- function num : 0_4 , upvalues : _ENV, RefreshSkills
  local str = (TextManager.GetText)(701096)
  str = (string.gsub)(str, "%$parameter1%$", ((self._delegate)._selectGuideType).recommendSkillLevel)
  ;
  (self._txt):SetText(str)
  local image = (data.role):GetShapeLittleHeadImageRecord()
  ;
  (self._photo):SetSprite(image.assetBundle, image.assetName)
  image = (data.role):GetSmallRarityFrameRecord()
  ;
  (self._frame):SetSprite(image.assetBundle, image.assetName)
  image = (data.role):GetRarityBottomBackRecord()
  ;
  (self._downRankBack):SetSprite(image.assetBundle, image.assetName)
  ;
  (self._level):SetText((data.role):GetShowLv())
  image = (data.role):GetRarityImageRecord()
  ;
  (self._rank):SetSprite(image.assetBundle, image.assetName)
  image = (data.role):GetVocationImageRecord()
  ;
  (self._job):SetSprite(image.assetBundle, image.assetName)
  local breakLv = (data.role):GetBreakLv()
  ;
  (self._breakLevelBackBlack):SetActive(breakLv == 0)
  ;
  (self._breakLevelBack):SetActive(breakLv > 0)
  ;
  (self._breakLevelNum):SetActive(breakLv > 0)
  if breakLv > 0 then
    image = (data.role):GetCurBreakFrame1ImageRecord()
    ;
    (self._breakLevelBack):SetSprite(image.assetBundle, image.assetName)
    ;
    (self._breakLevelNum):SetText(breakLv)
  end
  image = (data.role):GetElementImageRecord()
  ;
  (self._element):SetSprite(image.assetBundle, image.assetName)
  RefreshSkills(self)
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

GuideRoleImproveSkillCell.OnGoBtnClick = function(self)
  -- function num : 0_5 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("character.characterskilldialog")):SetData(((self._cellData).role):GetId())
end

GuideRoleImproveSkillCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_6 , upvalues : _ENV, RefreshSkills
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R3 in 'UnsetPending'

  if eventName == "RefreshSkill" then
    (self._cellData).role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(((self._cellData).role):GetId())
    RefreshSkills(self)
  end
end

return GuideRoleImproveSkillCell

