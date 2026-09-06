local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local TaskStatus = LuaNetManager.CreateBean("protocol.task.taskstatus")
local scoreAddTime = 2
local scoreAddStep = 1
local Sheet2 = class("Sheet2", Dialog)
Sheet2.AssetBundleName = "ui/layouts.activitychristmascall"
Sheet2.AssetName = "ActivityChristmasCall"

function Sheet2:Ctor(...)
  Sheet2.super.Ctor(self, ...)
end

function Sheet2:OnCreate()
  self._tipsBtn = self:GetChild("Tips")
  self._tipsBtn:Subscribe_PointerClickEvent(self.OnTipsBtnClicked, self)
  self._currencyItemPanel = self:GetChild("ItemBack")
  self._currencyItemImage = self:GetChild("ItemBack/Icon")
  self._currencyItemNum = self:GetChild("ItemBack/Text")
  self._currencyItemAddBtn = self:GetChild("ItemBack/Add")
  self._currencyItemPanel:Subscribe_PointerClickEvent(self.OnCurrencyItemClicked, self)
  self._currencyItemAddBtn:Subscribe_PointerClickEvent(self.OnCurrencyItemAddBtnClicked, self)
  self._callBtn = self:GetChild("GetBtn")
  self._progressBtn = self:GetChild("TaskBtn")
  self._rankBtn = self:GetChild("RankBtn")
  self._awardBtn = self:GetChild("AwardBtn")
  self._progressBtnReddot = self:GetChild("RedDot")
  self._callBtnText = self:GetChild("GetBtn/_Text")
  self._awardBtnText = self:GetChild("AwardBtn/_Text")
  self._rankBtnText = self:GetChild("RankBtn/_Text")
  self._progressBtnText = self:GetChild("TaskBtn/_Text")
  self._callBtn:Subscribe_PointerClickEvent(self.OnCallBtnClicked, self)
  self._progressBtn:Subscribe_PointerClickEvent(self.OnProgressBtnClicked, self)
  self._awardBtn:Subscribe_PointerClickEvent(self.OnAwardBtnClicked, self)
  self._rankBtn:Subscribe_PointerClickEvent(self.OnRankBtnClicked, self)
  self._callScoreTitle = self:GetChild("Text")
  self._callScore = self:GetChild("Text/Num")
  self._activityEndTimeTitle = self:GetChild("EndTime")
  self._activityEndTime = self:GetChild("CloseTime")
  self._countDownTitle = self:GetChild("CountDown")
  self._countDown = self:GetChild("Time")
  self._countDownBack = self:GetChild("CountDownBack")
  self._callBtnTextEffect = self:GetChild("GetBtn/UI_TX_Prefab_GuideClick_alone")
  self._nowCallStickAndMax = self:GetChild("MaxText")
  LuaNotificationCenter.AddObserver(self, self.RefreshCurrencyData, Common.n_RefreshCurrency, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshCurrencyData, Common.n_RefreshActivities, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshNowScoreData, Common.n_OnSChristmasSupport, nil)
  LuaNotificationCenter.AddObserver(self, self.SetCountDownData, Common.n_OnSOpenChristmasSupportActivity, nil)
  LuaNotificationCenter.AddObserver(self, self.SetSettleData, Common.n_OnSSettleChristmasSupport, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshReddot, Common.n_OnSChristmasSupportRedpoint, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshReddot, Common.n_OnLocalRefreshChristmasSupportRedpoint, nil)
  LuaNotificationCenter.AddObserver(self, self.OnSCheckGainNumber, Common.n_OnSCheckGainNumber, nil)
  self:SetStaticRes()
end

function Sheet2:SetStaticRes()
  self._currencyItem = Item.Create(DataCommon.ChrismasCallStick)
  local imageRecord = self._currencyItem:GetIcon()
  self._currencyItemImage:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._progressBtnText:SetText(TextManager.GetText(CStringRes:GetRecorder(1676).msgTextID))
  self._callBtnText:SetText(TextManager.GetText(CStringRes:GetRecorder(1675).msgTextID))
  self._rankBtnText:SetText(TextManager.GetText(CStringRes:GetRecorder(1674).msgTextID))
  self._awardBtnText:SetText(TextManager.GetText(CStringRes:GetRecorder(1678).msgTextID))
  self._countDownTitle:SetText(TextManager.GetText(CStringRes:GetRecorder(1673).msgTextID))
  self._activityEndTimeTitle:SetText(TextManager.GetText(CStringRes:GetRecorder(1666).msgTextID))
  self._activityEndTime:SetText(TextManager.GetText(CStringRes:GetRecorder(1667).msgTextID))
  self._callScoreTitle:SetText(TextManager.GetText(CStringRes:GetRecorder(1672).msgTextID))
end

function Sheet2:OnDestroy()
  if self._scoreAddTimer then
    GameTimer.RemoveTask(self._scoreAddTimer)
  end
end

function Sheet2:SetData()
  self._dm = NekoData.DataManager.DM_Activity:GetManager(DataCommon.ChristmasCallActivityManagerID)
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.ChristmasCallActivityManagerID)
  self:RefreshCurrencyData()
  self:SetNowScoreData()
  self:SetCountDownData()
  self:SetSettleData()
  self:RefreshReddot()
  self:SetMaxCallStickData()
end

function Sheet2:RefreshCurrencyData()
  local currencyNum = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.ChrismasCallStick)
  self._currencyItemNum:SetText(NumberManager.GetShowNumber(currencyNum))
  self._currencyItemAddBtn:SetActive(NekoData.BehaviorManager.BM_Activity:IsActivityOpen(DataCommon.Activities.Christmas))
  local callOnceNum = self._bm:GetCChristmasCallCfg():GetRecorder(1).callNum
  self._callBtnTextEffect:SetActive(currencyNum >= callOnceNum)
end

function Sheet2:SetNowScoreData()
  if self._scoreAddTimer then
    GameTimer.RemoveTask(self._scoreAddTimer)
  end
  self._preScore = self._bm:GetNowScore()
  self._nowScore = self._bm:GetNowScore()
  self._callScore:SetText(self._nowScore)
end

function Sheet2:RefreshNowScoreData(notification)
  local protocol = notification.userInfo
  local voiceID = self._bm:GetRandomCallVoiceID()
  LuaAudioManager.PlayVoice(voiceID)
  if protocol.num > 100 then
    self._callBtn:PlayAnimation("Effect03")
  elseif protocol.num > 50 then
    self._callBtn:PlayAnimation("Effect02")
  elseif protocol.num > 10 then
    self._callBtn:PlayAnimation("Effect01")
  end
  if self._scoreAddTimer then
    GameTimer.RemoveTask(self._scoreAddTimer)
  end
  self._nowScore = self._bm:GetNowScore()
  local period = scoreAddTime / ((self._nowScore - self._preScore) / scoreAddStep)
  self._scoreAddTimer = GameTimer.AddTask(0, period, function()
    self._preScore = self._preScore + scoreAddStep
    if self._preScore >= self._nowScore then
      self._preScore = self._nowScore
      GameTimer.RemoveTask(self._scoreAddTimer)
    end
    self._callScore:SetText(self._preScore)
  end, nil)
end

function Sheet2:SetCountDownData()
  local leftState, showStr = self._bm:GetCallLeftTimeState()
  if leftState ~= -1 and self._bm:GetCanCall() then
    self._countDownTitle:SetActive(true)
    self._countDown:SetActive(true)
    self._countDownBack:SetActive(true)
    self._countDown:SetText(showStr)
  else
    self._countDownTitle:SetActive(false)
    self._countDown:SetActive(false)
    self._countDownBack:SetActive(false)
  end
end

function Sheet2:SetSettleData()
  local settleState = self._bm:GetSettleState()
  self._awardBtn:SetActive(settleState == 1)
end

function Sheet2:OnCurrencyItemClicked()
  local width, height = self._currencyItemPanel:GetRectSize()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._currencyItem
    })
    tipsDialog:SetTipsPosition(width, height, self._currencyItemPanel:GetLocalPointInUiRootPanel())
  end
end

function Sheet2:OnCurrencyItemAddBtnClicked()
  if NekoData.BehaviorManager.BM_Activity:IsActivityOpen(DataCommon.Activities.Christmas) then
    local protocol = LuaNetManager.CreateProtocol("protocol.activity.cgetchristmasactivityinfo")
    if protocol then
      protocol:Send()
    end
    DialogManager.DestroySingletonDialog("activity.chrismascall.maindialog")
  end
end

function Sheet2:OnCallBtnClicked()
  if not self._bm:GetCanCall() then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100438)
    return
  end
  local dialog = DialogManager.CreateSingletonDialog("activity.chrismascall.exchangedialog")
  if dialog then
    dialog:SetData(self._allRewardsLen)
  end
end

function Sheet2:OnProgressBtnClicked()
  local dialog = DialogManager.CreateSingletonDialog("activity.chrismascall.callprogressdialog")
  return dialog
end

function Sheet2:OnRankBtnClicked()
  DialogManager.CreateSingletonDialog("activity.chrismascall.callrankdialog")
end

function Sheet2:OnAwardBtnClicked()
  self._bm:KillRedDot(self._bm:GetSChristmasSupportRedPointDef().RANKING)
  LuaNotificationCenter.PostNotification(Common.n_OnLocalRefreshChristmasSupportRedpoint, nil, nil)
  local awardType = self._bm:GetSChristmasSupportRedPointDef().RANKING
  self._bm:SendCReceiveSupportReward(awardType, 0)
end

function Sheet2:OnTipsBtnClicked()
  local dialogName = "activity.chrismascall.tipsdialog"
  local dialog = DialogManager.CreateSingletonDialog(dialogName)
  if dialog then
    dialog:SetData(CStringRes:GetRecorder(1668).msgTextID, CStringRes:GetRecorder(1669).msgTextID)
  end
end

function Sheet2:RefreshReddot()
  self._progressBtnReddot:SetActive(self._bm:GetRedDot(self._bm:GetSChristmasSupportRedPointDef().TOTAL_CALL) or self._bm:GetRedDot(self._bm:GetSChristmasSupportRedPointDef().STAGE))
end

function Sheet2:SetMaxCallStickData()
  self._maxCallStickNum = self._bm:GetCChristmasCallCfg():GetRecorder(1).maxReward
  if self._maxCallStickNum >= 0 then
    self._bm:SendCheckGainNumber()
  else
    self._nowCallStickAndMax:SetActive(false)
  end
end

function Sheet2:OnSCheckGainNumber(notification)
  local nowCallStickNum = self._bm:GetNowGainCallNum()
  if nowCallStickNum == -1 then
    self._nowCallStickAndMax:SetActive(false)
  else
    self._nowCallStickAndMax:SetActive(true)
    local nowCallStickNumInThere = math.min(nowCallStickNum, self._maxCallStickNum)
    self._nowCallStickAndMax:SetText(TextManager.GetText(CStringRes:GetRecorder(1707).msgTextID, nowCallStickNumInThere, self._maxCallStickNum))
  end
end

return Sheet2
