local CStringRes = BeanManager.GetTableByName("message.cstringres")
local ExchangeDialog = class("ExchangeDialog", Dialog)
ExchangeDialog.AssetBundleName = "ui/layouts.activitychristmascall"
ExchangeDialog.AssetName = "ActivityChristmasCallItemBuy"

function ExchangeDialog:Ctor(...)
  ExchangeDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
  self._exchangeNum = 1
end

function ExchangeDialog:OnCreate()
  self._contentText1 = self:GetChild("Image/Back/Text1")
  self._contentText3 = self:GetChild("Image/Back/Text3")
  self._contentText4 = self:GetChild("Image/Back/Text4")
  self._nowHaveText = self:GetChild("Image/Back/CostBack/Num")
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
  self._contentText3:SetText(TextManager.GetText(CStringRes:GetRecorder(1672).msgTextID))
end

function ExchangeDialog:OnBackBtnClicked()
  self:Destroy()
end

function ExchangeDialog:SetData()
  self._dm = NekoData.DataManager.DM_Activity:GetManager(DataCommon.ChristmasCallActivityManagerID)
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.ChristmasCallActivityManagerID)
  self._callOnceNum = self._bm:GetCChristmasCallCfg():GetRecorder(1).callNum
  self._convertNum = self._bm:GetCChristmasCallCfg():GetRecorder(1).convertNum
  self._exchangeNum = self._callOnceNum
  self:RefreshShowData()
  self:RefreshCurrencyData()
end

function ExchangeDialog:RefreshShowData()
  self._contentText1:SetText(TextManager.GetText(CStringRes:GetRecorder(1677).msgTextID, self._exchangeNum))
  self._contentText4:SetText(TextManager.GetText(CStringRes:GetRecorder(1687).msgTextID, self._exchangeNum * self._convertNum))
  self._nowNum:SetText(self._exchangeNum)
end

function ExchangeDialog:RefreshCurrencyData()
  self._haveCurrencyNum = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.ChrismasCallStick)
  self._nowHaveText:SetText(NumberManager.GetShowNumber(self._haveCurrencyNum))
  if self._haveCurrencyNum < self._exchangeNum then
    self:OnMaxBtnClicked()
  end
end

function ExchangeDialog:OnSubBtnClicked()
  if self._exchangeNum - self._callOnceNum > 0 then
    self._exchangeNum = self._exchangeNum - self._callOnceNum
  end
  self:RefreshShowData()
end

function ExchangeDialog:OnAddBtnClicked()
  if self._exchangeNum + self._callOnceNum <= self._haveCurrencyNum then
    self._exchangeNum = self._exchangeNum + self._callOnceNum
  end
  self:RefreshShowData()
end

function ExchangeDialog:OnMaxBtnClicked()
  self._exchangeNum = self._haveCurrencyNum // self._callOnceNum * self._callOnceNum
  self:RefreshShowData()
end

function ExchangeDialog:OnConfirmBtnClicked()
  if self._exchangeNum < self._callOnceNum then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100440)
    return
  end
  self._bm:SendCChristmasSupport(self._exchangeNum)
  self:Destroy()
end

return ExchangeDialog
