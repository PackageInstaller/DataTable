local CBossNianRankAP = BeanManager.GetTableByName("activity.cbossnianrankap")
local CTimedActivitySwitch = BeanManager.GetTableByName("activity.ctimedactivityswitch")
local SpringUnlockRecord = CTimedActivitySwitch:GetRecorder(25001)
local timeutils = require("logic.utils.timeutils")
local BossIntoTabCell = class("BossIntoTabCell", Dialog)
BossIntoTabCell.AssetBundleName = "ui/layouts.activitynewyear"
BossIntoTabCell.AssetName = "ActivityNewYearInto"

function BossIntoTabCell:Ctor(...)
  BossIntoTabCell.super.Ctor(self, ...)
end

function BossIntoTabCell:OnCreate()
  self._gotoBtn = self:GetChild("GotoBtn")
  self._activeTime = self:GetChild("ActiveTime")
  self._gotoBtn:Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  self._tips = self:GetChild("Tips")
  self._tips:Subscribe_PointerClickEvent(self.OnTipBtnClicked, self)
  self._gotoBtnDot = self:GetChild("GotoBtn/Dot")
  LuaNotificationCenter.AddObserver(self, self.OnSSpringBossState, Common.n_SSpringBossState)
  LuaNotificationCenter.AddObserver(self, self.RefreshRedDot, Common.n_RefreshSpringFestivalRedDot, nil)
end

function BossIntoTabCell:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function BossIntoTabCell:SetData()
  self._activeTime:SetText(TextManager.GetText(701677))
  self:RefreshRedDot()
end

function BossIntoTabCell:RefreshRedDot()
  self._gotoBtnDot:SetActive(NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SpringFestivalActivityManagerID):ShowBossRedPoint())
end

function BossIntoTabCell:OnTipBtnClicked()
  DialogManager.CreateSingletonDialog("activity.springfestival.tipsdialog"):SetData(701661, CBossNianRankAP:GetRecorder(1).rankForReward)
end

function BossIntoTabCell:OnGoBtnClicked()
  self._endTime = timeutils.GetConfigFormatTimeStamp(SpringUnlockRecord.closeTime)
  if ServerGameTimer.GetServerTime() > self._endTime then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100455)
    return
  end
  local csend = LuaNetManager.CreateProtocol("protocol.activity.cspringbossstate")
  csend:Send()
end

function BossIntoTabCell:OnSSpringBossState()
  DialogManager.CreateSingletonDialog("activity.springfestival.bossmaindialog"):SetData()
end

return BossIntoTabCell
