local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local UIManager = CS.PixelNeko.UI.UIManager
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CSugarShopOpen = BeanManager.GetTableByName("recharge.csugarshopopen")
local CClownShopRed = BeanManager.GetTableByName("recharge.cclownshopred")
local CClownShopBlue = BeanManager.GetTableByName("recharge.cclownshopblue")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local ShopBuyDialogFree = class("ShopBuyDialogFree", Dialog)
ShopBuyDialogFree.AssetBundleName = "ui/layouts.activityaprilfools"
ShopBuyDialogFree.AssetName = "ActivityAprilFoolsShop6"

function ShopBuyDialogFree:Ctor(...)
  ShopBuyDialogFree.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function ShopBuyDialogFree:OnCreate()
  self._itemBack = self:GetChild("Back/ItemBack")
  self._itemImage = self:GetChild("Back/MonthCardImg")
  self._itemImage_Char = self:GetChild("Back/Char")
  self._itemImage_Char:SetActive(false)
  self._itemName = self:GetChild("Back/ItemName")
  self._timeText = self:GetChild("Back/Time")
  self._timeImg = self:GetChild("Back/TimeImg")
  self._saleImage = self:GetChild("Back/Sale")
  self._saleImage:SetActive(false)
  self._priceFree = self:GetChild("Back/PriceFree")
  self._priceFree:SetActive(true)
  self._priceFreeTxt = self:GetChild("Back/PriceFree/Text")
  self._priceFreeTxt:SetText(TextManager.GetText(CStringRes:GetRecorder(1848).msgTextID))
  self._price = self:GetChild("Back/Price")
  self._price:SetActive(false)
  self._price2 = self:GetChild("Back/Price2")
  self._price2:SetActive(false)
  self._detailTxt = self:GetChild("Back/IncludeBack1/Text")
  self._itemPanel = self:GetChild("Back/Frame")
  self._itemFrame = TableFrame.Create(self._itemPanel, self, true, true, true)
  self._buyBtn = self:GetChild("Back/BuyBtn")
  self._buyBtn:Subscribe_PointerClickEvent(self.OnBuyBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnDialogClicked, Common.n_GlobalPointerWillDown, nil)
  LuaNotificationCenter.AddObserver(self, self.OnBuyShopGood, Common.n_BuyShopGood, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshShopInfo, Common.n_RefreshShopInfo, nil)
end

function ShopBuyDialogFree:OnDestroy()
  self._itemFrame:Destroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function ShopBuyDialogFree:SetData(iteminfo, shopid)
  self._itemInfo = iteminfo
  self._shopId = shopid
  self._itemData = {
    {
      id = iteminfo.itemId,
      count = iteminfo.itemSum
    }
  }
  self._itemFrame:ReloadAllCell()
  self._itemFrame:MoveToTop()
  local good = CSugarShopOpen:GetRecorder(iteminfo.goodId)
  if self._shopId == DataCommon.AprilFoolsDayActivity.Shop.RedClownShopID then
    good = CClownShopRed:GetRecorder(iteminfo.goodId)
  elseif self._shopId == DataCommon.AprilFoolsDayActivity.Shop.BlueClownShopID then
    good = CClownShopBlue:GetRecorder(iteminfo.goodId)
  end
  local item = Item.Create(good.Items)
  local imageRecord = item:GetIcon()
  self._itemImage:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = item:GetShopBuyBackGroudImg()
  self._itemBack:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._itemName:SetText(item:GetName())
  self._detailTxt:SetText(item:GetDestribe())
  if not (self._itemInfo.beginTime and self._itemInfo.endTime) or self._itemInfo.beginTime == 0 or self._itemInfo.endTime == 0 then
    self._timeText:SetActive(false)
    self._timeImg:SetActive(false)
  else
    self._timeImg:SetActive(true)
    self._timeText:SetActive(true)
    self._timeText:SetText(NekoData.BehaviorManager.BM_Shop:GetRemainTimeStr(self._itemInfo.endTime))
  end
  self._totalMoney = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(iteminfo.moneyType)
  self._canBuyMaxNum = 1
  if iteminfo.discountPrice ~= 0 then
    self._canBuyMaxNum = math.floor(self._totalMoney / iteminfo.discountPrice)
  end
  if iteminfo.goodRemain ~= -1 then
    self._canBuyMaxNum = math.min(self._canBuyMaxNum, iteminfo.goodRemain)
  end
end

function ShopBuyDialogFree:OnBuyBtnClicked()
  if self._canBuyMaxNum == 0 then
    if self._itemInfo.moneyType == DataCommon.DiamodID then
      NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(15, nil, function()
        NekoData.BehaviorManager.BM_Shop:TryOpenShopWithID(4)
      end, {}, nil, {})
      self:Destroy()
      return
    elseif self._itemInfo.moneyType == DataCommon.SoulDropID then
      NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(108, nil, function()
        NekoData.BehaviorManager.BM_Shop:TryOpenShopWithID(19)
      end, {}, nil, {})
      self:Destroy()
      return
    end
    NekoData.BehaviorManager.BM_Message:SendMessageById(100032, {
      Item.Create(self._itemInfo.moneyType):GetName()
    })
    self:Destroy()
    return
  end
  local protocol = LuaNetManager.CreateProtocol("protocol.shop.cbuyshopgood")
  if protocol then
    protocol.shopId = self._shopId
    local map = {}
    map[self._itemInfo.goodId] = 1
    protocol.goods = map
    protocol:Send()
  end
end

function ShopBuyDialogFree:OnDialogClicked(args)
  if not UIManager.RectangleContainsScreenPoint(self:GetRootWindow()._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) then
    self:OnBackBtnClicked()
  end
end

function ShopBuyDialogFree:OnBuyShopGood(notification)
  if notification.userInfo.shopId == self._shopId then
    for _, v in ipairs(notification.userInfo.refresh) do
      if self._itemInfo.goodId == v.goodId then
        self:Destroy()
      end
    end
  end
end

function ShopBuyDialogFree:OnRefreshShopInfo(notification)
  if notification.userInfo.shopId == self._shopId then
    self:Destroy()
  end
end

function ShopBuyDialogFree:OnBackBtnClicked()
  if DialogManager.GetDialog("bag.itemtipsdialog") or DialogManager.GetDialog("equip.equiptipspreviewdialog") then
    return
  end
  self:Destroy()
end

function ShopBuyDialogFree:NumberOfCell(frame)
  return #self._itemData
end

function ShopBuyDialogFree:CellAtIndex(frame, index)
  return "activity.aprilfoolsday.shopitembuycell"
end

function ShopBuyDialogFree:DataAtIndex(frame, index)
  return self._itemData[index]
end

return ShopBuyDialogFree
