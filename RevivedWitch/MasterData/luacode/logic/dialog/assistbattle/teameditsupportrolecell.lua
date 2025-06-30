-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/assistbattle/teameditsupportrolecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CSkillItemTable = (BeanManager.GetTableByName)("item.cskillitem")
local TeamEditSupportRoleCell = class("TeamEditSupportRoleCell", Dialog)
TeamEditSupportRoleCell.AssetBundleName = "ui/layouts.friends"
TeamEditSupportRoleCell.AssetName = "CharacterCellLargeSupport"
TeamEditSupportRoleCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TeamEditSupportRoleCell
  ((TeamEditSupportRoleCell.super).Ctor)(self, ...)
end

TeamEditSupportRoleCell.OnCreate = function(self)
  -- function num : 0_1
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

TeamEditSupportRoleCell.OnDestroy = function(self)
  -- function num : 0_2
end

TeamEditSupportRoleCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  local image = data:GetShapeBigBustImageRecord()
  ;
  (self._photo):SetSprite(image.assetBundle, image.assetName)
  image = data:GetTeamRarityBackRecord()
  ;
  (self._back):SetSprite(image.assetBundle, image.assetName)
  if data:GetId() == DataCommon.LeaderId then
    (self._rank):SetActive(false)
    ;
    (self._rankDownBackBottom):SetActive(false)
  else
    ;
    (self._rank):SetActive(true)
    image = data:GetTeamRarityImageRecord()
    ;
    (self._rank):SetSprite(image.assetBundle, image.assetName)
    image = data:GetRarityRankDownRecord()
    ;
    (self._rankDownBackBottom):SetSprite(image.assetBundle, image.assetName)
  end
  ;
  (self._lvNum):SetText(data:GetShowLv())
  ;
  (self._lvMaxNum):SetText(data:GetShowMaxBreakLv())
  ;
  (self._lvMaxNum):SetText(data:GetShowMaxBreakLv())
  local breakLv = data:GetBreakLv()
  ;
  (self._breakLevelBackBlack):SetActive(breakLv == 0)
  ;
  (self._breakLevelBack):SetActive(breakLv > 0)
  ;
  (self._breakLevel):SetActive(breakLv > 0)
  do
    if breakLv > 0 then
      local imageRecord = data:GetCurBreakFrame1ImageRecord()
      ;
      (self._breakLevelBack):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      ;
      (self._breakLevel):SetText(breakLv)
    end
    image = data:GetVocationImageRecord()
    ;
    (self._job):SetSprite(image.assetBundle, image.assetName)
    image = data:GetElementImageRecord()
    ;
    (self._elementImg):SetSprite(image.assetBundle, image.assetName)
    -- DECOMPILER ERROR: 4 unprocessed JMP targets
  end
end

return TeamEditSupportRoleCell

