-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/shop/itembuy2dialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local ItemBuy2Dialog = class("ItemBuy2Dialog", Dialog)
ItemBuy2Dialog.AssetBundleName = "ui/layouts.baseshop"
ItemBuy2Dialog.AssetName = "ItemBuy2"
ItemBuy2Dialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ItemBuy2Dialog
  ((ItemBuy2Dialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

ItemBuy2Dialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._itemImage = self:GetChild("Back/MonthCardImg")
  self._itemName = self:GetChild("Back/ItemName")
  self._priceTypeImage = self:GetChild("Back/Price/Image")
  self._priceNum = self:GetChild("Back/Price/Num")
  self._priceAllTypeImage = self:GetChild("Back/PriceAll/Image")
  self._priceAllNum = self:GetChild("Back/PriceAll/Num")
  self._buyDetail = self:GetChild("Back/Frame")
  self._buyBtn = self:GetChild("Back/BuyBtn")
  self._cellFrame = (TableFrame.Create)(self._buyDetail, self, true, true, true)
  ;
  (self._cellFrame):SetMargin(30, 0)
  ;
  (self._buyBtn):Subscribe_PointerClickEvent(self.OnBuyBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnDialogClicked, Common.n_GlobalPointerWillDown, nil)
end

ItemBuy2Dialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._cellFrame):Destroy()
end

ItemBuy2Dialog.SetData = function(self, iteminfo, shopid)
  -- function num : 0_3 , upvalues : CImagePathTable, _ENV, Item
  self._itemInfo = iteminfo
  self._shopID = shopid
  local imageRecord = CImagePathTable:GetRecorder((self._itemInfo).pictureId)
  ;
  (self._itemImage):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._itemName):SetText((TextManager.GetText)((self._itemInfo).goodName))
  if (self._itemInfo).moneyType > 10000 then
    local item = (Item.Create)((self._itemInfo).moneyType)
    imageRecord = item:GetIcon()
    ;
    (self._priceTypeImage):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    ;
    (self._priceTypeImage):SetActive(true)
    ;
    (self._priceAllTypeImage):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    ;
    (self._priceAllTypeImage):SetActive(true)
  else
    do
      ;
      (self._priceTypeImage):SetActive(false)
      ;
      (self._priceAllTypeImage):SetActive(false)
      ;
      (self._priceNum):SetText((self._itemInfo).discountPrice)
      ;
      (self._priceAllNum):SetText((self._itemInfo).discountPrice)
      ;
      (self._cellFrame):ReloadAllCell()
      ;
      (self._cellFrame):MoveToTop()
    end
  end
end

ItemBuy2Dialog.NumberOfCell = function(self, frame)
  -- function num : 0_4
  if ((self._itemInfo).itemSum)[2] > 0 then
    return #(self._itemInfo).itemId
  end
  return 1
end

ItemBuy2Dialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  return "shop.dailygiftbuycell"
end

ItemBuy2Dialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  return {id = ((self._itemInfo).itemId)[index], count = ((self._itemInfo).itemSum)[index]}
end

ItemBuy2Dialog.OnBuyBtnClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local hasDiamond = ((NekoData.BehaviorManager).BM_Currency):GetDiamond()
  if (self._itemInfo).discountPrice <= hasDiamond then
    local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.cbuyshopgood")
    if protocol then
      protocol.shopId = self._shopID
      protocol.goods = {[(self._itemInfo).goodId] = 1}
      protocol:Send()
    end
  else
    do
      ;
      ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(15, nil, function()
    -- function num : 0_7_0 , upvalues : _ENV
    ((NekoData.BehaviorManager).BM_Shop):TryOpenShopWithID(4)
  end
, {}, nil, {})
      self:Destroy()
    end
  end
end

ItemBuy2Dialog.OnDialogClicked = function(self, args)
  -- function num : 0_8 , upvalues : UIManager
  if not (UIManager.RectangleContainsScreenPoint)((self:GetRootWindow())._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) then
    self:OnBackBtnClicked()
  end
end

ItemBuy2Dialog.OnBackBtnClicked = function(self)
  -- function num : 0_9 , upvalues : _ENV
  if (DialogManager.GetDialog)("bag.itemtipsdialog") then
    return 
  end
  self:Destroy()
end

return ItemBuy2Dialog

