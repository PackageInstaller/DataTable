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
local ItemBuyDialog = class("ItemBuyDialog", Dialog)
ItemBuyDialog.AssetBundleName = "ui/layouts.activityspringouting"
ItemBuyDialog.AssetName = "ActivitySpringOutingShop6"

function ItemBuyDialog:Ctor(...)
  ItemBuyDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function ItemBuyDialog:OnCreate()
  self._itemName = self:GetChild("Back/ItemName")
  self._itemIcon = self:GetChild("Back/MonthCardImg")
  self._charIcon = self:GetChild("Back/Char")
  self._goodsNum = self:GetChild("Back/Num/Num")
  self._itemBack = self:GetChild("Back/ItemBack")
  self._itemDetail = self:GetChild("Back/IncludeBack1/Text")
  self._width, self._height = self._itemDetail:GetRectSize()
  local _ = 0
  _, self._oneline = self._itemDetail:GetPreferredSize()
  self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y = self._itemDetail:GetSize()
  self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y = self._itemDetail:GetPosition()
  self._limit = self:GetChild("Back/TimeImg")
  self._limitTxt = self:GetChild("Back/Time")
  self._saleImage = self:GetChild("Back/Sale")
  self._itemPanel = self:GetChild("Back/Frame")
  self._itemFrame = TableFrame.Create(self._itemPanel, self, true, true, true)
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

function ItemBuyDialog:OnDestroy()
  if self._itemFrame then
    self._itemFrame:Destroy()
  end
  LuaNotificationCenter.RemoveObserver(self)
end

function ItemBuyDialog:SetData(data, shopid)
  self._data = data
  self._shopID = shopid
  self._dm = NekoData.DataManager.DM_Activity:GetManager(DataCommon.DragonBoatFestivalActivityManagerID)
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.DragonBoatFestivalActivityManagerID)
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
    self._charIcon:SetActive(false)
    self._itemIcon:SetActive(true)
    local imageRecord = CImagePathTable:GetRecorder(self._data.pictureId)
    self._itemIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    item = Item.Create(CSugarShopOpen:GetRecorder(self._data.goodId).Items)
    self._itemName:SetText(item:GetName())
    local isRole = item:GetItemTypeId() == RoleTypeId
    self._charIcon:SetActive(isRole)
    self._itemIcon:SetActive(not isRole)
    if isRole then
      local roleid = CRoleItem:GetRecorder(self._data.itemId).roleid
      local roleRecorder = RoleConfigTable:GetRecorder(roleid)
      local npcshaperecord = CNPCShape:GetRecorder(roleRecorder.shapeID)
      local imageRecord = CImagePathTable:GetRecorder(npcshaperecord.skillHeadID)
      self._charIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    else
      local imageRecord = item:GetIcon()
      self._itemIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    end
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
    LogErrorFormat("ItemBuyDialog", "The discount and discountPrice data error! [discount=%d, discountPrice=%d]", self._data.discount, self._data.discountPrice)
  end
  local imageRecord = item:GetShopBuyBackGroudImg()
  self._itemBack:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._itemDetail:SetText(item:GetDestribe())
  local fontsize = self._itemDetail:GetFontSize()
  local _, textheight = self._itemDetail:GetPreferredSize()
  if textheight > self._height then
    local line = (textheight - self._height) / fontsize
    local delta = line * fontsize
    self._itemDetail:SetSize(self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y + delta)
    self._itemDetail:SetPosition(self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y - delta)
  end
  if type(self._data.itemId) == "table" then
    self._itemData = {}
    for i, v in ipairs(self._data.itemId) do
      local temp = {
        id = v,
        count = self._data.itemSum[i]
      }
      table.insert(self._itemData, temp)
    end
  else
    self._itemData = {
      {
        id = self._data.itemId,
        count = self._data.itemSum
      }
    }
  end
  self._itemFrame:ReloadAllCell()
  self._itemFrame:MoveToTop()
end

function ItemBuyDialog:OnBuyBtnClicked()
  if self._data.discount == -1 or self._data.discount == 10 and self._data.discountPrice == 0 then
    self._bm:KillRedDot(1)
    LuaNotificationCenter.PostNotification(Common.n_OnLocalRefreshDragonBoatFestivalRedpoint, nil, nil)
  end
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

function ItemBuyDialog:OnDialogClicked(args)
  if not UIManager.RectangleContainsScreenPoint(self:GetRootWindow()._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) then
    self:OnBackBtnClicked()
  end
end

function ItemBuyDialog:OnBackBtnClicked()
  if DialogManager.GetDialog("bag.itemtipsdialog") or DialogManager.GetDialog("equip.equiptipspreviewdialog") then
    return
  end
  self:Destroy()
end

function ItemBuyDialog:NumberOfCell(frame)
  return #self._itemData
end

function ItemBuyDialog:CellAtIndex(frame, index)
  return "activity.dragonboatfestival.shopitembuycell"
end

function ItemBuyDialog:DataAtIndex(frame, index)
  return self._itemData[index]
end

return ItemBuyDialog
