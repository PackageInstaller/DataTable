local Item = require("logic.manager.experimental.types.item")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local DM_RedDot = NekoData.DataManager.DM_RedDot
local ShopGiftCellNew = class("ShopGiftCellNew", Dialog)
ShopGiftCellNew.AssetBundleName = "ui/layouts.baseshop"
ShopGiftCellNew.AssetName = "GiftShopCellNew"

function ShopGiftCellNew:Ctor(...)
  ShopGiftCellNew.super.Ctor(self, ...)
end

function ShopGiftCellNew:OnCreate()
  self._back = self:GetChild("CellBack/Back")
  self._back2 = self:GetChild("CellBack/Back2")
  self._item = self:GetChild("CellBack/Item")
  self._itemName = self:GetChild("CellBack/ItemName")
  self._priceBoard = self:GetChild("CellBack/Price")
  self._priceImg = self:GetChild("CellBack/Price/Image")
  self._priceNum = self:GetChild("CellBack/Price/Text")
  self._priceDelete = self:GetChild("CellBack/Price/TextDelete")
  self._price2Board = self:GetChild("CellBack/Price2")
  self._price2Img = self:GetChild("CellBack/Price2/Image")
  self._price2Num = self:GetChild("CellBack/Price2/Text")
  self._priceFree = self:GetChild("CellBack/PriceFree")
  self._num = self:GetChild("CellBack/Num")
  self._numT = self:GetChild("CellBack/Num/Num")
  self._limit = self:GetChild("CellBack/Limit")
  self._limitT = self:GetChild("CellBack/Limit/Limit")
  self._sale = self:GetChild("CellBack/Sale")
  self._soldOut = self:GetChild("CellBack/SoldOut")
  self._redDot = self:GetChild("CellBack/RedDot")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function ShopGiftCellNew:OnDestroy()
end

function ShopGiftCellNew:RefreshCell(data)
  self._data = data
  self._redDotData = self._data.itemRedDotNodes.childNode
  self._back2:SetActive(self._data.iteminfo.pictureId == 1)
  self._soldOut:SetActive(self._data.iteminfo.goodRemain == 0)
  local noDiscount = self._data.iteminfo.discount == -1 or self._data.iteminfo.discount == 10
  if noDiscount and 0 < self._data.iteminfo.discountPrice then
    self._priceBoard:SetActive(false)
    self._price2Board:SetActive(true)
    self._priceFree:SetActive(false)
    self._sale:SetActive(false)
    self._price2Num:SetText(self._data.iteminfo.discountPrice)
    local imageRecord = Item.Create(data.iteminfo.moneyType):GetIcon()
    self._price2Img:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  elseif noDiscount and self._data.iteminfo.discountPrice == 0 then
    self._priceBoard:SetActive(false)
    self._price2Board:SetActive(false)
    self._priceFree:SetActive(true)
    self._sale:SetActive(false)
  elseif not noDiscount then
    self._priceBoard:SetActive(true)
    self._price2Board:SetActive(false)
    self._priceFree:SetActive(false)
    self._sale:SetActive(true)
    self._priceNum:SetText(self._data.iteminfo.discountPrice)
    self._priceDelete:SetText(self._data.iteminfo.price)
    local imageRecord = Item.Create(data.iteminfo.moneyType):GetIcon()
    self._priceImg:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    imageRecord = NekoData.BehaviorManager.BM_Shop:GetDiscountAsset(self._data.iteminfo.discount)
    self._sale:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    LogErrorFormat("ShopGiftCellNew", "The discount and discountPrice data error! [discount=%d, discountPrice=%d]", self._data.iteminfo.discount, self._data.iteminfo.discountPrice)
  end
  if self._delegate._delegate._selectShopID == 20 then
    self._limit:SetActive(true)
    self._limitT:SetText(TextManager.GetText(CStringRes:GetRecorder(1476).msgTextID))
  elseif self._delegate._delegate._selectShopID == 46 then
    self._limit:SetActive(true)
    self._limitT:SetText(TextManager.GetText(1100091))
  elseif self._data.iteminfo.endTime and 0 < self._data.iteminfo.endTime then
    self._limit:SetActive(true)
    self._limitT:SetText(NekoData.BehaviorManager.BM_Shop:GetRemainTimeStr(self._data.iteminfo.endTime))
  else
    self._limit:SetActive(false)
  end
  self._num:SetActive(self._data.iteminfo.goodRemain ~= -1)
  self._numT:SetText(self._data.iteminfo.goodRemain)
  local item = Item.Create(self._data.iteminfo.goodName)
  local imageRecord = item:GetIcon()
  self._item:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._itemName:SetText(item:GetName())
  self._redDotNode = self._redDotData[tostring(self._data.iteminfo.goodId)]
  self:ShowRedDot()
end

function ShopGiftCellNew:OnCellClicked()
  local dialog = DialogManager.CreateSingletonDialog("shop.itemgiftbuydialog")
  if dialog then
    if self._redDotResult and self._redDotNode then
      DM_RedDot.SetNodeRead(self._redDotNode, true)
      if self._redDotResult ~= DM_RedDot.GetNodeResult(self._redDotNode) then
        LuaNotificationCenter.PostNotification(Common.n_ShopRedPoint, nil, nil)
      end
    end
    dialog:SetData(self._data.iteminfo, self._delegate._delegate._selectShopID)
  end
end

function ShopGiftCellNew:OnEvent(eventName, arg)
  if eventName == "RedPointInfo" then
    self:ShowRedDot()
  end
end

function ShopGiftCellNew:ShowRedDot()
  if self._redDotNode then
    self._redDotResult = DM_RedDot.GetNodeResult(self._redDotNode)
    self._redDot:SetActive(self._redDotResult)
  else
    self._redDot:SetActive(false)
  end
end

return ShopGiftCellNew
