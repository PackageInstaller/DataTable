-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/battle/battleaccount/guiderolelevelupcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GuideRoleLevelUpCell = class("GuideRoleLevelUpCell", Dialog)
GuideRoleLevelUpCell.AssetBundleName = "ui/layouts.battlelose"
GuideRoleLevelUpCell.AssetName = "DefeatGuideCharCell"
GuideRoleLevelUpCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GuideRoleLevelUpCell
  ((GuideRoleLevelUpCell.super).Ctor)(self, ...)
end

GuideRoleLevelUpCell.OnCreate = function(self)
  -- function num : 0_1
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
  self._txt = self:GetChild("Txt")
  self._goBtn = self:GetChild("GoBtn")
  ;
  (self._goBtn):Subscribe_PointerClickEvent(self.OnGoBtnClick, self)
end

GuideRoleLevelUpCell.OnDestroy = function(self)
  -- function num : 0_2
end

GuideRoleLevelUpCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  local breakLv, showLv = data:GetBreakLvAndShowLvByRoleLv(((self._delegate)._selectGuideType).recommendRoleLevel)
  local str = (TextManager.GetText)(701095)
  str = (string.gsub)(str, "%$parameter1%$", breakLv)
  str = (string.gsub)(str, "%$parameter2%$", showLv)
  ;
  (self._txt):SetText(str)
  local image = data:GetShapeLittleHeadImageRecord()
  ;
  (self._photo):SetSprite(image.assetBundle, image.assetName)
  image = data:GetSmallRarityFrameRecord()
  ;
  (self._frame):SetSprite(image.assetBundle, image.assetName)
  image = data:GetRarityBottomBackRecord()
  ;
  (self._downRankBack):SetSprite(image.assetBundle, image.assetName)
  ;
  (self._level):SetText(data:GetShowLv())
  image = data:GetRarityImageRecord()
  ;
  (self._rank):SetSprite(image.assetBundle, image.assetName)
  image = data:GetVocationImageRecord()
  ;
  (self._job):SetSprite(image.assetBundle, image.assetName)
  local breakLv = data:GetBreakLv()
  ;
  (self._breakLevelBackBlack):SetActive(breakLv == 0)
  ;
  (self._breakLevelBack):SetActive(breakLv > 0)
  ;
  (self._breakLevelNum):SetActive(breakLv > 0)
  if breakLv > 0 then
    image = data:GetCurBreakFrame1ImageRecord()
    ;
    (self._breakLevelBack):SetSprite(image.assetBundle, image.assetName)
    ;
    (self._breakLevelNum):SetText(breakLv)
  end
  image = data:GetElementImageRecord()
  ;
  (self._element):SetSprite(image.assetBundle, image.assetName)
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

GuideRoleLevelUpCell.OnGoBtnClick = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("character.newcharacterinfodialog")
  dialog:Refresh(self._cellData)
  dialog:OnLevelUpPanelClick()
end

GuideRoleLevelUpCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_5
  if eventName == "RefreshRoleLv" then
    (self._charLevel):SetText((self._cellData):GetShowLv())
    ;
    (self._charBreakLevel):SetText((self._cellData):GetBreakLv())
  end
end

return GuideRoleLevelUpCell

