local UIManager = CS.PixelNeko.UI.UIManager
local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local RoleConfigTable = BeanManager.GetTableByName("role.roleconfig")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CRoleItem = BeanManager.GetTableByName("item.croleitem")
local CNPCShape = BeanManager.GetTableByName("npc.cnpcshape")
local CSugarShopOpen = BeanManager.GetTableByName("recharge.csugarshopopen")
local RoleTypeId = 27
local SkinTypeId = 91
local SkinBuyDialog = class("SkinBuyDialog", Dialog)
SkinBuyDialog.AssetBundleName = "ui/layouts.activityspringouting"
SkinBuyDialog.AssetName = "ActivitySpringOutingShopSkin"

function SkinBuyDialog:Ctor(...)
  SkinBuyDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function SkinBuyDialog:OnCreate()
  self._itemName = self:GetChild("Back/ItemName")
  self._itemIcon = self:GetChild("Back/MonthCardImg")
  self._goodsNum = self:GetChild("Back/Num/Num")
  self._itemBack = self:GetChild("Back/ItemBack")
  self._limit = self:GetChild("Back/TimeImg")
  self._limitTxt = self:GetChild("Back/Time")
  self._saleImage = self:GetChild("Back/Sale")
  self._itemPanel = self:GetChild("Back/Frame3")
  self._itemFrame = TableFrame.Create(self._itemPanel, self, true, true, true)
  self._skinPanel = self:GetChild("Back/Frame")
  self._skinFrame = TableFrame.Create(self._skinPanel, self, true, true, true)
  self._priceOnSale = self:GetChild("Back/Price2")
  self._priceOnSaleOri = self:GetChild("Back/Price2/TextDelete")
  self._priceOnSaleNow = self:GetChild("Back/Price2/Num")
  self._priceNormal = self:GetChild("Back/Price")
  self._priceNormalNow = self:GetChild("Back/Price/Num")
  self._priceFree = self:GetChild("Back/PriceFree")
  self._buyBtn = self:GetChild("Back/BuyBtn")
  self._buyBtn:Subscribe_PointerClickEvent(self.OnBuyBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnDialogClicked, Common.n_GlobalPointerWillDown, nil)
end

function SkinBuyDialog:OnDestroy()
  if self._itemFrame then
    self._itemFrame:Destroy()
  end
  if self._skinFrame then
    self._skinFrame:Destroy()
  end
  LuaNotificationCenter.RemoveObserver(self)
end

function SkinBuyDialog:SetData(data, shopid)
  self._data = data
  self._shopID = shopid
  if self._data.goodRemain == 0 then
    self._goodsNum:SetText(0)
  elseif self._data.goodRemain == -1 then
    self._goodsNum:SetText(tostring(99 .. "+"))
  else
    self._goodsNum:SetText(NumberManager.GetShowNumber(self._data.goodRemain))
  end
  local item
  if type(self._data.itemId) == "table" then
    item = Item.Create(self._data.giftId)
    self._itemName:SetText(TextManager.GetText(self._data.goodName))
    self._itemIcon:SetActive(true)
    local imageRecord = CImagePathTable:GetRecorder(self._data.pictureId)
    self._itemIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    item = Item.Create(CSugarShopOpen:GetRecorder(self._data.goodId).Items)
    self._itemName:SetText(item:GetName())
    local imageRecord = item:GetIcon()
    self._itemIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
  if not (self._data.beginTime and self._data.endTime) or self._data.beginTime == 0 or self._data.endTime == 0 then
    self._limit:SetActive(false)
    self._limitTxt:SetActive(false)
  else
    self._limit:SetActive(true)
    self._limitTxt:SetActive(true)
    self._limitTxt:SetText(NekoData.BehaviorManager.BM_Shop:GetRemainTimeStr(self._data.endTime))
  end
  self._goodType = self._data.moneyType > 35000
  local noDiscount = self._data.discount == -1 or self._data.discount == 10
  if noDiscount and 0 < self._data.discountPrice then
    self._priceOnSale:SetActive(false)
    self._priceNormal:SetActive(true)
    self._priceFree:SetActive(false)
    self._priceNormalNow:SetText(self._data.discountPrice)
    self._saleImage:SetActive(false)
  elseif noDiscount and self._data.discountPrice == 0 then
    self._priceOnSale:SetActive(false)
    self._priceNormal:SetActive(false)
    self._priceFree:SetActive(true)
    self._saleImage:SetActive(false)
  elseif not noDiscount then
    self._priceOnSale:SetActive(true)
    self._priceNormal:SetActive(false)
    self._priceFree:SetActive(false)
    self._priceOnSaleNow:SetText(self._data.discountPrice)
    self._priceOnSaleOri:SetText(self._data.price)
    self._saleImage:SetActive(true)
    local imageRecord = CImagePathTable:GetRecorder(10 - self._data.discount + 11392)
    self._saleImage:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    LogErrorFormat("SkinBuyDialog", "The discount and discountPrice data error! [discount=%d, discountPrice=%d]", self._data.discount, self._data.discountPrice)
  end
  local imageRecord = item:GetShopBuyBackGroudImg()
  self._itemBack:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._skinData = {}
  self._itemData = {}
  for i, v in ipairs(self._data.itemId) do
    local temp = {
      id = v,
      count = self._data.itemSum[i]
    }
    local isSkin = Item.Create(v):GetItemTypeId() == SkinTypeId
    if isSkin then
      table.insert(self._skinData, temp)
    else
      table.insert(self._itemData, temp)
    end
  end
  self._skinFrame:ReloadAllCell()
  self._skinFrame:MoveToTop()
  self._itemFrame:ReloadAllCell()
  self._itemFrame:MoveToTop()
end

function SkinBuyDialog:OnBuyBtnClicked()
  if self._data.moneyType > 35000 then
    local protocol = LuaNetManager.CreateProtocol("protocol.shop.cbuyshopgood")
    if protocol then
      protocol.shopId = self._shopID
      protocol.goods = {
        [self._data.goodId] = 1
      }
      protocol:Send()
    end
  else
    local protocol = LuaNetManager.CreateProtocol("protocol.charge.cbuydiamond")
    if protocol then
      protocol.goodId = self._data.goodId
      protocol:Send()
    end
  end
  self:Destroy()
end

function SkinBuyDialog:OnDialogClicked(args)
  if not UIManager.RectangleContainsScreenPoint(self:GetRootWindow()._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) then
    self:OnBackBtnClicked()
  end
end

function SkinBuyDialog:OnBackBtnClicked()
  if DialogManager.GetDialog("bag.itemtipsdialog") or DialogManager.GetDialog("equip.equiptipspreviewdialog") then
    return
  end
  self:Destroy()
end

function SkinBuyDialog:NumberOfCell(frame)
  if frame == self._itemFrame then
    return #self._itemData
  else
    return #self._skinData
  end
end

function SkinBuyDialog:CellAtIndex(frame, index)
  return "activity.dragonboatfestival.shopitembuycell"
end

function SkinBuyDialog:DataAtIndex(frame, index)
  if frame == self._itemFrame then
    return self._itemData[index]
  else
    return self._skinData[index]
  end
end

return SkinBuyDialog
