-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/shop/monthcarddiscountdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CNpcShapeTable = (BeanManager.GetTableByName)("npc.cnpcshape")
local MonthCardDiscountDialog = class("MonthCardDiscountDialog", Dialog)
MonthCardDiscountDialog.AssetBundleName = "ui/layouts.baseshop"
MonthCardDiscountDialog.AssetName = "MonthCardSale"
MonthCardDiscountDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MonthCardDiscountDialog
  ((MonthCardDiscountDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
  self._shapID = 1078
end

MonthCardDiscountDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : CNpcShapeTable, CImagePathTable, _ENV
  self._item = self:GetChild("Back/Item")
  self._sale = self:GetChild("Back/Sale")
  self._price = self:GetChild("Back/Price/Text")
  self._priceDelete = self:GetChild("Back/Price/TextDelete")
  self._time = self:GetChild("Back/Time/Time")
  self._closeBtn = self:GetChild("Back/CloseBtn")
  self._goBtn = self:GetChild("Back/GoBtn")
  self._photo = self:GetChild("Role/Photo")
  self._live2D = self:GetChild("Role/Live2D")
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._goBtn):Subscribe_PointerClickEvent(self.OnGoClicked, self)
  self._shapeRecord = CNpcShapeTable:GetRecorder(self._shapID)
  if not CImagePathTable:GetRecorder((self._shapeRecord).lihuiID) then
    self._charImageRecord = DataCommon.DefaultImageAsset
    self._charImageScale = (self._shapeRecord).photoScale
    self._charImagePos = (self._shapeRecord).photoLocation
    self._charLive2DRecord = nil
    if (Live2DManager.CanUse)() and (self._shapeRecord).live2DPrefabName ~= "" and (self._shapeRecord).live2DAssetBundleName ~= "" then
      self._charLive2DRecord = {}
      -- DECOMPILER ERROR at PC86: Confused about usage of register: R1 in 'UnsetPending'

      ;
      (self._charLive2DRecord).live2DPrefabName = (self._shapeRecord).live2DPrefabName
      -- DECOMPILER ERROR at PC90: Confused about usage of register: R1 in 'UnsetPending'

      ;
      (self._charLive2DRecord).live2DAssetBundleName = (self._shapeRecord).live2DAssetBundleName
      -- DECOMPILER ERROR at PC94: Confused about usage of register: R1 in 'UnsetPending'

      ;
      (self._charLive2DRecord).live2DScale = (self._shapeRecord).live2DScale
    end
    if self._handler then
      (self._live2D):Release(self._handler)
      self._handler = nil
    end
    if self._charLive2DRecord then
      (self._photo):SetActive(false)
      self._handler = (self._live2D):AddLive2D((self._charLive2DRecord).live2DAssetBundleName, (self._charLive2DRecord).live2DPrefabName, (self._charLive2DRecord).live2DScale)
    else
      ;
      (self._photo):SetActive(true)
      ;
      (self._photo):SetSprite((self._charImageRecord).assetBundle, (self._charImageRecord).assetName)
      ;
      (self._photo):SetLocalScale(self._charImageScale, self._charImageScale, self._charImageScale)
      ;
      (self._photo):SetAnchoredPosition((self._charImagePos)[1], (self._charImagePos)[2])
    end
  end
end

MonthCardDiscountDialog.OnDestroy = function(self)
  -- function num : 0_2
  if self._handler then
    (self._live2D):Release(self._handler)
    self._handler = nil
  end
end

MonthCardDiscountDialog.SetData = function(self, data)
  -- function num : 0_3 , upvalues : CImagePathTable, _ENV
  local imageRecord = CImagePathTable:GetRecorder(data.pictureId)
  ;
  (self._item):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = ((NekoData.BehaviorManager).BM_Shop):GetDiscountAsset(data.discount)
  ;
  (self._sale):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._price):SetText(data.discountPrice)
  ;
  (self._priceDelete):SetText(data.price)
  ;
  (self._time):SetText(((NekoData.BehaviorManager).BM_Shop):GetRemainTimeStrForMonthCard(data.endTime))
end

MonthCardDiscountDialog.OnBackBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("shop.monthcarddiscountdialog")
end

MonthCardDiscountDialog.OnGoClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Shop):TryOpenShopWithID(50)
  self:OnBackBtnClicked()
end

return MonthCardDiscountDialog

