local CSkillItemTable = BeanManager.GetTableByName("item.cskillitem")
local TeamEditSupportRoleCell = class("TeamEditSupportRoleCell", Dialog)
TeamEditSupportRoleCell.AssetBundleName = "ui/layouts.friends"
TeamEditSupportRoleCell.AssetName = "CharacterCellLargeSupport"

function TeamEditSupportRoleCell:Ctor(...)
  TeamEditSupportRoleCell.super.Ctor(self, ...)
end

function TeamEditSupportRoleCell:OnCreate()
  self._back = self:GetChild("_Cell/Back")
  self._photo = self:GetChild("_Cell/Photo")
  self._rank = self:GetChild("_Cell/Rank")
  self._rankDownBackBottom = self:GetChild("_Cell/RankDownBack")
  self._lvNum = self:GetChild("_Cell/Level/Num")
  self._lvMaxNum = self:GetChild("_Cell/Level/MaxNum")
  self._breakLevelBackBlack = self:GetChild("BreakLevelBackBlack")
  self._breakLevelBack = self:GetChild("BreakLevelBack")
  self._breakLevel = self:GetChild("BreakLevelNum")
  self._job = self:GetChild("_Cell/Job")
  self._elementImg = self:GetChild("Element")
end

function TeamEditSupportRoleCell:OnDestroy()
end

function TeamEditSupportRoleCell:RefreshCell(data)
  local image = data:GetShapeBigBustImageRecord()
  self._photo:SetSprite(image.assetBundle, image.assetName)
  image = data:GetTeamRarityBackRecord()
  self._back:SetSprite(image.assetBundle, image.assetName)
  if data:GetId() == DataCommon.LeaderId then
    self._rank:SetActive(false)
    self._rankDownBackBottom:SetActive(false)
  else
    self._rank:SetActive(true)
    image = data:GetTeamRarityImageRecord()
    self._rank:SetSprite(image.assetBundle, image.assetName)
    image = data:GetRarityRankDownRecord()
    self._rankDownBackBottom:SetSprite(image.assetBundle, image.assetName)
  end
  self._lvNum:SetText(data:GetShowLv())
  self._lvMaxNum:SetText(data:GetShowMaxBreakLv())
  self._lvMaxNum:SetText(data:GetShowMaxBreakLv())
  local breakLv = data:GetBreakLv()
  self._breakLevelBackBlack:SetActive(breakLv == 0)
  self._breakLevelBack:SetActive(0 < breakLv)
  self._breakLevel:SetActive(0 < breakLv)
  if 0 < breakLv then
    local imageRecord = data:GetCurBreakFrame1ImageRecord()
    self._breakLevelBack:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    self._breakLevel:SetText(breakLv)
  end
  image = data:GetVocationImageRecord()
  self._job:SetSprite(image.assetBundle, image.assetName)
  image = data:GetElementImageRecord()
  self._elementImg:SetSprite(image.assetBundle, image.assetName)
end

return TeamEditSupportRoleCell
