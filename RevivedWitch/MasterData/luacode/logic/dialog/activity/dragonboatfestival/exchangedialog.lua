-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/dragonboatfestival/exchangedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local ExchangeDialog = class("ExchangeDialog", Dialog)
ExchangeDialog.AssetBundleName = "ui/layouts.activityspringouting"
ExchangeDialog.AssetName = "ActivitySpringOutingItemBuy"
ExchangeDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ExchangeDialog
  ((ExchangeDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
  self._atomOnceNum = 1
  self._exchangeNum = 1
  self._exchangeRate = 1
end

ExchangeDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._nowHaveNumText = self:GetChild("Image/Back/CostBack/Txt1")
  self._nowUseNumText = self:GetChild("Image/Back/Text2")
  self._nowExchangeNumText = self:GetChild("Image/Back/Text5")
  self._currencyIcon = self:GetChild("Image/Back/Line")
  self._nowHaveNum = self:GetChild("Image/Back/CostBack/Num")
  self._nowNum = self:GetChild("Image/Back/Num/Num")
  self._subBtn = self:GetChild("Image/Back/Num/MinusBtn")
  self._addBtn = self:GetChild("Image/Back/Num/AddBtn")
  self._maxBtn = self:GetChild("Image/Back/Num/MaxBtn")
  self._confirmButton = self:GetChild("Image/Back/ConfirmButton")
  self._cancelButton = self:GetChild("Image/Back/CancelButton")
  ;
  (self._subBtn):Subscribe_PointerClickEvent(self.OnSubBtnClicked, self)
  ;
  (self._addBtn):Subscribe_PointerClickEvent(self.OnAddBtnClicked, self)
  ;
  (self._maxBtn):Subscribe_PointerClickEvent(self.OnMaxBtnClicked, self)
  ;
  (self._confirmButton):Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  ;
  (self._cancelButton):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshCurrencyData, Common.n_RefreshCurrency, nil)
  self:SetStaticRes()
end

ExchangeDialog.OnDestroy = function(self)
  -- function num : 0_2
end

ExchangeDialog.SetStaticRes = function(self)
  -- function num : 0_3 , upvalues : _ENV, CStringRes, Item
  (self._nowHaveNumText):SetText((TextManager.GetText)((CStringRes:GetRecorder(1813)).msgTextID))
  ;
  (self._nowUseNumText):SetText((TextManager.GetText)((CStringRes:GetRecorder(1821)).msgTextID))
  self._currencyItem = (Item.Create)(DataCommon.LuckyCopperCoin)
  ;
  (self._currencyIcon):SetSprite(((self._currencyItem):GetIcon()).assetBundle, ((self._currencyItem):GetIcon()).assetName)
end

ExchangeDialog.OnBackBtnClicked = function(self)
  -- function num : 0_4
  self:Destroy()
end

ExchangeDialog.SetData = function(self)
  -- function num : 0_5 , upvalues : _ENV
  self._dm = ((NekoData.DataManager).DM_Activity):GetManager(DataCommon.DragonBoatFestivalActivityManagerID)
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.DragonBoatFestivalActivityManagerID)
  self._atomOnceNum = (self._bm):GetExchangeLotteryRate()
  self._exchangeNum = self._atomOnceNum
  self._exchangeRate = (self._bm):GetExchangeLotteryRate()
  self:RefreshShowData()
  self:RefreshCurrencyData()
end

ExchangeDialog.RefreshShowData = function(self)
  -- function num : 0_6 , upvalues : _ENV, CStringRes
  (self._nowNum):SetText(self._exchangeNum)
  ;
  (self._nowExchangeNumText):SetText((TextManager.GetText)((CStringRes:GetRecorder(1825)).msgTextID, self._exchangeNum // self._exchangeRate))
end

ExchangeDialog.RefreshCurrencyData = function(self)
  -- function num : 0_7 , upvalues : _ENV
  self._haveCurrencyNum = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.LuckyCopperCoin)
  ;
  (self._nowHaveNum):SetText((NumberManager.GetShowNumber)(self._haveCurrencyNum))
  if self._haveCurrencyNum < self._exchangeNum then
    self:OnMaxBtnClicked()
  end
end

ExchangeDialog.OnSubBtnClicked = function(self)
  -- function num : 0_8
  if self._exchangeNum - self._atomOnceNum > 0 then
    self._exchangeNum = self._exchangeNum - self._atomOnceNum
  end
  self:RefreshShowData()
end

ExchangeDialog.OnAddBtnClicked = function(self)
  -- function num : 0_9
  if self._exchangeNum + self._atomOnceNum <= self._haveCurrencyNum then
    self._exchangeNum = self._exchangeNum + self._atomOnceNum
  end
  self:RefreshShowData()
end

ExchangeDialog.OnMaxBtnClicked = function(self)
  -- function num : 0_10
  self._exchangeNum = self._haveCurrencyNum // self._atomOnceNum * self._atomOnceNum
  self:RefreshShowData()
end

ExchangeDialog.OnConfirmBtnClicked = function(self)
  -- function num : 0_11 , upvalues : _ENV
  if self._exchangeNum < self._atomOnceNum then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100468)
    return 
  end
  if not (self._bm):GetWishIsOpen() then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100467)
    self:Destroy()
    return 
  end
  ;
  (self._bm):SendCActivityExchangeLottery(self._exchangeNum // self._exchangeRate)
  self:Destroy()
end

return ExchangeDialog

