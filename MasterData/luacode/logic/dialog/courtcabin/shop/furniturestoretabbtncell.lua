local CDormFurTypeSpecial = BeanManager.GetTableByName("courtyard.cdormfurtypespecial")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local FurnitureStoreTabBtnCell = class("FurnitureStoreTabBtnCell", Dialog)
FurnitureStoreTabBtnCell.AssetBundleName = "ui/layouts.yard"
FurnitureStoreTabBtnCell.AssetName = "FurnitureShopGroupBtn"

function FurnitureStoreTabBtnCell:Ctor(...)
  FurnitureStoreTabBtnCell.super.Ctor(self, ...)
end

function FurnitureStoreTabBtnCell:OnCreate()
  self._btn = self:GetChild("GroupBtn")
  self._txt = self:GetChild("GroupBtn/Text")
  self._btn:Subscribe_PointerClickEvent(self.OnBtnClicked, self)
end

function FurnitureStoreTabBtnCell:OnDestroy()
end

function FurnitureStoreTabBtnCell:RefreshCell(data)
  local recorder
  if data.recorder.id == 0 then
    recorder = CDormFurTypeSpecial:GetRecorder(1)
  else
    recorder = data.recorder
  end
  local imgRecord = CImagePathTable:GetRecorder(recorder.imagenorm)
  self._btn:SetTextImgNormal(imgRecord.assetBundle, imgRecord.assetName)
  imgRecord = CImagePathTable:GetRecorder(recorder.imageselect)
  self._btn:SetTextImgSelected(imgRecord.assetBundle, imgRecord.assetName)
  self._txt:SetText(TextManager.GetText(recorder.nameTextID))
  self._btn:SetSelected(data.recorder.id == self._delegate._selectTabId)
end

function FurnitureStoreTabBtnCell:OnBtnClicked()
  self._delegate:SetSelectTabId(self._cellData.recorder.id)
end

function FurnitureStoreTabBtnCell:OnEvent(eventName, arg)
  if eventName == "SetSelectTabId" then
    self._btn:SetSelected(self._cellData.recorder.id == self._delegate._selectTabId)
  end
end

return FurnitureStoreTabBtnCell
