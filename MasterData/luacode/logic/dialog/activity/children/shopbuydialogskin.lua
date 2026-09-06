local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local UIManager = CS.PixelNeko.UI.UIManager
local ShopBuyDialogSkin = class("ShopBuyDialogSkin", Dialog)
ShopBuyDialogSkin.AssetBundleName = "ui/layouts.activitychildrensday"
ShopBuyDialogSkin.AssetName = "ActivityChildrensDayShopSkin"
local SkinTypeId = 91

function ShopBuyDialogSkin:Ctor(...)
  ShopBuyDialogSkin.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function ShopBuyDialogSkin:OnCreate()
  self._itemBack = self:GetChild("Back/ItemBack")
  self._itemImage = self:GetChild("Back/MonthCardImg")
  self._itemName = self:GetChild("Back/ItemName")
  self._timeText = self:GetChild("Back/Time")
  self._timeImg = self:GetChild("Back/TimeImg")
  self._saleImage = self:GetChild("Back/Sale")
  self._price = self:GetChild("Back/Price")
  self._price:SetActive(true)
  self._priceNum = self:GetChild("Back/Price/Num")
  self._price2 = self:GetChild("Back/Price2")
  self._price2:SetActive(false)
  self._skinPanel = self:GetChild("Back/Frame")
  self._skinFrame = TableFrame.Create(self._skinPanel, self, true, true, true)
  self._itemPanel = self:GetChild("Back/Frame3")
  self._itemFrame = TableFrame.Create(self._itemPanel, self, true, true, true)
  self._buyBtn = self:GetChild("Back/BuyBtn")
  self._buyBtn:Subscribe_PointerClickEvent(self.OnBuyBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnDialogClicked, Common.n_GlobalPointerWillDown, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshShopInfo, Common.n_RefreshShopInfo, nil)
end

function ShopBuyDialogSkin:OnDestroy()
  if self._skinFrame then
    self._skinFrame:Destroy()
  end
  if self._itemFrame then
    self._itemFrame:Destroy()
  end
  LuaNotificationCenter.RemoveObserver(self)
end

function ShopBuyDialogSkin:SetData(iteminfo, shopid)
  self._itemInfo = iteminfo
  self._shopId = shopid
  self._skinId = nil
  self._hasSkin = nil
  self._saleImage:SetActive(false)
  self._itemData = {}
  self._skinData = {}
  for k, v in ipairs(self._itemInfo.itemId) do
    local item = Item.Create(v)
    if item:GetItemTypeId() == SkinTypeId then
      self._skinId = v
      self._hasSkin = NekoData.BehaviorManager.BM_SkinList:IsUnLockSkinByItemId(v)
      table.insert(self._skinData, {
        id = iteminfo.itemId[k],
        count = iteminfo.itemSum[k]
      })
    else
      table.insert(self._itemData, {
        id = iteminfo.itemId[k],
        count = iteminfo.itemSum[k]
      })
    end
  end
  self._skinFrame:ReloadAllCell()
  self._skinFrame:MoveToTop()
  self._itemFrame:ReloadAllCell()
  self._itemFrame:MoveToTop()
  local item = Item.Create(iteminfo.giftId)
  local imageRecord = item:GetIcon()
  self._itemImage:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = item:GetShopBuyBackGroudImg()
  self._itemBack:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._itemName:SetText(item:GetName())
  self._priceNum:SetText(tostring(iteminfo.discountPrice))
  if not (self._itemInfo.beginTime and self._itemInfo.endTime) or self._itemInfo.beginTime == 0 or self._itemInfo.endTime == 0 then
    self._timeText:SetActive(false)
    self._timeImg:SetActive(false)
  else
    self._timeImg:SetActive(true)
    self._timeText:SetActive(true)
    self._timeText:SetText(NekoData.BehaviorManager.BM_Shop:GetRemainTimeStr(self._itemInfo.endTime))
  end
  self._unitPrice = iteminfo.discountPrice
  self._totalMoney = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(iteminfo.moneyType)
  self._canBuyMaxNum = math.floor(self._totalMoney / self._unitPrice)
  if iteminfo.goodRemain ~= -1 then
    self._canBuyMaxNum = math.min(self._canBuyMaxNum, iteminfo.goodRemain)
  end
end

function ShopBuyDialogSkin:OnBuyBtnClicked()
  if self._hasSkin then
    local item = Item.Create(self._skinId)
    local itemList = item:GetResolveItemId()
    local resolveItemNumList = item:GetResolveItemNum()
    local resolveItemNum = 0
    for i, v in ipairs(itemList) do
      if tonumber(v) == DataCommon.DiamodID then
        resolveItemNum = resolveItemNumList[i]
      end
    end
    NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(147, {resolveItemNum}, function()
      local cmd = LuaNetManager.CreateProtocol("protocol.charge.cbuydiamond")
      cmd.goodId = self._itemInfo.goodId
      cmd:Send()
    end, {}, nil, {})
    self:Destroy()
    return
  end
  local cmd = LuaNetManager.CreateProtocol("protocol.charge.cbuydiamond")
  cmd.goodId = self._itemInfo.goodId
  cmd:Send()
end

function ShopBuyDialogSkin:OnDialogClicked(args)
  if not UIManager.RectangleContainsScreenPoint(self:GetRootWindow()._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) then
    self:OnBackBtnClicked()
  end
end

function ShopBuyDialogSkin:OnRefreshShopInfo(notification)
  if notification.userInfo.shopId == self._shopId then
    self:Destroy()
  end
end

function ShopBuyDialogSkin:OnBackBtnClicked()
  if DialogManager.GetDialog("bag.itemtipsdialog") or DialogManager.GetDialog("equip.equiptipspreviewdialog") then
    return
  end
  self:Destroy()
end

function ShopBuyDialogSkin:NumberOfCell(frame)
  if frame == self._skinFrame then
    return #self._skinData
  else
    return #self._itemData
  end
end

function ShopBuyDialogSkin:CellAtIndex(frame, index)
  return "activity.children.shopitembuycell"
end

function ShopBuyDialogSkin:DataAtIndex(frame, index)
  if frame == self._skinFrame then
    return self._skinData[index]
  else
    return self._itemData[index]
  end
end

return ShopBuyDialogSkin
