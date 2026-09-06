local Rate = tonumber(BeanManager.GetTableByName("var.cvarconfig"):GetRecorder(111).Value)
local CActivityExchange = require("protocols.def.protocol.activity.cactivityexchange")
local Item = require("logic.manager.experimental.types.item")
local ExchangeDialog = class("ExchangeDialog", Dialog)
ExchangeDialog.AssetBundleName = "ui/layouts.activitymidautumn"
ExchangeDialog.AssetName = "ActivityMidAutumnMainItemBuy"

function ExchangeDialog:Ctor(...)
  ExchangeDialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
end

function ExchangeDialog:OnCreate()
  self._numTxt = self:GetChild("Image/Back/Num/Num")
  self._addBtn = self:GetChild("Image/Back/Num/AddBtn")
  self._maxBtn = self:GetChild("Image/Back/Num/MaxBtn")
  self._minusBtn = self:GetChild("Image/Back/Num/MinusBtn")
  self._costTxt = self:GetChild("Image/Back/CostBack/Txt2")
  self._costTxtRed = self:GetChild("Image/Back/CostBack/Txt3")
  self._cancelButton = self:GetChild("Image/Back/CancelButton")
  self._confirmButton = self:GetChild("Image/Back/ConfirmButton")
  self._addBtn:Subscribe_PointerClickEvent(self.OnAddBtnClicked, self)
  self._maxBtn:Subscribe_PointerClickEvent(self.OnMaxBtnClicked, self)
  self._minusBtn:Subscribe_PointerClickEvent(self.OnMinusBtnClicked, self)
  self._cancelButton:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._confirmButton:Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  self._title = self:GetChild("Image/Back/Title")
  self._exchange_text = self:GetChild("Image/Back/Text2")
  self._cost_text = self:GetChild("Image/Back/CostBack/Txt1")
  self._tips = self:GetChild("Image/Back/Text1")
  self._itemIcon = self:GetChild("Image/Back/CostBack/Spirit")
end

function ExchangeDialog:OnDestroy()
end

local function Refresh(self)
  self._numTxt:SetText(self._exchangeTimes)
  local num = self._exchangeTimes * Rate
  self._minusBtn:SetInteractable(self._exchangeTimes > 1)
  if num > NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(self._record.MoneyId) then
    self._costTxt:SetActive(false)
    self._costTxtRed:SetActive(true)
    self._costTxtRed:SetText(num)
  else
    self._costTxt:SetActive(true)
    self._costTxtRed:SetActive(false)
    self._costTxt:SetText(num)
  end
end

function ExchangeDialog:SetRecord(record)
  self._record = record
  self._item = Item.Create(self._record.MoneyId)
  self._title:SetText(string.gsub(TextManager.GetText(self._record.WordId[7]), "%$parameter1%$", self._item:GetName()))
  self._exchange_text:SetText(TextManager.GetText(self._record.WordId[8]))
  self._cost_text:SetText(TextManager.GetText(self._record.WordId[9]))
  self._tips:SetText(string.gsub(TextManager.GetText(self._record.WordId[10]), "%$parameter1%$", self._item:GetName()))
  local imageRecord = self._item:GetIcon()
  self._itemIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self:Init()
end

function ExchangeDialog:Init()
  self._exchangeTimes = 1
  Refresh(self)
end

function ExchangeDialog:OnMinusBtnClicked()
  if self._exchangeTimes > 1 then
    self._exchangeTimes = self._exchangeTimes - 1
  end
  Refresh(self)
end

function ExchangeDialog:OnAddBtnClicked()
  local num = self._exchangeTimes + 1
  if num * Rate > NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(self._record.MoneyId) then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100378, {
      self._item:GetName()
    })
    return
  end
  self._exchangeTimes = num
  Refresh(self)
end

function ExchangeDialog:OnMaxBtnClicked()
  local num = math.floor(NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(self._record.MoneyId) / Rate)
  if 1 < num then
    self._exchangeTimes = num
  else
    self._exchangeTimes = 1
  end
  Refresh(self)
end

function ExchangeDialog:OnBackBtnClicked()
  self:Destroy()
end

function ExchangeDialog:OnConfirmBtnClicked()
  if self._sendProtocol then
    return
  end
  if self._exchangeTimes * Rate > NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(self._record.MoneyId) then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100378, {
      self._item:GetName()
    })
    return
  end
  local protocol = LuaNetManager.CreateProtocol("protocol.activity.cactivityexchange")
  protocol.activityId = self._record.id
  protocol.exchangeType = CActivityExchange.EXCHANGE
  protocol.exchangeNum = self._exchangeTimes
  protocol:Send()
  self._sendProtocol = true
  LogInfoFormat("ExchangeDialog", "activityId = %s, exchangeType = %s", protocol.activityId, protocol.exchangeType)
end

return ExchangeDialog
