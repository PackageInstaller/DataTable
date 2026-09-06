local CImageTable = BeanManager.GetTableByName("ui.cimagepath")
local CharacterJobCell = class("CharacterJobCell", Dialog)
CharacterJobCell.AssetBundleName = "ui/layouts.basecharacterinfo"
CharacterJobCell.AssetName = "JobDetailCell"

function CharacterJobCell:Ctor(...)
  CharacterJobCell.super.Ctor(self, ...)
end

function CharacterJobCell:OnCreate()
  self._jobImg = self:GetChild("Job")
  self._jobTxt = self:GetChild("JobTxt")
  self._detail = self:GetChild("JobDetail")
end

function CharacterJobCell:OnDestroy()
end

function CharacterJobCell:RefreshCell(data)
  local ImageRecord = CImageTable:GetRecorder(data.imageId) or DataCommon.DefaultImageAsset
  self._jobImg:SetSprite(ImageRecord.assetBundle, ImageRecord.assetName)
  self._jobTxt:SetText(data.text)
  self._detail:SetText(data.detail)
end

return CharacterJobCell
