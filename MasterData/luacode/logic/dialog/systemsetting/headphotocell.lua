local HeadPhotoTable = BeanManager.GetTableByName("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = BeanManager.GetTableByName("headphoto.cheadphotoframeconfig")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local HeadPhotoCell = class("HeadPhotoCell", Dialog)
HeadPhotoCell.AssetBundleName = "ui/layouts.setting"
HeadPhotoCell.AssetName = "SettingPhotoCell"

function HeadPhotoCell:Ctor(...)
  HeadPhotoCell.super.Ctor(self, ...)
end

function HeadPhotoCell:OnCreate()
  self._photo = self:GetChild("HeadPhotoBack/Photo")
  self._frame = self:GetChild("HeadPhotoBack/Frame")
  self._select = self:GetChild("HeadPhotoBack/Select")
  self._grey = self:GetChild("HeadPhotoBack/Grey")
  self._lock = self:GetChild("HeadPhotoBack/Lock")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function HeadPhotoCell:OnDestroy()
end

function HeadPhotoCell:RefreshCell(data)
  if self._delegate._tag == "HeadPhoto" then
    local headPhotoRecord = HeadPhotoTable:GetRecorder(data.id)
    local imageRecord = CImagePathTable:GetRecorder(headPhotoRecord.photoid) or DataCommon.DefaultImageAsset
    self._photo:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(self._delegate._selectedHeadFrame.id)
    imageRecord = CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) or DataCommon.DefaultImageAsset
    self._frame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    if data.id == self._delegate._selectedHeadPhoto.id then
      self._select:SetActive(true)
    else
      self._select:SetActive(false)
    end
  end
  if self._delegate._tag == "HeadFrame" then
    local headPhotoRecord = HeadPhotoTable:GetRecorder(self._delegate._selectedHeadPhoto.id)
    local imageRecord = CImagePathTable:GetRecorder(headPhotoRecord.photoid) or DataCommon.DefaultImageAsset
    self._photo:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(data.id)
    imageRecord = CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) or DataCommon.DefaultImageAsset
    self._frame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    if data.id == self._delegate._selectedHeadFrame.id then
      self._select:SetActive(true)
    else
      self._select:SetActive(false)
    end
  end
  self._lock:SetActive(data.lock)
  self._grey:SetActive(data.lock)
end

function HeadPhotoCell:OnCellClicked()
  self._delegate:SetSelectedId(self._cellData)
end

function HeadPhotoCell:OnEvent(eventName, arg)
  if eventName == "ChangedSelected" then
    self._select:SetActive(arg.id == self._cellData.id)
  end
end

return HeadPhotoCell
