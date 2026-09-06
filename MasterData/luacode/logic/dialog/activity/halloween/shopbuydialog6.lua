local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local UIManager = CS.PixelNeko.UI.UIManager
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CRoleItem = BeanManager.GetTableByName("item.croleitem")
local CNPCShape = BeanManager.GetTableByName("npc.cnpcshape")
local RoleConfigTable = BeanManager.GetTableByName("role.roleconfig")
local CSugarShopOpen = BeanManager.GetTableByName("recharge.csugarshopopen")
local ShopBuyDialog6 = class("ShopBuyDialog6", Dialog)
ShopBuyDialog6.AssetBundleName = "ui/layouts.activityhalloween"
ShopBuyDialog6.AssetName = "ActivityHalloweenShop6"

function ShopBuyDialog6:Ctor(...)
  ShopBuyDialog6.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function ShopBuyDialog6:OnCreate()
  self._itemBack = self:GetChild("Back/ItemBack")
  self._itemImage = self:GetChild("Back/MonthCardImg")
  self._itemImage_Char = self:GetChild("Back/Char")
  self._itemName = self:GetChild("Back/ItemName")
  self._timeText = self:GetChild("Back/Time")
  self._timeImg = self:GetChild("Back/TimeImg")
  self._saleImage = self:GetChild("Back/Sale")
  self._price = self:GetChild("Back/Price")
  self._price:SetActive(true)
  self._priceNum = self:GetChild("Back/Price/Num")
  self._price2 = self:GetChild("Back/Price2")
  self._price2:SetActive(false)
  self._itemPanel = self:GetChild("Back/Frame")
  self._itemFrame = TableFrame.Create(self._itemPanel, self, true, true, true)
  self._desText = self:GetChild("Back/IncludeBack1/Text")
  self._buyBtn = self:GetChild("Back/BuyBtn")
  self._buyBtn:Subscribe_PointerClickEvent(self.OnBuyBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnDialogClicked, Common.n_GlobalPointerWillDown, nil)
end

function ShopBuyDialog6:OnDestroy()
  self._itemFrame:Destroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function ShopBuyDialog6:SetData(iteminfo, shopid)
  self._itemInfo = iteminfo
  self._shopId = shopid
  self._saleImage:SetActive(false)
  self._itemData = {}
  for id, _ in ipairs(iteminfo.itemId) do
    table.insert(self._itemData, {
      id = iteminfo.itemId[id],
      count = iteminfo.itemSum[id]
    })
  end
  self._itemFrame:ReloadAllCell()
  self._itemFrame:MoveToTop()
  local item = Item.Create(iteminfo.giftId)
  self._desText:SetText(item:GetDestribe())
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

function ShopBuyDialog6:OnBuyBtnClicked()
  local cmd = LuaNetManager.CreateProtocol("protocol.charge.cbuydiamond")
  cmd.goodId = self._itemInfo.goodId
  cmd:Send()
end

function ShopBuyDialog6:OnDialogClicked(args)
  if not UIManager.RectangleContainsScreenPoint(self:GetRootWindow()._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) then
    self:OnBackBtnClicked()
  end
end

function ShopBuyDialog6:OnBackBtnClicked()
  if DialogManager.GetDialog("bag.itemtipsdialog") or DialogManager.GetDialog("equip.equiptipspreviewdialog") then
    return
  end
  self:Destroy()
end

function ShopBuyDialog6:NumberOfCell(frame)
  return #self._itemData
end

function ShopBuyDialog6:CellAtIndex(frame, index)
  return "activity.halloween.shopitembuycell"
end

function ShopBuyDialog6:DataAtIndex(frame, index)
  return self._itemData[index]
end

return ShopBuyDialog6
