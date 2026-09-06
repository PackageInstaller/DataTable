local HalloweenExchangeDialog = class("HalloweenExchangeDialog", Dialog)
local CStringRes = BeanManager.GetTableByName("message.cstringres")
HalloweenExchangeDialog.AssetBundleName = "ui/layouts.activityhalloween"
HalloweenExchangeDialog.AssetName = "ActivityHalloweenMainItemBuy"

function HalloweenExchangeDialog:Ctor(...)
  HalloweenExchangeDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
  self._exchangeNum = 1
end

function HalloweenExchangeDialog:OnCreate()
  self._contentText = self:GetChild("Image/Back/Text1")
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
end

function HalloweenExchangeDialog:OnDestroy()
end

function HalloweenExchangeDialog:OnBackBtnClicked()
  self:Destroy()
end

function HalloweenExchangeDialog:SetData(allRewardsLen)
  self._allRewardsLen = allRewardsLen
  self:RefreshShowData()
  self:RefreshCurrencyData()
end

function HalloweenExchangeDialog:RefreshShowData()
  self._contentText:SetText(TextManager.GetText(CStringRes:GetRecorder(1629).msgTextID, self._exchangeNum))
  self._nowNum:SetText(self._exchangeNum)
end

function HalloweenExchangeDialog:RefreshCurrencyData()
  self._havePumpkinPieNum = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.PumpkinPie)
  self._nowHaveText:SetText(NumberManager.GetShowNumber(self._havePumpkinPieNum))
  if math.min(self._havePumpkinPieNum, self._allRewardsLen) < self._exchangeNum then
    self:OnMaxBtnClicked()
  end
end

function HalloweenExchangeDialog:OnSubBtnClicked()
  if self._exchangeNum > 1 then
    self._exchangeNum = self._exchangeNum - 1
  end
  self:RefreshShowData()
end

function HalloweenExchangeDialog:OnAddBtnClicked()
  if self._exchangeNum < math.min(self._havePumpkinPieNum, self._allRewardsLen) then
    self._exchangeNum = self._exchangeNum + 1
  end
  self:RefreshShowData()
end

function HalloweenExchangeDialog:OnMaxBtnClicked()
  self._exchangeNum = math.min(self._havePumpkinPieNum, self._allRewardsLen)
  self:RefreshShowData()
end

function HalloweenExchangeDialog:OnConfirmBtnClicked()
  if self._exchangeNum <= 0 then
    if self._allRewardsLen == 0 then
      NekoData.BehaviorManager.BM_Message:SendMessageById(100401)
    else
      NekoData.BehaviorManager.BM_Message:SendMessageById(100403)
    end
    return
  end
  local protocol = LuaNetManager.CreateProtocol("protocol.activity.cactivityexchange")
  if protocol then
    protocol.activityId = DataCommon.Activities.Halloween
    protocol.exchangeNum = self._exchangeNum
    protocol.exchangeType = protocol.EXCHANGE
    protocol:Send()
  end
  self:Destroy()
end

return HalloweenExchangeDialog
