local Skill = require("logic.manager.experimental.types.skill")
local PromptUnlockSkillCell = class("PromptUnlockSkillCell", Dialog)
PromptUnlockSkillCell.AssetBundleName = "ui/layouts.teamedit"
PromptUnlockSkillCell.AssetName = "TeamEditSkillUnlockCell"

function PromptUnlockSkillCell:Ctor(...)
  PromptUnlockSkillCell.super.Ctor(self, ...)
end

function PromptUnlockSkillCell:OnCreate()
  self._frame = self:GetChild("Back/CharSmallCell/Frame")
  self._photo = self:GetChild("Back/CharSmallCell/Photo")
  self._downRankBack = self:GetChild("Back/CharSmallCell/DownRankBack")
  self._level = self:GetChild("Back/CharSmallCell/Level/Num")
  self._rankBack = self:GetChild("Back/CharSmallCell/RankBack")
  self._rank = self:GetChild("Back/CharSmallCell/Rank")
  self._job = self:GetChild("Back/CharSmallCell/Job")
  self._breakLevelBackBlack = self:GetChild("Back/CharSmallCell/BreakLevelBackBlack")
  self._breakLevelBack = self:GetChild("Back/CharSmallCell/BreakLevelBack")
  self._breakLevelNum = self:GetChild("Back/CharSmallCell/BreakLevelNum")
  self._breakLevel = self:GetChild("Back/CharSmallCell/BreakLevel")
  self._element = self:GetChild("Back/CharSmallCell/Element")
  self._skillIcon = self:GetChild("Back/SkillCell/Skill")
  self._lvPanel_txt = self:GetChild("Back/SkillCell/NumBack/Num")
  self._chargingPanel = self:GetChild("Back/SkillCell/Energy")
  self._txt = self:GetChild("Back/Title")
  self._goBtn = self:GetChild("Back/GoBtn")
  self._lack = self:GetChild("Back/Lack")
  self._lackTxt = self:GetChild("Back/Lack/LackText")
  self._goBtn:Subscribe_PointerClickEvent(self.OnGoBtnClick, self)
end

function PromptUnlockSkillCell:OnDestroy()
end

function PromptUnlockSkillCell:RefreshCell(role)
  local image = role:GetShapeLittleHeadImageRecord()
  self._photo:SetSprite(image.assetBundle, image.assetName)
  image = role:GetSmallRarityFrameRecord()
  self._frame:SetSprite(image.assetBundle, image.assetName)
  image = role:GetRarityBottomBackRecord()
  self._downRankBack:SetSprite(image.assetBundle, image.assetName)
  self._level:SetText(role:GetShowLv())
  image = role:GetRarityImageRecord()
  self._rank:SetSprite(image.assetBundle, image.assetName)
  image = role:GetVocationImageRecord()
  self._job:SetSprite(image.assetBundle, image.assetName)
  local breakLv = role:GetBreakLv()
  self._breakLevelBackBlack:SetActive(breakLv == 0)
  self._breakLevelBack:SetActive(0 < breakLv)
  self._breakLevelNum:SetActive(0 < breakLv)
  if 0 < breakLv then
    image = role:GetCurBreakFrame1ImageRecord()
    self._breakLevelBack:SetSprite(image.assetBundle, image.assetName)
    self._breakLevelNum:SetText(breakLv)
  end
  image = role:GetElementImageRecord()
  self._element:SetSprite(image.assetBundle, image.assetName)
  local skill2Info = role:GetShowSkillDataByIndex(2)
  local skill = Skill.Create(skill2Info.skillId, skill2Info.skillItemId or true)
  local imgRecord = skill:GetSkillIcon()
  self._skillIcon:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  local lv = skill:GetSkillLevel()
  self._lvPanel_txt:SetText(lv)
  self._chargingPanel:SetActive(skill:GetType() == Skill.Type.Charging)
  self._txt:SetText(NekoData.BehaviorManager.BM_Message:GetString(1521, {
    skill:GetSkillName()
  }))
  local canUnlock = role:IsShowSkillRedDot()
  self._goBtn:SetActive(canUnlock)
  if not canUnlock then
    local nodeRecord
    local allNodes = role:GetAllSkillNodes()
    for k, v in pairs(allNodes) do
      local skillItemId
      local skillId = v.skillID
      if NekoData.BehaviorManager.BM_Game:IsSkillItemId(skillId) then
        local tempSkill = Skill.Create(skillId)
        tempSkill:SetLevel(v.skillLevel)
        skillItemId = tempSkill:GetID()
      else
        skillItemId = skillId
      end
      if skillItemId == skill2Info.skillItemId and v.skillLevel == lv then
        nodeRecord = v
        break
      end
    end
    local roleLvEnough = true
    if nodeRecord then
      roleLvEnough = role:GetLevel() >= nodeRecord.roleSkill
    end
    local str
    if not roleLvEnough then
      str = NekoData.BehaviorManager.BM_Message:GetString(1527)
    else
      str = NekoData.BehaviorManager.BM_Message:GetString(1526)
    end
    self._lack:SetActive(true)
    self._lackTxt:SetText(str)
  else
    self._lack:SetActive(false)
  end
end

function PromptUnlockSkillCell:OnGoBtnClick()
  DialogManager.CreateSingletonDialog("character.characterskilldialog"):SetData(self._cellData:GetId())
end

return PromptUnlockSkillCell
