local Item = require("logic.manager.experimental.types.item")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local ExchangeDialog = class("ExchangeDialog", Dialog)
ExchangeDialog.AssetBundleName = "ui/layouts.activityspringouting"
ExchangeDialog.AssetName = "ActivitySpringOutingItemBuy"

function ExchangeDialog:Ctor(...)
  ExchangeDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
  self._atomOnceNum = 1
  self._exchangeNum = 1
  self._exchangeRate = 1
end

function ExchangeDialog:OnCreate()
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
  self._subBtn:Subscribe_PointerClickEvent(self.OnSubBtnClicked, self)
  self._addBtn:Subscribe_PointerClickEvent(self.OnAddBtnClicked, self)
  self._maxBtn:Subscribe_PointerClickEvent(self.OnMaxBtnClicked, self)
  self._confirmButton:Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  self._cancelButton:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.RefreshCurrencyData, Common.n_RefreshCurrency, nil)
  self:SetStaticRes()
end

function ExchangeDialog:OnDestroy()
end

function ExchangeDialog:SetStaticRes()
  self._nowHaveNumText:SetText(TextManager.GetText(CStringRes:GetRecorder(1813).msgTextID))
  self._nowUseNumText:SetText(TextManager.GetText(CStringRes:GetRecorder(1821).msgTextID))
  self._currencyItem = Item.Create(DataCommon.LuckyCopperCoin)
  self._currencyIcon:SetSprite(self._currencyItem:GetIcon().assetBundle, self._currencyItem:GetIcon().assetName)
end

function ExchangeDialog:OnBackBtnClicked()
  self:Destroy()
end

function ExchangeDialog:SetData()
  self._dm = NekoData.DataManager.DM_Activity:GetManager(DataCommon.DragonBoatFestivalActivityManagerID)
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.DragonBoatFestivalActivityManagerID)
  self._atomOnceNum = self._bm:GetExchangeLotteryRate()
  self._exchangeNum = self._atomOnceNum
  self._exchangeRate = self._bm:GetExchangeLotteryRate()
  self:RefreshShowData()
  self:RefreshCurrencyData()
end

function ExchangeDialog:RefreshShowData()
  self._nowNum:SetText(self._exchangeNum)
  self._nowExchangeNumText:SetText(TextManager.GetText(CStringRes:GetRecorder(1825).msgTextID, self._exchangeNum // self._exchangeRate))
end

function ExchangeDialog:RefreshCurrencyData()
  self._haveCurrencyNum = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.LuckyCopperCoin)
  self._nowHaveNum:SetText(NumberManager.GetShowNumber(self._haveCurrencyNum))
  if self._haveCurrencyNum < self._exchangeNum then
    self:OnMaxBtnClicked()
  end
end

function ExchangeDialog:OnSubBtnClicked()
  if self._exchangeNum - self._atomOnceNum > 0 then
    self._exchangeNum = self._exchangeNum - self._atomOnceNum
  end
  self:RefreshShowData()
end

function ExchangeDialog:OnAddBtnClicked()
  if self._exchangeNum + self._atomOnceNum <= self._haveCurrencyNum then
    self._exchangeNum = self._exchangeNum + self._atomOnceNum
  end
  self:RefreshShowData()
end

function ExchangeDialog:OnMaxBtnClicked()
  self._exchangeNum = self._haveCurrencyNum // self._atomOnceNum * self._atomOnceNum
  self:RefreshShowData()
end

function ExchangeDialog:OnConfirmBtnClicked()
  if self._exchangeNum < self._atomOnceNum then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100468)
    return
  end
  if not self._bm:GetWishIsOpen() then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100467)
    self:Destroy()
    return
  end
  self._bm:SendCActivityExchangeLottery(self._exchangeNum // self._exchangeRate)
  self:Destroy()
end

return ExchangeDialog
