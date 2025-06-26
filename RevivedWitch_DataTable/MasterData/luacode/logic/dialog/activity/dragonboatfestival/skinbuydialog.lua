-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/dragonboatfestival/skinbuydialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local RoleConfigTable = (BeanManager.GetTableByName)("role.roleconfig")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CRoleItem = (BeanManager.GetTableByName)("item.croleitem")
local CNPCShape = (BeanManager.GetTableByName)("npc.cnpcshape")
local CSugarShopOpen = (BeanManager.GetTableByName)("recharge.csugarshopopen")
local RoleTypeId = 27
local SkinTypeId = 91
local SkinBuyDialog = class("SkinBuyDialog", Dialog)
SkinBuyDialog.AssetBundleName = "ui/layouts.activityspringouting"
SkinBuyDialog.AssetName = "ActivitySpringOutingShopSkin"
SkinBuyDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SkinBuyDialog
  ((SkinBuyDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

SkinBuyDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._itemName = self:GetChild("Back/ItemName")
  self._itemIcon = self:GetChild("Back/MonthCardImg")
  self._goodsNum = self:GetChild("Back/Num/Num")
  self._itemBack = self:GetChild("Back/ItemBack")
  self._limit = self:GetChild("Back/TimeImg")
  self._limitTxt = self:GetChild("Back/Time")
  self._saleImage = self:GetChild("Back/Sale")
  self._itemPanel = self:GetChild("Back/Frame3")
  self._itemFrame = (TableFrame.Create)(self._itemPanel, self, true, true, true)
  self._skinPanel = self:GetChild("Back/Frame")
  self._skinFrame = (TableFrame.Create)(self._skinPanel, self, true, true, true)
  self._priceOnSale = self:GetChild("Back/Price2")
  self._priceOnSaleOri = self:GetChild("Back/Price2/TextDelete")
  self._priceOnSaleNow = self:GetChild("Back/Price2/Num")
  self._priceNormal = self:GetChild("Back/Price")
  self._priceNormalNow = self:GetChild("Back/Price/Num")
  self._priceFree = self:GetChild("Back/PriceFree")
  self._buyBtn = self:GetChild("Back/BuyBtn")
  ;
  (self._buyBtn):Subscribe_PointerClickEvent(self.OnBuyBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnDialogClicked, Common.n_GlobalPointerWillDown, nil)
end

SkinBuyDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._itemFrame then
    (self._itemFrame):Destroy()
  end
  if self._skinFrame then
    (self._skinFrame):Destroy()
  end
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

SkinBuyDialog.SetData = function(self, data, shopid)
  -- function num : 0_3 , upvalues : _ENV, Item, CImagePathTable, CSugarShopOpen, SkinTypeId
  self._data = data
  self._shopID = shopid
  if (self._data).goodRemain == 0 then
    (self._goodsNum):SetText(0)
  else
    if (self._data).goodRemain == -1 then
      (self._goodsNum):SetText(tostring(99 .. "+"))
    else
      ;
      (self._goodsNum):SetText((NumberManager.GetShowNumber)((self._data).goodRemain))
    end
  end
  local item = nil
  if type((self._data).itemId) == "table" then
    item = (Item.Create)((self._data).giftId)
    ;
    (self._itemName):SetText((TextManager.GetText)((self._data).goodName))
    ;
    (self._itemIcon):SetActive(true)
    local imageRecord = CImagePathTable:GetRecorder((self._data).pictureId)
    ;
    (self._itemIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    do
      item = (Item.Create)((CSugarShopOpen:GetRecorder((self._data).goodId)).Items)
      ;
      (self._itemName):SetText(item:GetName())
      do
        local imageRecord = item:GetIcon()
        ;
        (self._itemIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        if not (self._data).beginTime or not (self._data).endTime or (self._data).beginTime == 0 or (self._data).endTime == 0 then
          (self._limit):SetActive(false)
          ;
          (self._limitTxt):SetActive(false)
        else
          ;
          (self._limit):SetActive(true)
          ;
          (self._limitTxt):SetActive(true)
          ;
          (self._limitTxt):SetText(((NekoData.BehaviorManager).BM_Shop):GetRemainTimeStr((self._data).endTime))
        end
        self._goodType = (self._data).moneyType > 35000
        local noDiscount = (self._data).discount == -1 or (self._data).discount == 10
        if noDiscount and (self._data).discountPrice > 0 then
          (self._priceOnSale):SetActive(false)
          ;
          (self._priceNormal):SetActive(true)
          ;
          (self._priceFree):SetActive(false)
          ;
          (self._priceNormalNow):SetText((self._data).discountPrice)
          ;
          (self._saleImage):SetActive(false)
        elseif noDiscount and (self._data).discountPrice == 0 then
          (self._priceOnSale):SetActive(false)
          ;
          (self._priceNormal):SetActive(false)
          ;
          (self._priceFree):SetActive(true)
          ;
          (self._saleImage):SetActive(false)
        elseif not noDiscount then
          (self._priceOnSale):SetActive(true)
          ;
          (self._priceNormal):SetActive(false)
          ;
          (self._priceFree):SetActive(false)
          ;
          (self._priceOnSaleNow):SetText((self._data).discountPrice)
          ;
          (self._priceOnSaleOri):SetText((self._data).price)
          ;
          (self._saleImage):SetActive(true)
          local imageRecord = CImagePathTable:GetRecorder(10 - (self._data).discount + 11392)
          ;
          (self._saleImage):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        else
          LogErrorFormat("SkinBuyDialog", "The discount and discountPrice data error! [discount=%d, discountPrice=%d]", (self._data).discount, (self._data).discountPrice)
        end
        local imageRecord = item:GetShopBuyBackGroudImg()
        ;
        (self._itemBack):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        self._skinData = {}
        self._itemData = {}
        for i,v in ipairs((self._data).itemId) do
          local temp = {id = v, count = ((self._data).itemSum)[i]}
          local isSkin = ((Item.Create)(v)):GetItemTypeId() == SkinTypeId
          if isSkin then
            (table.insert)(self._skinData, temp)
          else
            (table.insert)(self._itemData, temp)
          end
        end
        ;
        (self._skinFrame):ReloadAllCell()
        ;
        (self._skinFrame):MoveToTop()
        ;
        (self._itemFrame):ReloadAllCell()
        ;
        (self._itemFrame):MoveToTop()
        -- DECOMPILER ERROR: 9 unprocessed JMP targets
      end
    end
  end
end

SkinBuyDialog.OnBuyBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if (self._data).moneyType > 35000 then
    local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.cbuyshopgood")
    if protocol then
      protocol.shopId = self._shopID
      protocol.goods = {[(self._data).goodId] = 1}
      protocol:Send()
    end
  else
    do
      do
        local protocol = (LuaNetManager.CreateProtocol)("protocol.charge.cbuydiamond")
        if protocol then
          protocol.goodId = (self._data).goodId
          protocol:Send()
        end
        self:Destroy()
      end
    end
  end
end

SkinBuyDialog.OnDialogClicked = function(self, args)
  -- function num : 0_5 , upvalues : UIManager
  if not (UIManager.RectangleContainsScreenPoint)((self:GetRootWindow())._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) then
    self:OnBackBtnClicked()
  end
end

SkinBuyDialog.OnBackBtnClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if (DialogManager.GetDialog)("bag.itemtipsdialog") or (DialogManager.GetDialog)("equip.equiptipspreviewdialog") then
    return 
  end
  self:Destroy()
end

SkinBuyDialog.NumberOfCell = function(self, frame)
  -- function num : 0_7
  if frame == self._itemFrame then
    return #self._itemData
  else
    return #self._skinData
  end
end

SkinBuyDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_8
  return "activity.dragonboatfestival.shopitembuycell"
end

SkinBuyDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_9
  if frame == self._itemFrame then
    return (self._itemData)[index]
  else
    return (self._skinData)[index]
  end
end

return SkinBuyDialog

