-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/springfestival/bossintotabcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CBossNianRankAP = (BeanManager.GetTableByName)("activity.cbossnianrankap")
local CTimedActivitySwitch = (BeanManager.GetTableByName)("activity.ctimedactivityswitch")
local SpringUnlockRecord = CTimedActivitySwitch:GetRecorder(25001)
local timeutils = require("logic.utils.timeutils")
local BossIntoTabCell = class("BossIntoTabCell", Dialog)
BossIntoTabCell.AssetBundleName = "ui/layouts.activitynewyear"
BossIntoTabCell.AssetName = "ActivityNewYearInto"
BossIntoTabCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BossIntoTabCell
  ((BossIntoTabCell.super).Ctor)(self, ...)
end

BossIntoTabCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._gotoBtn = self:GetChild("GotoBtn")
  self._activeTime = self:GetChild("ActiveTime")
  ;
  (self._gotoBtn):Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  self._tips = self:GetChild("Tips")
  ;
  (self._tips):Subscribe_PointerClickEvent(self.OnTipBtnClicked, self)
  self._gotoBtnDot = self:GetChild("GotoBtn/Dot")
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSSpringBossState, Common.n_SSpringBossState)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshRedDot, Common.n_RefreshSpringFestivalRedDot, nil)
end

BossIntoTabCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

BossIntoTabCell.SetData = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (self._activeTime):SetText((TextManager.GetText)(701677))
  self:RefreshRedDot()
end

BossIntoTabCell.RefreshRedDot = function(self)
  -- function num : 0_4 , upvalues : _ENV
  (self._gotoBtnDot):SetActive((((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SpringFestivalActivityManagerID)):ShowBossRedPoint())
end

BossIntoTabCell.OnTipBtnClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV, CBossNianRankAP
  ((DialogManager.CreateSingletonDialog)("activity.springfestival.tipsdialog")):SetData(701661, (CBossNianRankAP:GetRecorder(1)).rankForReward)
end

BossIntoTabCell.OnGoBtnClicked = function(self)
  -- function num : 0_6 , upvalues : timeutils, SpringUnlockRecord, _ENV
  self._endTime = (timeutils.GetConfigFormatTimeStamp)(SpringUnlockRecord.closeTime)
  if self._endTime < (ServerGameTimer.GetServerTime)() then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100455)
    return 
  end
  local csend = (LuaNetManager.CreateProtocol)("protocol.activity.cspringbossstate")
  csend:Send()
end

BossIntoTabCell.OnSSpringBossState = function(self)
  -- function num : 0_7 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("activity.springfestival.bossmaindialog")):SetData()
end

return BossIntoTabCell

