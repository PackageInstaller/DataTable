-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/shop/daygiftbuydialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CMessageTip = (BeanManager.GetTableByName)("message.cmessagetip")
local DailiGiftBuyDialog = class("DailiGiftBuyDialog", Dialog)
DailiGiftBuyDialog.AssetBundleName = "ui/layouts.baseshop"
DailiGiftBuyDialog.AssetName = "DayGiftBuy"
DailiGiftBuyDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DailiGiftBuyDialog
  ((DailiGiftBuyDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
  self._cellData = {}
end

DailiGiftBuyDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._itemImage = self:GetChild("Back/MonthCardImg")
  self._itemName = self:GetChild("Back/ItemName")
  self._timeText = self:GetChild("Back/Time")
  self._timeImage = self:GetChild("Back/TimeImg")
  self._saleImage = self:GetChild("Back/Sale")
  self._leftNum = self:GetChild("Back/Num/Num")
  self._leftBoard = self:GetChild("Back/Num")
  self._priceBorder = self:GetChild("Back/Price")
  self._priceImage = self:GetChild("Back/Price/Image")
  self._priceNum = self:GetChild("Back/Price/Num")
  self._price2Border = self:GetChild("Back/Price2")
  self._price2Image = self:GetChild("Back/Price2/Image")
  self._price2Num = self:GetChild("Back/Price2/Num")
  self._price2TextDelete = self:GetChild("Back/Price2/TextDelete")
  self._buyDetail = self:GetChild("Back/Frame")
  self._cellFrame = (TableFrame.Create)(self._buyDetail, self, true, true, true)
  ;
  (self._cellFrame):SetMargin(30, 0)
  self._buyBtn = self:GetChild("Back/BuyBtn")
  ;
  (self._buyBtn):Subscribe_PointerClickEvent(self.OnBuyBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnDialogClicked, Common.n_GlobalPointerWillDown, nil)
end

DailiGiftBuyDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._cellFrame):Destroy()
  if self._task then
    (ServerGameTimer.RemoveTask)(self._task)
    self._task = nil
  end
end

DailiGiftBuyDialog.SetData = function(self, data)
  -- function num : 0_3 , upvalues : Item, _ENV
  self._data = data
  local item = (Item.Create)((self._data).goodName)
  local str = item:GetName()
  ;
  (self._itemName):SetText(str)
  local imageRecord = item:GetIcon()
  ;
  (self._itemImage):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  if (self._data).discount ~= -1 and (self._data).discount ~= 10 then
    (self._saleImage):SetActive(true)
    imageRecord = ((NekoData.BehaviorManager).BM_Shop):GetDiscountAsset((self._data).discount)
    ;
    (self._saleImage):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    ;
    (self._priceBorder):SetActive(false)
    ;
    (self._price2Border):SetActive(true)
    ;
    (self._price2Num):SetText((self._data).discountPrice)
    ;
    (self._price2TextDelete):SetText((self._data).price)
  else
    ;
    (self._saleImage):SetActive(false)
    ;
    (self._priceBorder):SetActive(true)
    ;
    (self._price2Border):SetActive(false)
    ;
    (self._priceNum):SetText((self._data).discountPrice)
  end
  self._goodRemain = (self._data).goodRemain
  if (self._data).goodRemain == -1 then
    (self._leftNum):SetText(tostring(99 .. "+"))
  else
    ;
    (self._leftNum):SetText(tostring((self._data).goodRemain))
  end
  self._cellData = {}
  for i,v in ipairs((self._data).itemId) do
    local temp = {}
    temp.id = v
    temp.count = ((self._data).itemSum)[i]
    ;
    (table.insert)(self._cellData, temp)
  end
  self._giftID = (self._data).goodId
  self._delTime = (self._data).endTime
  if self._task then
    (ServerGameTimer.RemoveTask)(self._task)
    self._task = nil
  end
  self._task = (ServerGameTimer.AddTask)(0, 1, function()
    -- function num : 0_3_0 , upvalues : self
    self:SetTime()
  end
, nil)
  ;
  (self._cellFrame):ReloadAllCell()
  ;
  (self._cellFrame):MoveToTop()
end

DailiGiftBuyDialog.NumberOfCell = function(self, frame)
  -- function num : 0_4
  return #self._cellData
end

DailiGiftBuyDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  return "shop.dailygiftbuycell"
end

DailiGiftBuyDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  return (self._cellData)[index]
end

DailiGiftBuyDialog.OnBuyBtnClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV, CMessageTip
  do
    if self._delTime < 0 then
      local str = (TextManager.GetText)((CMessageTip:GetRecorder(100116)).msgTextID)
      ;
      ((NekoData.BehaviorManager).BM_Message):AddMessageTip(str)
    end
    if self._goodRemain > 0 or self._goodRemain == -1 then
      local hasDiamond = ((NekoData.BehaviorManager).BM_Currency):GetDiamond()
      if (self._data).discountPrice <= hasDiamond then
        local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.cbuydailygift")
        if protocol then
          protocol.giftID = self._giftID
          protocol:Send()
        end
      else
        do
          do
            ;
            ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(15, nil, function()
    -- function num : 0_7_0 , upvalues : _ENV
    ((NekoData.BehaviorManager).BM_Shop):TryOpenShopWithID(4)
  end
, {}, nil, {})
            do
              local str = (TextManager.GetText)((CMessageTip:GetRecorder(100117)).msgTextID)
              ;
              ((NekoData.BehaviorManager).BM_Message):AddMessageTip(str)
              self:Destroy()
            end
          end
        end
      end
    end
  end
end

DailiGiftBuyDialog.OnDialogClicked = function(self, args)
  -- function num : 0_8 , upvalues : UIManager
  if not (UIManager.RectangleContainsScreenPoint)((self:GetRootWindow())._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) then
    self:OnBackBtnClicked()
  end
end

DailiGiftBuyDialog.OnBackBtnClicked = function(self)
  -- function num : 0_9 , upvalues : _ENV
  if (DialogManager.GetDialog)("bag.itemtipsdialog") then
    return 
  end
  self:Destroy()
end

DailiGiftBuyDialog.SetTime = function(self)
  -- function num : 0_10 , upvalues : _ENV, CStringRes
  local time, str = nil, nil
  time = MsToHour(self._delTime)
  str = (TextManager.GetText)((CStringRes:GetRecorder(1181)).msgTextID)
  if time < 0 then
    time = 0
    str = (TextManager.GetText)((CStringRes:GetRecorder(1182)).msgTextID)
  else
    if time < 1 then
      time = MsToMin(self._delTime)
      str = (TextManager.GetText)((CStringRes:GetRecorder(1182)).msgTextID)
    end
  end
  str = (string.gsub)(str, "%$parameter1%$", tostring(time))
  ;
  (self._timeText):SetText(str)
  self._delTime = self._delTime - 1000
end

MsToHour = function(ms)
  -- function num : 0_11 , upvalues : _ENV
  return (math.floor)(ms / 3600000)
end

MsToMin = function(ms)
  -- function num : 0_12 , upvalues : _ENV
  return (math.ceil)(ms / 3600000 / 60)
end

return DailiGiftBuyDialog

