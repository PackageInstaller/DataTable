local UIManager = CS.PixelNeko.UI.UIManager
local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local ItemBuy2Dialog = class("ItemBuy2Dialog", Dialog)
ItemBuy2Dialog.AssetBundleName = "ui/layouts.baseshop"
ItemBuy2Dialog.AssetName = "ItemBuy2"

function ItemBuy2Dialog:Ctor(...)
  ItemBuy2Dialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function ItemBuy2Dialog:OnCreate()
  self._itemImage = self:GetChild("Back/MonthCardImg")
  self._itemName = self:GetChild("Back/ItemName")
  self._priceTypeImage = self:GetChild("Back/Price/Image")
  self._priceNum = self:GetChild("Back/Price/Num")
  self._priceAllTypeImage = self:GetChild("Back/PriceAll/Image")
  self._priceAllNum = self:GetChild("Back/PriceAll/Num")
  self._buyDetail = self:GetChild("Back/Frame")
  self._buyBtn = self:GetChild("Back/BuyBtn")
  self._cellFrame = TableFrame.Create(self._buyDetail, self, true, true, true)
  self._cellFrame:SetMargin(30, 0)
  self._buyBtn:Subscribe_PointerClickEvent(self.OnBuyBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnDialogClicked, Common.n_GlobalPointerWillDown, nil)
end

function ItemBuy2Dialog:OnDestroy()
  self._cellFrame:Destroy()
end

function ItemBuy2Dialog:SetData(iteminfo, shopid)
  self._itemInfo = iteminfo
  self._shopID = shopid
  local imageRecord = CImagePathTable:GetRecorder(self._itemInfo.pictureId)
  self._itemImage:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._itemName:SetText(TextManager.GetText(self._itemInfo.goodName))
  if self._itemInfo.moneyType > 10000 then
    local item = Item.Create(self._itemInfo.moneyType)
    imageRecord = item:GetIcon()
    self._priceTypeImage:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    self._priceTypeImage:SetActive(true)
    self._priceAllTypeImage:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    self._priceAllTypeImage:SetActive(true)
  else
    self._priceTypeImage:SetActive(false)
    self._priceAllTypeImage:SetActive(false)
  end
  self._priceNum:SetText(self._itemInfo.discountPrice)
  self._priceAllNum:SetText(self._itemInfo.discountPrice)
  self._cellFrame:ReloadAllCell()
  self._cellFrame:MoveToTop()
end

function ItemBuy2Dialog:NumberOfCell(frame)
  if self._itemInfo.itemSum[2] > 0 then
    return #self._itemInfo.itemId
  end
  return 1
end

function ItemBuy2Dialog:CellAtIndex(frame, index)
  return "shop.dailygiftbuycell"
end

function ItemBuy2Dialog:DataAtIndex(frame, index)
  return {
    id = self._itemInfo.itemId[index],
    count = self._itemInfo.itemSum[index]
  }
end

function ItemBuy2Dialog:OnBuyBtnClicked()
  local hasDiamond = NekoData.BehaviorManager.BM_Currency:GetDiamond()
  if hasDiamond >= self._itemInfo.discountPrice then
    local protocol = LuaNetManager.CreateProtocol("protocol.shop.cbuyshopgood")
    if protocol then
      protocol.shopId = self._shopID
      protocol.goods = {
        [self._itemInfo.goodId] = 1
      }
      protocol:Send()
    end
  else
    NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(15, nil, function()
      NekoData.BehaviorManager.BM_Shop:TryOpenShopWithID(4)
    end, {}, nil, {})
  end
  self:Destroy()
end

function ItemBuy2Dialog:OnDialogClicked(args)
  if not UIManager.RectangleContainsScreenPoint(self:GetRootWindow()._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) then
    self:OnBackBtnClicked()
  end
end

function ItemBuy2Dialog:OnBackBtnClicked()
  if DialogManager.GetDialog("bag.itemtipsdialog") then
    return
  end
  self:Destroy()
end

return ItemBuy2Dialog
