-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/midautumn/exchangedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Rate = tonumber((((BeanManager.GetTableByName)("var.cvarconfig")):GetRecorder(111)).Value)
local CActivityExchange = require("protocols.def.protocol.activity.cactivityexchange")
local Item = require("logic.manager.experimental.types.item")
local ExchangeDialog = class("ExchangeDialog", Dialog)
ExchangeDialog.AssetBundleName = "ui/layouts.activitymidautumn"
ExchangeDialog.AssetName = "ActivityMidAutumnMainItemBuy"
ExchangeDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ExchangeDialog
  ((ExchangeDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
end

ExchangeDialog.OnCreate = function(self)
  -- function num : 0_1
  self._numTxt = self:GetChild("Image/Back/Num/Num")
  self._addBtn = self:GetChild("Image/Back/Num/AddBtn")
  self._maxBtn = self:GetChild("Image/Back/Num/MaxBtn")
  self._minusBtn = self:GetChild("Image/Back/Num/MinusBtn")
  self._costTxt = self:GetChild("Image/Back/CostBack/Txt2")
  self._costTxtRed = self:GetChild("Image/Back/CostBack/Txt3")
  self._cancelButton = self:GetChild("Image/Back/CancelButton")
  self._confirmButton = self:GetChild("Image/Back/ConfirmButton")
  ;
  (self._addBtn):Subscribe_PointerClickEvent(self.OnAddBtnClicked, self)
  ;
  (self._maxBtn):Subscribe_PointerClickEvent(self.OnMaxBtnClicked, self)
  ;
  (self._minusBtn):Subscribe_PointerClickEvent(self.OnMinusBtnClicked, self)
  ;
  (self._cancelButton):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._confirmButton):Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  self._title = self:GetChild("Image/Back/Title")
  self._exchange_text = self:GetChild("Image/Back/Text2")
  self._cost_text = self:GetChild("Image/Back/CostBack/Txt1")
  self._tips = self:GetChild("Image/Back/Text1")
  self._itemIcon = self:GetChild("Image/Back/CostBack/Spirit")
end

ExchangeDialog.OnDestroy = function(self)
  -- function num : 0_2
end

local Refresh = function(self)
  -- function num : 0_3 , upvalues : Rate, _ENV
  (self._numTxt):SetText(self._exchangeTimes)
  local num = self._exchangeTimes * Rate
  ;
  (self._minusBtn):SetInteractable(self._exchangeTimes > 1)
  if ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum((self._record).MoneyId) < num then
    (self._costTxt):SetActive(false)
    ;
    (self._costTxtRed):SetActive(true)
    ;
    (self._costTxtRed):SetText(num)
  else
    (self._costTxt):SetActive(true)
    ;
    (self._costTxtRed):SetActive(false)
    ;
    (self._costTxt):SetText(num)
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

ExchangeDialog.SetRecord = function(self, record)
  -- function num : 0_4 , upvalues : Item, _ENV
  self._record = record
  self._item = (Item.Create)((self._record).MoneyId)
  ;
  (self._title):SetText((string.gsub)((TextManager.GetText)(((self._record).WordId)[7]), "%$parameter1%$", (self._item):GetName()))
  ;
  (self._exchange_text):SetText((TextManager.GetText)(((self._record).WordId)[8]))
  ;
  (self._cost_text):SetText((TextManager.GetText)(((self._record).WordId)[9]))
  ;
  (self._tips):SetText((string.gsub)((TextManager.GetText)(((self._record).WordId)[10]), "%$parameter1%$", (self._item):GetName()))
  local imageRecord = (self._item):GetIcon()
  ;
  (self._itemIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self:Init()
end

ExchangeDialog.Init = function(self)
  -- function num : 0_5 , upvalues : Refresh
  self._exchangeTimes = 1
  Refresh(self)
end

ExchangeDialog.OnMinusBtnClicked = function(self)
  -- function num : 0_6 , upvalues : Refresh
  if self._exchangeTimes > 1 then
    self._exchangeTimes = self._exchangeTimes - 1
  end
  Refresh(self)
end

ExchangeDialog.OnAddBtnClicked = function(self)
  -- function num : 0_7 , upvalues : Rate, _ENV, Refresh
  local num = self._exchangeTimes + 1
  if ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum((self._record).MoneyId) < num * Rate then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100378, {(self._item):GetName()})
    return 
  end
  self._exchangeTimes = num
  Refresh(self)
end

ExchangeDialog.OnMaxBtnClicked = function(self)
  -- function num : 0_8 , upvalues : _ENV, Rate, Refresh
  local num = (math.floor)(((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum((self._record).MoneyId) / Rate)
  if num > 1 then
    self._exchangeTimes = num
  else
    self._exchangeTimes = 1
  end
  Refresh(self)
end

ExchangeDialog.OnBackBtnClicked = function(self)
  -- function num : 0_9
  self:Destroy()
end

ExchangeDialog.OnConfirmBtnClicked = function(self)
  -- function num : 0_10 , upvalues : Rate, _ENV, CActivityExchange
  if self._sendProtocol then
    return 
  end
  if ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum((self._record).MoneyId) < self._exchangeTimes * Rate then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100378, {(self._item):GetName()})
    return 
  end
  local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.cactivityexchange")
  protocol.activityId = (self._record).id
  protocol.exchangeType = CActivityExchange.EXCHANGE
  protocol.exchangeNum = self._exchangeTimes
  protocol:Send()
  self._sendProtocol = true
  LogInfoFormat("ExchangeDialog", "activityId = %s, exchangeType = %s", protocol.activityId, protocol.exchangeType)
end

return ExchangeDialog

