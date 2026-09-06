local ResolveRoleCell = class("ResolveRoleCell", Dialog)
ResolveRoleCell.AssetBundleName = "ui/layouts.basecharacterinfo"
ResolveRoleCell.AssetName = "BaseCharacterCellSmall"

function ResolveRoleCell:Ctor(...)
  ResolveRoleCell.super.Ctor(self, ...)
end

function ResolveRoleCell:OnCreate()
  self._back = self:GetChild("_Back")
  self._photo = self:GetChild("_CharacterImage")
  self._frame = self:GetChild("Frame")
  self._job = self:GetChild("_Job")
  self._rank = self:GetChild("_Quality")
  self._lvNum = self:GetChild("Level/Num")
  self._lvMaxNum = self:GetChild("Level/MaxNum")
  self._breakLevelBack = self:GetChild("Level/BreakLevelBack")
  self._breakLevel = self:GetChild("Level/BreakLevel")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function ResolveRoleCell:OnDestroy()
end

function ResolveRoleCell:RefreshCell(data)
  local image = data:GetSmallRarityBackRecord()
  self._back:SetSprite(image.assetBundle, image.assetName)
  image = data:GetShapeLittleHeadImageRecord()
  self._photo:SetSprite(image.assetBundle, image.assetName)
  image = data:GetSmallRarityFrameRecord()
  self._frame:SetSprite(image.assetBundle, image.assetName)
  image = data:GetVocationImageRecord()
  self._job:SetSprite(image.assetBundle, image.assetName)
  image = data:GetRarityImageRecord()
  self._rank:SetSprite(image.assetBundle, image.assetName)
  self._lvNum:SetText(data:GetShowLv())
  self._lvMaxNum:SetText(data:GetShowMaxBreakLv())
  local imageRecord = data:GetCurBreakFrame1ImageRecord()
  self._breakLevelBack:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = data:GetCurBreakImageRecord()
  self._breakLevel:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

function ResolveRoleCell:OnCellClicked()
end

return ResolveRoleCell
