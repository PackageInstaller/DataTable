-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/chrismascall/exchangedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local ExchangeDialog = class("ExchangeDialog", Dialog)
ExchangeDialog.AssetBundleName = "ui/layouts.activitychristmascall"
ExchangeDialog.AssetName = "ActivityChristmasCallItemBuy"
ExchangeDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ExchangeDialog
  ((ExchangeDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
  self._exchangeNum = 1
end

ExchangeDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
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
  -- function num : 0_3 , upvalues : _ENV, CStringRes
  (self._contentText3):SetText((TextManager.GetText)((CStringRes:GetRecorder(1672)).msgTextID))
end

ExchangeDialog.OnBackBtnClicked = function(self)
  -- function num : 0_4
  self:Destroy()
end

ExchangeDialog.SetData = function(self)
  -- function num : 0_5 , upvalues : _ENV
  self._dm = ((NekoData.DataManager).DM_Activity):GetManager(DataCommon.ChristmasCallActivityManagerID)
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.ChristmasCallActivityManagerID)
  self._callOnceNum = (((self._bm):GetCChristmasCallCfg()):GetRecorder(1)).callNum
  self._convertNum = (((self._bm):GetCChristmasCallCfg()):GetRecorder(1)).convertNum
  self._exchangeNum = self._callOnceNum
  self:RefreshShowData()
  self:RefreshCurrencyData()
end

ExchangeDialog.RefreshShowData = function(self)
  -- function num : 0_6 , upvalues : _ENV, CStringRes
  (self._contentText1):SetText((TextManager.GetText)((CStringRes:GetRecorder(1677)).msgTextID, self._exchangeNum))
  ;
  (self._contentText4):SetText((TextManager.GetText)((CStringRes:GetRecorder(1687)).msgTextID, self._exchangeNum * self._convertNum))
  ;
  (self._nowNum):SetText(self._exchangeNum)
end

ExchangeDialog.RefreshCurrencyData = function(self)
  -- function num : 0_7 , upvalues : _ENV
  self._haveCurrencyNum = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.ChrismasCallStick)
  ;
  (self._nowHaveText):SetText((NumberManager.GetShowNumber)(self._haveCurrencyNum))
  if self._haveCurrencyNum < self._exchangeNum then
    self:OnMaxBtnClicked()
  end
end

ExchangeDialog.OnSubBtnClicked = function(self)
  -- function num : 0_8
  if self._exchangeNum - self._callOnceNum > 0 then
    self._exchangeNum = self._exchangeNum - self._callOnceNum
  end
  self:RefreshShowData()
end

ExchangeDialog.OnAddBtnClicked = function(self)
  -- function num : 0_9
  if self._exchangeNum + self._callOnceNum <= self._haveCurrencyNum then
    self._exchangeNum = self._exchangeNum + self._callOnceNum
  end
  self:RefreshShowData()
end

ExchangeDialog.OnMaxBtnClicked = function(self)
  -- function num : 0_10
  self._exchangeNum = self._haveCurrencyNum // self._callOnceNum * self._callOnceNum
  self:RefreshShowData()
end

ExchangeDialog.OnConfirmBtnClicked = function(self)
  -- function num : 0_11 , upvalues : _ENV
  if self._exchangeNum < self._callOnceNum then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100440)
    return 
  end
  ;
  (self._bm):SendCChristmasSupport(self._exchangeNum)
  self:Destroy()
end

return ExchangeDialog

