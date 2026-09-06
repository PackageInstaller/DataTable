local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CNpcShapeTable = BeanManager.GetTableByName("npc.cnpcshape")
local MonthCardDiscountDialog = class("MonthCardDiscountDialog", Dialog)
MonthCardDiscountDialog.AssetBundleName = "ui/layouts.baseshop"
MonthCardDiscountDialog.AssetName = "MonthCardSale"

function MonthCardDiscountDialog:Ctor(...)
  MonthCardDiscountDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
  self._shapID = 1078
end

function MonthCardDiscountDialog:OnCreate()
  self._item = self:GetChild("Back/Item")
  self._sale = self:GetChild("Back/Sale")
  self._price = self:GetChild("Back/Price/Text")
  self._priceDelete = self:GetChild("Back/Price/TextDelete")
  self._time = self:GetChild("Back/Time/Time")
  self._closeBtn = self:GetChild("Back/CloseBtn")
  self._goBtn = self:GetChild("Back/GoBtn")
  self._photo = self:GetChild("Role/Photo")
  self._live2D = self:GetChild("Role/Live2D")
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._goBtn:Subscribe_PointerClickEvent(self.OnGoClicked, self)
  self._shapeRecord = CNpcShapeTable:GetRecorder(self._shapID)
  self._charImageRecord = CImagePathTable:GetRecorder(self._shapeRecord.lihuiID) or DataCommon.DefaultImageAsset
  self._charImageScale = self._shapeRecord.photoScale
  self._charImagePos = self._shapeRecord.photoLocation
  self._charLive2DRecord = nil
  if Live2DManager.CanUse() and self._shapeRecord.live2DPrefabName ~= "" and self._shapeRecord.live2DAssetBundleName ~= "" then
    self._charLive2DRecord = {}
    self._charLive2DRecord.live2DPrefabName = self._shapeRecord.live2DPrefabName
    self._charLive2DRecord.live2DAssetBundleName = self._shapeRecord.live2DAssetBundleName
    self._charLive2DRecord.live2DScale = self._shapeRecord.live2DScale
  end
  if self._handler then
    self._live2D:Release(self._handler)
    self._handler = nil
  end
  if self._charLive2DRecord then
    self._photo:SetActive(false)
    self._handler = self._live2D:AddLive2D(self._charLive2DRecord.live2DAssetBundleName, self._charLive2DRecord.live2DPrefabName, self._charLive2DRecord.live2DScale)
  else
    self._photo:SetActive(true)
    self._photo:SetSprite(self._charImageRecord.assetBundle, self._charImageRecord.assetName)
    self._photo:SetLocalScale(self._charImageScale, self._charImageScale, self._charImageScale)
    self._photo:SetAnchoredPosition(self._charImagePos[1], self._charImagePos[2])
  end
end

function MonthCardDiscountDialog:OnDestroy()
  if self._handler then
    self._live2D:Release(self._handler)
    self._handler = nil
  end
end

function MonthCardDiscountDialog:SetData(data)
  local imageRecord = CImagePathTable:GetRecorder(data.pictureId)
  self._item:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = NekoData.BehaviorManager.BM_Shop:GetDiscountAsset(data.discount)
  self._sale:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._price:SetText(data.discountPrice)
  self._priceDelete:SetText(data.price)
  self._time:SetText(NekoData.BehaviorManager.BM_Shop:GetRemainTimeStrForMonthCard(data.endTime))
end

function MonthCardDiscountDialog:OnBackBtnClicked()
  DialogManager.DestroySingletonDialog("shop.monthcarddiscountdialog")
end

function MonthCardDiscountDialog:OnGoClicked()
  NekoData.BehaviorManager.BM_Shop:TryOpenShopWithID(50)
  self:OnBackBtnClicked()
end

return MonthCardDiscountDialog
