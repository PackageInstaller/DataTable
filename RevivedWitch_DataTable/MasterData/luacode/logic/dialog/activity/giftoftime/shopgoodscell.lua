-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/giftoftime/shopgoodscell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CPackage = (BeanManager.GetTableByName)("recharge.cpackage")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CCurrencySymbol = (BeanManager.GetTableByName)("topup.ccurrencysymbol")
local ShopGoodsCell = class("ShopGoodsCell", Dialog)
ShopGoodsCell.AssetBundleName = "ui/layouts.battlepassnew"
ShopGoodsCell.AssetName = "BattlePassNewShopCell"
local SkinTypeId = 91
ShopGoodsCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ShopGoodsCell
  ((ShopGoodsCell.super).Ctor)(self, ...)
end

ShopGoodsCell.OnCreate = function(self)
  -- function num : 0_1
  self._icon = self:GetChild("CellBack/Item")
  self._name = self:GetChild("CellBack/ItemName")
  self._back = {self:GetChild("CellBack/BackG"), self:GetChild("CellBack/BackR"), self:GetChild("CellBack/BackB")}
  self._price = self:GetChild("CellBack/Price")
  ;
  (self._price):SetActive(false)
  self._rmtImage2 = self:GetChild("CellBack/Price2/Rmt")
  self._price2 = self:GetChild("CellBack/Price2")
  self._price2Img = self:GetChild("CellBack/Price2/Image")
  self._price2Num = self:GetChild("CellBack/Price2/Text")
  self._textRmt = self:GetChild("CellBack/Price2/RmtText")
  self._num = self:GetChild("CellBack/Num/Num")
  self._limit = self:GetChild("CellBack/Limit")
  self._limit_txt = self:GetChild("CellBack/Limit/Limit")
  self._soldOut = self:GetChild("CellBack/SoldOut")
  self._sale = self:GetChild("CellBack/Sale")
  self._redDot = self:GetChild("CellBack/Dot")
  self._itemNameBack = self:GetChild("CellBack/ItemNameBack")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

ShopGoodsCell.OnDestroy = function(self)
  -- function num : 0_2
end

ShopGoodsCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, Item, SkinTypeId, CPackage, CCurrencySymbol, CStringRes
  self._data = data
  self._shopId = (self._delegate)._shopId
  self._state = 1
  for i = 1, 3 do
    ((self._back)[i]):SetActive(false)
  end
  if (self._data).isrmt == 0 then
    self._state = 1
  else
    local isSkin = false
    for _,id in ipairs(((self._data).iteminfo).itemId) do
      local item = (Item.Create)(id)
      isSkin = item:GetItemTypeId() == SkinTypeId
    end
    if isSkin or isSkin then
      self._state = 3
    else
      self._state = 2
    end
  end
  ;
  ((self._back)[self._state]):SetActive(true)
  local imageRecord = nil
  local good = CPackage:GetRecorder(((self._data).iteminfo).goodId)
  local item = (Item.Create)(good.propertyID)
  imageRecord = item:GetIcon()
  ;
  (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._name):SetText(item:GetName())
  if not ((self._data).iteminfo).beginTime or not ((self._data).iteminfo).endTime or ((self._data).iteminfo).beginTime == 0 or ((self._data).iteminfo).endTime == 0 then
    (self._limit):SetActive(false)
  else
    (self._limit):SetActive(true)
    ;
    (self._limit_txt):SetText(((NekoData.BehaviorManager).BM_Shop):GetRemainTimeStr(((self._data).iteminfo).endTime))
  end
  ;
  (self._price2):SetActive(true)
  if (self._data).isrmt == 1 then
    if SdkManager.IsOverseas then
      (self._rmtImage2):SetActive(false)
      ;
      (self._textRmt):SetActive(true)
      ;
      (self._textRmt):SetText((CCurrencySymbol:GetRecorder(((self._data).iteminfo).moneyType)).symbol)
    else
      (self._rmtImage2):SetActive(true)
      ;
      (self._textRmt):SetActive(false)
    end
    ;
    (self._price2Img):SetActive(false)
  else
    (self._rmtImage2):SetActive(false)
    ;
    (self._textRmt):SetActive(false)
    ;
    (self._price2Img):SetActive(true)
    item = (Item.Create)(((self._data).iteminfo).moneyType)
    imageRecord = item:GetIcon()
    ;
    (self._price2Img):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
  ;
  (self._price2Num):SetText((SdkManager.GetPrice)(((self._data).iteminfo).discountPrice))
  if ((self._data).iteminfo).discountPrice == ((self._data).iteminfo).price then
    (self._sale):SetActive(false)
  else
    (self._sale):SetActive(true)
    imageRecord = ((NekoData.BehaviorManager).BM_Shop):GetDiscountAsset(((self._data).iteminfo).discount)
    ;
    (self._sale):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
  if ((self._data).iteminfo).discountPrice == 0 then
    (self._price2Num):SetText((TextManager.GetText)((CStringRes:GetRecorder(1848)).msgTextID))
    ;
    (self._price2Img):SetActive(false)
  end
  if ((self._data).iteminfo).goodRemain == 0 then
    (self._soldOut):SetActive(true)
    ;
    (self._num):SetText(0)
    ;
    (self._price2):SetActive(false)
    ;
    (self._itemNameBack):SetActive(false)
    ;
    (self._redDot):SetActive(false)
  else
    (self._itemNameBack):SetActive(true)
    ;
    (self._soldOut):SetActive(false)
    if ((self._data).iteminfo).goodRemain == -1 then
      (self._num):SetText(tostring(99 .. "+"))
    else
      (self._num):SetText(tostring(((self._data).iteminfo).goodRemain))
    end
    ;
    (self._redDot):SetActive(false)
    if ((self._data).iteminfo).discountPrice == 0 then
      (self._redDot):SetActive(true)
    end
  end
  -- DECOMPILER ERROR: 19 unprocessed JMP targets
end

ShopGoodsCell.OnCellClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if ((self._data).iteminfo).goodRemain ~= 0 then
    local dialog = (DialogManager.CreateSingletonDialog)("activity.giftoftime.shopbuydialog")
    if dialog then
      dialog:SetData((self._data).iteminfo, (self._delegate)._shopId)
    end
  end
end

return ShopGoodsCell

