local UIManager = CS.PixelNeko.UI.UIManager
local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CheckOtherRoleInfoDialog = require("logic.dialog.mainline.bossrush.checkotherroleinfodialog")
local CRoleItem = BeanManager.GetTableByName("item.croleitem")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CSugarShopOpen = BeanManager.GetTableByName("recharge.csugarshopopen")
local ShopBuyDialog = class("ShopBuyDialog", Dialog)
ShopBuyDialog.AssetBundleName = "ui/layouts.baseshop"
ShopBuyDialog.AssetName = "ItemPackBuy"

function ShopBuyDialog:Ctor(...)
  ShopBuyDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function ShopBuyDialog:OnCreate()
  self._itemImage = self:GetChild("Back/MonthCardImg")
  self._itemName = self:GetChild("Back/ItemName")
  self._itemDetail = self:GetChild("Back/ItemDetail")
  self._timeText = self:GetChild("Back/Time")
  self._timeImage = self:GetChild("Back/TimeImg")
  self._saleImage = self:GetChild("Back/Sale")
  self._leftNum = self:GetChild("Back/Num/Num")
  self._leftBoard = self:GetChild("Back/Num")
  self._priceTypeImage = self:GetChild("Back/Price/Image")
  self._priceTypeText = self:GetChild("Back/Price/RMB")
  self._priceNum = self:GetChild("Back/Price/Num")
  self._buyDetail = self:GetChild("Back/DetailFrame")
  self._cellFrame = TableFrame.Create(self._buyDetail, self, true, true, true)
  self._cellFrame:SetMargin(30, 0)
  self._buyBtn = self:GetChild("Back/BuyBtn")
  self._buyBtn:Subscribe_PointerClickEvent(self.OnBuyBtnClicked, self)
  self._roleBtn = self:GetChild("Back/DetailBtn")
  self._roleBtn:Subscribe_PointerClickEvent(self.OnRoleBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnDialogClicked, Common.n_GlobalPointerWillDown, nil)
end

function ShopBuyDialog:OnDestroy()
  self._cellFrame:Destroy()
end

function ShopBuyDialog:SetData(iteminfo, shopid)
  self._itemInfo = iteminfo
  self._shopID = shopid
  local good = CSugarShopOpen:GetRecorder(self._itemInfo.goodId)
  local item = Item.Create(good.Items)
  local imageRecord = item:GetIcon()
  self._itemImage:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._itemName:SetText(item:GetName())
  self._itemDetail:SetText(tostring(item:GetDestribe()))
  if iteminfo.discount == 0 then
    self._saleImage:SetActive(false)
  elseif iteminfo.discount == -1 then
    self._saleImage:SetActive(false)
  else
    self._saleImage:SetActive(true)
    imageRecord = NekoData.BehaviorManager.BM_Shop:GetDiscountAsset(iteminfo.discount)
    self._saleImage:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
  if iteminfo.moneyType > 10000 then
    item = Item.Create(iteminfo.moneyType)
    imageRecord = item:GetIcon()
    self._priceTypeImage:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    self._priceTypeImage:SetActive(true)
    self._priceTypeText:SetActive(false)
  else
    self._priceTypeImage:SetActive(false)
    self._priceTypeText:SetActive(iteminfo.moneyType == 1)
  end
  if not (self._itemInfo.beginTime and self._itemInfo.endTime) or self._itemInfo.beginTime == 0 or self._itemInfo.endTime == 0 then
    self._timeText:SetActive(false)
    self._timeImage:SetActive(false)
  else
    self._timeImage:SetActive(true)
    self._timeText:SetActive(true)
    self._timeText:SetText(NekoData.BehaviorManager.BM_Shop:GetRemainTimeStr(self._itemInfo.endTime))
  end
  self._priceNum:SetText(tostring(iteminfo.discountPrice))
  if iteminfo.goodRemain == 0 then
    self._leftNum:SetText(0)
  elseif iteminfo.goodRemain == -1 then
    self._leftNum:SetText(99 .. "+")
  else
    self._leftNum:SetText(tostring(iteminfo.goodRemain))
  end
  self._roleBtn:SetActive(false)
  self._cellFrame:ReloadAllCell()
  self._cellFrame:MoveToTop()
end

function ShopBuyDialog:NumberOfCell(frame)
  return #self._itemInfo.itemId
end

function ShopBuyDialog:CellAtIndex(frame, index)
  return "shop.dailygiftbuycell"
end

function ShopBuyDialog:DataAtIndex(frame, index)
  local data = {}
  data.id = self._itemInfo.itemId[index]
  data.count = self._itemInfo.itemSum[index]
  return data
end

function ShopBuyDialog:OnBuyBtnClicked()
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

function ShopBuyDialog:OnRoleBtnClicked()
  local roleIdList = {}
  for _, v in pairs(self._itemInfo.itemId) do
    if CRoleItem:GetRecorder(v) then
      table.insert(roleIdList, CRoleItem:GetRecorder(v).roleid)
    end
  end
  local cfgIdList = {2}
  local index = 1
  DialogManager.CreateSingletonDialog("mainline.bossrush.checkotherroleinfodialog"):Init({
    roleIdList = roleIdList,
    cfgIdList = cfgIdList,
    index = index
  }, CheckOtherRoleInfoDialog.ShowType.BaseLevelInfo)
  self:Destroy()
end

function ShopBuyDialog:OnDialogClicked(args)
  if not UIManager.RectangleContainsScreenPoint(self:GetRootWindow()._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) then
    self:OnBackBtnClicked()
  end
end

function ShopBuyDialog:OnBackBtnClicked()
  if DialogManager.GetDialog("bag.itemtipsdialog") then
    return
  end
  self:Destroy()
end

return ShopBuyDialog
