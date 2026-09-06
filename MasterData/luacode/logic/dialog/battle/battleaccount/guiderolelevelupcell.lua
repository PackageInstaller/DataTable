local GuideRoleLevelUpCell = class("GuideRoleLevelUpCell", Dialog)
GuideRoleLevelUpCell.AssetBundleName = "ui/layouts.battlelose"
GuideRoleLevelUpCell.AssetName = "DefeatGuideCharCell"

function GuideRoleLevelUpCell:Ctor(...)
  GuideRoleLevelUpCell.super.Ctor(self, ...)
end

function GuideRoleLevelUpCell:OnCreate()
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
  self._goBtn:Subscribe_PointerClickEvent(self.OnGoBtnClick, self)
end

function GuideRoleLevelUpCell:OnDestroy()
end

function GuideRoleLevelUpCell:RefreshCell(data)
  local breakLv, showLv = data:GetBreakLvAndShowLvByRoleLv(self._delegate._selectGuideType.recommendRoleLevel)
  local str = TextManager.GetText(701095)
  str = string.gsub(str, "%$parameter1%$", breakLv)
  str = string.gsub(str, "%$parameter2%$", showLv)
  self._txt:SetText(str)
  local image = data:GetShapeLittleHeadImageRecord()
  self._photo:SetSprite(image.assetBundle, image.assetName)
  image = data:GetSmallRarityFrameRecord()
  self._frame:SetSprite(image.assetBundle, image.assetName)
  image = data:GetRarityBottomBackRecord()
  self._downRankBack:SetSprite(image.assetBundle, image.assetName)
  self._level:SetText(data:GetShowLv())
  image = data:GetRarityImageRecord()
  self._rank:SetSprite(image.assetBundle, image.assetName)
  image = data:GetVocationImageRecord()
  self._job:SetSprite(image.assetBundle, image.assetName)
  local breakLv = data:GetBreakLv()
  self._breakLevelBackBlack:SetActive(breakLv == 0)
  self._breakLevelBack:SetActive(0 < breakLv)
  self._breakLevelNum:SetActive(0 < breakLv)
  if 0 < breakLv then
    image = data:GetCurBreakFrame1ImageRecord()
    self._breakLevelBack:SetSprite(image.assetBundle, image.assetName)
    self._breakLevelNum:SetText(breakLv)
  end
  image = data:GetElementImageRecord()
  self._element:SetSprite(image.assetBundle, image.assetName)
end

function GuideRoleLevelUpCell:OnGoBtnClick()
  local dialog = DialogManager.CreateSingletonDialog("character.newcharacterinfodialog")
  dialog:Refresh(self._cellData)
  dialog:OnLevelUpPanelClick()
end

function GuideRoleLevelUpCell:OnEvent(eventName, arg)
  if eventName == "RefreshRoleLv" then
    self._charLevel:SetText(self._cellData:GetShowLv())
    self._charBreakLevel:SetText(self._cellData:GetBreakLv())
  end
end

return GuideRoleLevelUpCell
