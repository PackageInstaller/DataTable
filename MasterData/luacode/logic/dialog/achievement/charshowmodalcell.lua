local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CAchievementBagConfig = BeanManager.GetTableByName("mission.cachievebadgeconfig")
local CharShowModalCell = class("CharShowModalCell", Dialog)
CharShowModalCell.AssetBundleName = "ui/layouts.basetasklist"
CharShowModalCell.AssetName = "AchievementMedalCell"

function CharShowModalCell:Ctor(...)
  CharShowModalCell.super.Ctor(self, ...)
end

function CharShowModalCell:OnCreate()
  self._img = self:GetChild("Medal")
  self._emptyImg = self:GetChild("back")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function CharShowModalCell:OnDestroy()
end

function CharShowModalCell:RefreshCell(data)
  self._id = data.id
  self._emptyImg:SetActive(data.id == -1)
  self._img:SetActive(data.id ~= -1)
  if data.id ~= -1 then
    local record = CAchievementBagConfig:GetRecorder(data.id)
    if record then
      local imageRecord = CImagePathTable:GetRecorder(record.imageID) or DataCommon.DefaultImageAsset
      self._img:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    end
  end
end

function CharShowModalCell:OnCellClicked()
  if self._delegate.OnCellClick then
    self._delegate:OnCellClick(self._id)
  end
end

return CharShowModalCell
