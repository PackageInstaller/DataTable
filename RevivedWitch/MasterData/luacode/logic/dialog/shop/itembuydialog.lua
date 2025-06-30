-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/shop/itembuydialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local UIManager = ((CS.PixelNeko).UI).UIManager
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CRoleItem = (BeanManager.GetTableByName)("item.croleitem")
local CNPCShape = (BeanManager.GetTableByName)("npc.cnpcshape")
local RoleConfigTable = (BeanManager.GetTableByName)("role.roleconfig")
local RoleTypeId = 27
local ItemBuyDialog = class("ItemBuyDialog", Dialog)
ItemBuyDialog.AssetBundleName = "ui/layouts.baseshop"
ItemBuyDialog.AssetName = "ItemBuy"
ItemBuyDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ItemBuyDialog
  ((ItemBuyDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

ItemBuyDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._itemBack = self:GetChild("Back/ItemBack")
  self._itemImage = self:GetChild("Back/MonthCardImg")
  self._itemImage_Char = self:GetChild("Back/Char")
  self._itemName = self:GetChild("Back/ItemName")
  self._itemDetail = self:GetChild("Back/ItemDetail")
  self._timeText = self:GetChild("Back/Time")
  self._timeImg = self:GetChild("Back/TimeImg")
  self._saleImage = self:GetChild("Back/Sale")
  self._leftNum = self:GetChild("Back/Num/Num")
  self._leftBoard = self:GetChild("Back/Num")
  self._priceTypeImage = self:GetChild("Back/Price/Image")
  self._priceNum = self:GetChild("Back/Price/Num")
  self._buyDetail = self:GetChild("Back/Detail")
  self._itemPanel = self:GetChild("Back/Frame")
  self._itemFrame = (TableFrame.Create)(self._itemPanel, self, true, true, true)
  self._buyNum = self:GetChild("Back/BuyNum/Num")
  self._priceAllNum = self:GetChild("Back/PriceAll/Num")
  self._priceAllImage = self:GetChild("Back/PriceAll/Image")
  self._slideAdd = self:GetChild("Back/SlidingArea/Add")
  self._slideReduce = self:GetChild("Back/SlidingArea/Reduce")
  self._slideBar = self:GetChild("Back/SlidingArea/HandleScrollbar")
  self._slideBarBlockBoard = self:GetChild("Back/SlidingArea/Image")
  ;
  (self._slideBarBlockBoard):SetActive(false)
  self._slideBarProgress = self:GetChild("Back/SlidingArea/HandleScrollbar/__Sliding Area/Progress")
  ;
  (self._slideBar):Subscribe_ValueChangedEvent(function()
    -- function num : 0_1_0 , upvalues : self
    self:OnScrollbarValueChange()
  end
)
  ;
  (self._slideAdd):Subscribe_PointerClickEvent(self.OnAddBtnClicked, self)
  ;
  (self._slideReduce):Subscribe_PointerClickEvent(self.OnReduceBtnClicked, self)
  ;
  (self._slideAdd):Subscribe_BeginLongPressEvent(self.OnAddBeginLongPress, self)
  ;
  (self._slideAdd):Subscribe_LongPressEvent(self.OnAddLongPress, self)
  ;
  (self._slideAdd):Subscribe_EndLongPressEvent(self.OnAddEndLongPress, self)
  ;
  (self._slideAdd):Subscribe_CancelLongPressEvent(self.OnAddCancelLongPress, self)
  ;
  (self._slideReduce):Subscribe_BeginLongPressEvent(self.OnReduceBeginLongPress, self)
  ;
  (self._slideReduce):Subscribe_LongPressEvent(self.OnReduceLongPress, self)
  ;
  (self._slideReduce):Subscribe_EndLongPressEvent(self.OnReduceEndLongPress, self)
  ;
  (self._slideReduce):Subscribe_CancelLongPressEvent(self.OnReduceCancelLongPress, self)
  self._buyBtn = self:GetChild("Back/BuyBtn")
  ;
  (self._buyBtn):Subscribe_PointerClickEvent(self.OnBuyBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnDialogClicked, Common.n_GlobalPointerWillDown, nil)
end

ItemBuyDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._itemFrame):Destroy()
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

ItemBuyDialog.SetData = function(self, iteminfo, shopid)
  -- function num : 0_3 , upvalues : CImagePathTable, Item, RoleTypeId, CRoleItem, RoleConfigTable, CNPCShape, _ENV, CStringRes
  self._itemInfo = iteminfo
  self._shopID = shopid
  self._isAddOrReduceClick = false
  if iteminfo.discount == 0 then
    (self._saleImage):SetActive(false)
  else
    if iteminfo.discount == -1 then
      (self._saleImage):SetActive(false)
    else
      ;
      (self._saleImage):SetActive(true)
      local imageRecord = CImagePathTable:GetRecorder(10 - iteminfo.discount + 11392)
      ;
      (self._saleImage):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    end
  end
  do
    self._itemData = {
{id = iteminfo.itemId, count = iteminfo.itemSum}
}
    ;
    (self._itemFrame):ReloadAllCell()
    local item = (Item.Create)(iteminfo.itemId)
    local isRole = item:GetItemTypeId() == RoleTypeId
    ;
    (self._itemImage_Char):SetActive(isRole)
    ;
    (self._itemImage):SetActive(not isRole)
    if isRole then
      local roleid = (CRoleItem:GetRecorder(iteminfo.itemId)).roleid
      local roleRecorder = RoleConfigTable:GetRecorder(roleid)
      local npcshaperecord = CNPCShape:GetRecorder(roleRecorder.shapeID)
      imageRecord = CImagePathTable:GetRecorder(npcshaperecord.skillHeadID)
      ;
      (self._itemImage_Char):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    else
      imageRecord = item:GetIcon()
      ;
      (self._itemImage):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    end
    imageRecord = item:GetShopBuyBackGroudImg()
    ;
    (self._itemBack):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    ;
    (self._itemName):SetText(item:GetName())
    ;
    (self._itemDetail):SetText(tostring(item:GetDestribe()))
    local str = (TextManager.GetText)((CStringRes:GetRecorder(1169)).msgTextID)
    str = (string.gsub)(str, "%$parameter1%$", item:GetName())
    str = (string.gsub)(str, "%$parameter2%$", iteminfo.itemSum)
    ;
    (self._buyDetail):SetText(str)
    item = (Item.Create)(iteminfo.moneyType)
    imageRecord = item:GetIcon()
    ;
    (self._priceTypeImage):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    ;
    (self._priceAllImage):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    ;
    (self._priceNum):SetText(tostring(iteminfo.discountPrice))
    if iteminfo.goodRemain == 0 then
      (self._leftNum):SetText(0)
    elseif iteminfo.goodRemain == -1 then
      (self._leftNum):SetText(99 .. "+")
    else
      (self._leftNum):SetText(tostring(iteminfo.goodRemain))
    end
    local isUniqueEquipBuy35026 = false
    local monyeyItem = (Item.Create)((self._itemInfo).moneyType)
    isUniqueEquipBuy35026 = not monyeyItem or not monyeyItem:IsUniqueEquip() or (self._itemInfo).itemId == 35026
    if isUniqueEquipBuy35026 or not (self._itemInfo).beginTime or not (self._itemInfo).endTime or (self._itemInfo).beginTime == 0 or (self._itemInfo).endTime == 0 then
      (self._timeText):SetActive(false)
      ;
      (self._timeImg):SetActive(false)
    else
      (self._timeImg):SetActive(true)
      ;
      (self._timeText):SetActive(true)
      ;
      (self._timeText):SetText(((NekoData.BehaviorManager).BM_Shop):GetRemainTimeStr((self._itemInfo).endTime))
    end
    self._currentBuyItemNumber = 1
    self._buyMinNum = 1
    self._unitPrice = iteminfo.discountPrice
    if (string.sub)(iteminfo.moneyType, 1, 2) == "35" then
      self._totalMoney = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(iteminfo.moneyType)
    else
      self._totalMoney = ((NekoData.BehaviorManager).BM_BagInfo):GetItemCountById(iteminfo.moneyType)
    end
    self._canBuyMaxNum = (math.floor)(self._totalMoney / self._unitPrice)
    if iteminfo.goodRemain ~= -1 then
      self._canBuyMaxNum = (math.min)(self._canBuyMaxNum, iteminfo.goodRemain)
    end
    if self._canBuyMaxNum == 0 then
      (self._slideBarBlockBoard):SetActive(true)
      self._currentBuyItemNumber = 0
      self._buyMinNum = 0
    else
      (self._slideBar):SetScrollValue(self._currentBuyItemNumber / self._canBuyMaxNum)
      ;
      (self._slideBarProgress):SetFillAmount((self._slideBar):GetScrollValue())
    end
    self._totalCost = self._currentBuyItemNumber * self._unitPrice
    ;
    (self._buyNum):SetText(tostring(self._currentBuyItemNumber))
    ;
    (self._priceAllNum):SetText(tostring(self._totalCost))
    -- DECOMPILER ERROR: 16 unprocessed JMP targets
  end
end

ItemBuyDialog.RefreshSlideState = function(self, currentRate)
  -- function num : 0_4 , upvalues : _ENV
  if self._canBuyMaxNum == 0 then
    return 
  end
  if currentRate then
    (self._slideBar):SetScrollValue(currentRate)
    self._currentBuyItemNumber = (math.floor)(self._canBuyMaxNum * currentRate)
    self._currentBuyItemNumber = (math.max)(self._currentBuyItemNumber, self._buyMinNum)
  else
    local rate = 0
    if self._canBuyMaxNum ~= 0 then
      rate = self._currentBuyItemNumber / self._canBuyMaxNum
    end
    ;
    (self._slideBar):SetScrollValue(rate)
  end
  do
    ;
    (self._buyNum):SetText(tostring(self._currentBuyItemNumber))
    self._totalCost = self._currentBuyItemNumber * self._unitPrice
    ;
    (self._priceAllNum):SetText(tostring(self._totalCost))
    if self._currentBuyItemNumber == 1 then
      (self._slideBar):SetScrollValue(self._currentBuyItemNumber / self._canBuyMaxNum)
      ;
      (self._slideBarProgress):SetFillAmount((self._slideBar):GetScrollValue())
    else
      ;
      (self._slideBarProgress):SetFillAmount((self._slideBar):GetScrollValue())
    end
  end
end

ItemBuyDialog.OnBuyBtnClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV, Item
  if self._canBuyMaxNum == 0 then
    if (self._itemInfo).moneyType == DataCommon.DiamodID then
      ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(15, nil, function()
    -- function num : 0_5_0 , upvalues : _ENV
    ((NekoData.BehaviorManager).BM_Shop):TryOpenShopWithID(4)
  end
, {}, nil, {})
      self:Destroy()
      return 
    else
      if (self._itemInfo).moneyType == DataCommon.SoulDropID then
        ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(108, nil, function()
    -- function num : 0_5_1 , upvalues : _ENV
    ((NekoData.BehaviorManager).BM_Shop):TryOpenShopWithID(19)
  end
, {}, nil, {})
        self:Destroy()
        return 
      end
    end
    ;
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100032, {((Item.Create)((self._itemInfo).moneyType)):GetName()})
    self:Destroy()
    return 
  end
  local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.cbuyshopgood")
  if protocol then
    protocol.shopId = self._shopID
    local map = {}
    map[(self._itemInfo).goodId] = self._currentBuyItemNumber
    protocol.goods = map
    protocol:Send()
  end
end

ItemBuyDialog.OnDialogClicked = function(self, args)
  -- function num : 0_6 , upvalues : UIManager
  if not (UIManager.RectangleContainsScreenPoint)((self:GetRootWindow())._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) then
    self:OnBackBtnClicked()
  end
end

ItemBuyDialog.OnBackBtnClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV
  if (DialogManager.GetDialog)("bag.itemtipsdialog") or (DialogManager.GetDialog)("equip.equiptipspreviewdialog") then
    return 
  end
  self:Destroy()
end

ItemBuyDialog.OnScrollbarValueChange = function(self)
  -- function num : 0_8
  if not self._isAddOrReduceClick then
    self:RefreshSlideState((self._slideBar):GetScrollValue())
  end
end

ItemBuyDialog.OnAddBtnClicked = function(self)
  -- function num : 0_9 , upvalues : _ENV
  self._isAddOrReduceClick = true
  self._currentBuyItemNumber = self._currentBuyItemNumber + 1
  self._currentBuyItemNumber = (math.min)(self._currentBuyItemNumber, self._canBuyMaxNum)
  self:RefreshSlideState()
  self._isAddOrReduceClick = false
end

ItemBuyDialog.OnAddBeginLongPress = function(self)
  -- function num : 0_10
  self._isAddOrReduceClick = true
end

ItemBuyDialog.OnAddLongPress = function(self)
  -- function num : 0_11 , upvalues : _ENV
  self._currentBuyItemNumber = self._currentBuyItemNumber + 1
  self._currentBuyItemNumber = (math.min)(self._currentBuyItemNumber, self._canBuyMaxNum)
  self:RefreshSlideState()
end

ItemBuyDialog.OnAddEndLongPress = function(self)
  -- function num : 0_12
  self._isAddOrReduceClick = false
end

ItemBuyDialog.OnAddCancelLongPress = function(self)
  -- function num : 0_13
  self._isAddOrReduceClick = false
end

ItemBuyDialog.OnReduceBtnClicked = function(self)
  -- function num : 0_14 , upvalues : _ENV
  self._isAddOrReduceClick = true
  self._currentBuyItemNumber = self._currentBuyItemNumber - 1
  self._currentBuyItemNumber = (math.max)(self._currentBuyItemNumber, self._buyMinNum)
  self:RefreshSlideState()
  self._isAddOrReduceClick = false
end

ItemBuyDialog.OnReduceBeginLongPress = function(self)
  -- function num : 0_15
  self._isAddOrReduceClick = true
end

ItemBuyDialog.OnReduceLongPress = function(self)
  -- function num : 0_16 , upvalues : _ENV
  self._currentBuyItemNumber = self._currentBuyItemNumber - 1
  self._currentBuyItemNumber = (math.max)(self._currentBuyItemNumber, self._buyMinNum)
  self:RefreshSlideState()
end

ItemBuyDialog.OnReduceEndLongPress = function(self)
  -- function num : 0_17
  self._isAddOrReduceClick = false
end

ItemBuyDialog.OnReduceCancelLongPress = function(self)
  -- function num : 0_18
  self._isAddOrReduceClick = false
end

ItemBuyDialog.NumberOfCell = function(self, frame)
  -- function num : 0_19
  return #self._itemData
end

ItemBuyDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_20
  return "shop.dailygiftbuycell"
end

ItemBuyDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_21
  return (self._itemData)[index]
end

return ItemBuyDialog

