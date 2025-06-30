-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/giftoftime/killbosspage.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local TableFrame = require("framework.ui.frame.table.tableframe")
local Role = require("logic.manager.experimental.types.role")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local KillBossPage = class("KillBossPage", Dialog)
local charNumber = 1
KillBossPage.AssetBundleName = "ui/layouts.battlepassnew"
KillBossPage.AssetName = "BattlePassNewBossRush"
KillBossPage.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : KillBossPage, _ENV
  ((KillBossPage.super).Ctor)(self, ...)
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.GiftOfTimeActivityManagerID)
  self._sendStartBattleProtocol = false
  self._havePlayIntoAnimation = false
  self._canShowItemGotten = false
  self._battleShowOver = false
  self._curId = 0
end

KillBossPage.OnCreate = function(self)
  -- function num : 0_1 , upvalues : charNumber, _ENV, TableFrame
  self._panel = self:GetChild("MonFrame")
  self._time = self:GetChild("EndTime")
  self._tipBtn = self:GetChild("Tip")
  self._char = {}
  for i = 1, charNumber do
    do
      -- DECOMPILER ERROR at PC20: Confused about usage of register: R5 in 'UnsetPending'

      (self._char)[i] = {}
      -- DECOMPILER ERROR at PC30: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._char)[i]).panel = self:GetChild("CharCell" .. tostring(i))
      -- DECOMPILER ERROR at PC41: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._char)[i]).level = self:GetChild("CharCell" .. tostring(i) .. "/Level")
      -- DECOMPILER ERROR at PC52: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._char)[i]).headImg = self:GetChild("CharCell" .. tostring(i) .. "/HeadPhoto")
      -- DECOMPILER ERROR at PC63: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._char)[i]).healthTxt = self:GetChild("CharCell" .. tostring(i) .. "/Health/HealthNum")
      -- DECOMPILER ERROR at PC74: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._char)[i]).attackTxt = self:GetChild("CharCell" .. tostring(i) .. "/Attack/AttackNum")
      -- DECOMPILER ERROR at PC85: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._char)[i]).redDot = self:GetChild("CharCell" .. tostring(i) .. "/Dot")
      ;
      (((self._char)[i]).panel):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnCharPanelClicked(i)
  end
, self)
    end
  end
  self._curNumTxt = self:GetChild("MoneyCell/Num1")
  self._curMaxNumTxt = self:GetChild("MoneyCell/Num2")
  self._moneyBack = self:GetChild("MoneyCell")
  ;
  (self:GetChild("MoneyCell/Text")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1972))
  ;
  (self:GetChild("Tip/Text")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1924))
  self._dailyTaskBtn = self:GetChild("DailyTask")
  self._startBattleBtn = self:GetChild("StartBattle")
  self._weeklyRewardBtn = self:GetChild("WeeklyReward")
  self._leftTime = self:GetChild("EndTime")
  self._startBattleBtn_Text = self:GetChild("StartBattle/Text")
  self._weeklyRewardBtn_Text = self:GetChild("WeeklyReward/Text")
  self._dailyTaskBtn_Text = self:GetChild("DailyTask/Text")
  self._weeklyRewardBtn_Dot = self:GetChild("WeeklyReward/Dot")
  self._dailyTaskBtn_Dot = self:GetChild("DailyTask/Dot")
  self._rightBtn = self:GetChild("RightBtn")
  self._leftBtn = self:GetChild("LeftBtn")
  self._progress = self:GetChild("MoneyCell/BackGround/Progress")
  ;
  (self._tipBtn):Subscribe_PointerClickEvent(self.OnTipBtnClicked, self)
  ;
  (self._dailyTaskBtn):Subscribe_PointerClickEvent(self.OnDailyTaskClicked, self)
  ;
  (self._startBattleBtn):Subscribe_PointerClickEvent(self.OnStartBattleClicked, self)
  ;
  (self._weeklyRewardBtn):Subscribe_PointerClickEvent(self.OnWeeklyRewardBtnClicked, self)
  self._frame = (TableFrame.Create)(self._panel, self, false)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRoleLevelUp, Common.n_SWitchInAgainstBossUpLv, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnEndBattle, Common.n_SEndAgainstBossBattle, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.Refresh, Common.n_SReturnAgainstBossInfo, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRoleLevelUp, Common.n_RefreshCurrency, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshTaskRedDot, Common.n_NewDreamSpiralTaskRefresh, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshChipInfo, Common.n_NewDreamSpiralRefresh, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnDialogDestroy, Common.n_DialogWillDestroy, nil)
  ;
  (self._startBattleBtn_Text):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1950))
  ;
  (self._dailyTaskBtn_Text):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1948))
  ;
  (self._weeklyRewardBtn_Text):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1949))
end

KillBossPage.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (DialogManager.DestroySingletonDialog)("bag.itemtipsdialog")
  ;
  (DialogManager.DestroySingletonDialog)("activity.giftoftime.killbosstaskdialog")
  ;
  (DialogManager.DestroySingletonDialog)("activity.giftoftime.killbossawarddialog")
  if self._frame then
    (self._frame):Destroy()
  end
end

KillBossPage.Refresh = function(self)
  -- function num : 0_3 , upvalues : _ENV
  self._leftTimeData = (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.GiftOfTimeActivityManagerID)):GetWeeklyLeftTime()
  self:UpdateLeftTime()
  if self._timerId ~= 0 then
    (GameTimer.RemoveTask)(self._timerId)
    self._timerId = 0
  end
  self._timerId = (GameTimer.AddTask)(1, 1, self.UpdateLeftTime, self)
  ;
  (self._weeklyRewardBtn_Dot):SetActive((self._bm):HasWeekAward())
  self._dailyTaskBtn_Dot = self:GetChild("DailyTask/Dot")
  self._curBossId = (self._bm):GetCurChallengingId()
  self:RefreshCharInfo()
  self:RefreshTaskRedDot()
  self:RefreshChipInfo()
  self:RefreshMonsterInfo()
end

KillBossPage.RefreshChipInfo = function(self)
  -- function num : 0_4 , upvalues : _ENV
  self._info = (self._bm):GetBaseInfo()
  local chipInfo = (self._info).chipInfo
  if chipInfo then
    (self._moneyBack):SetActive(true)
    ;
    (self._curNumTxt):SetText(tostring(chipInfo.has))
    ;
    (self._curMaxNumTxt):SetText(tostring(chipInfo.max))
    ;
    (self._progress):SetFillAmount(chipInfo.has / chipInfo.max)
  else
    ;
    (self._moneyBack):SetActive(false)
    LogWarning("nil chipinfo")
  end
end

KillBossPage.RefreshTaskRedDot = function(self)
  -- function num : 0_5
  (self._dailyTaskBtn_Dot):SetActive((self._bm):HasTasksAward())
end

KillBossPage.RefreshCharInfo = function(self)
  -- function num : 0_6 , upvalues : charNumber, _ENV, CStringRes, Role
  self._charList = (self._bm):GetRoleList()
  for i = 1, charNumber do
    (((self._char)[i]).panel):SetActive(false)
  end
  local str = ((TextManager.GetText)((CStringRes:GetRecorder(1773)).msgTextID))
  local role, image = nil, nil
  local needNum = 0
  local currentNum = 0
  local redDotShow = (self._bm):CanWitchLevelUp()
  for i,char in ipairs(self._charList) do
    (((self._char)[i]).panel):SetActive(true)
    ;
    (((self._char)[i]).level):SetText((string.gsub)(str, "%$parameter1%$", char.roleLv))
    role = (Role.Create)(char.roleId)
    image = role:GetDiamondHeadImageRecord()
    ;
    (((self._char)[i]).headImg):SetSprite(image.assetBundle, image.assetName)
    ;
    (((self._char)[i]).healthTxt):SetText(char.blood)
    ;
    (((self._char)[i]).attackTxt):SetText(char.attack)
    ;
    (((self._char)[i]).redDot):SetActive(redDotShow)
  end
end

KillBossPage.RefreshMonsterInfo = function(self)
  -- function num : 0_7 , upvalues : _ENV
  self._bossList = (self._bm):GetMonsterList()
  ;
  (self._frame):ReloadAllCell()
  local moveToIdx = 0
  for i,v in ipairs(self._bossList) do
    if v.result == 0 then
      moveToIdx = i
      break
    end
  end
  do
    if moveToIdx ~= 0 then
      (self._frame):MoveLeftToIndex(moveToIdx)
    else
      ;
      (self._frame):MoveToRight()
      self._lastBossId = ((self._bossList)[#self._bossList]).id
    end
    ;
    (self._startBattleBtn):SetActive(not self._lastBossId)
  end
end

KillBossPage.NumberOfCell = function(self, frame)
  -- function num : 0_8
  return #self._bossList
end

KillBossPage.CellAtIndex = function(self, frame, index)
  -- function num : 0_9
  return "activity.giftoftime.killbosspagemonstercell"
end

KillBossPage.DataAtIndex = function(self, frame, index)
  -- function num : 0_10
  return (self._bossList)[index]
end

KillBossPage.OnTipBtnClicked = function(self)
  -- function num : 0_11 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Message):OpenInstructionsTipDialog(3)
end

KillBossPage.OnDailyTaskClicked = function(self)
  -- function num : 0_12 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("activity.giftoftime.killbosstaskdialog")):Init()
end

KillBossPage.OnStartBattleClicked = function(self)
  -- function num : 0_13 , upvalues : _ENV
  if not self._sendStartBattleProtocol and self._curBossId > 0 then
    local csend = (LuaNetManager.CreateProtocol)("protocol.activity.cstartagainstbossbattle")
    for i,v in ipairs(self._bossList) do
      if v.id == self._curBossId then
        self._battleData = v
        break
      end
    end
    do
      self._sendStartBattleProtocol = true
      self._canShowItemGotten = false
      csend:Send()
    end
  end
end

KillBossPage.OnWeeklyRewardBtnClicked = function(self)
  -- function num : 0_14 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("activity.giftoftime.killbossawarddialog")):Refresh()
end

KillBossPage.OnCharPanelClicked = function(self, index)
  -- function num : 0_15 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("activity.giftoftime.killbosscharacterinfodialog")):SetData((self._charList)[index])
end

KillBossPage.OnEndBattle = function(self, notification)
  -- function num : 0_16 , upvalues : _ENV
  local bossinfo = (notification.userInfo).bossInfo
  self._sendStartBattleProtocol = false
  self._battleResult = bossinfo.result
  LogInfoFormat("KillBossPage", "server battle result %s,score:%s", bossinfo.result, bossinfo.bassPassExpRewards)
  local dialog = (DialogManager.CreateSingletonDialog)("smallbattle.smallbattledialog")
  dialog:SetData((dialog.TargetType).KillBoss, self._battleResult, self._battleData, self._charList, bossinfo.bassPassExpRewards)
end

KillBossPage.OnRoleLevelUp = function(self)
  -- function num : 0_17 , upvalues : _ENV
  self:RefreshCharInfo()
  local dialog = (DialogManager.GetDialog)("activity.giftoftime.killbosscharacterinfodialog")
  if dialog then
    dialog:SetData((self._charList)[1])
  end
end

local format_str = function(id, value)
  -- function num : 0_18 , upvalues : _ENV, CStringRes
  local s = (TextManager.GetText)((CStringRes:GetRecorder(id)).msgTextID)
  return (string.gsub)(s, "%$parameter1%$", value)
end

local GetRemainTimeStr = function(endTime)
  -- function num : 0_19 , upvalues : _ENV, CStringRes
  local str = nil
  if endTime and endTime > 0 then
    local time = endTime
    local day = time // 86400
    local hour = (math.ceil)(time / 3600)
    if day > 0 then
      str = (TextManager.GetText)((CStringRes:GetRecorder(1935)).msgTextID, (string.format)("%d", day), (string.format)("%d", hour - day * 24))
    else
      str = (TextManager.GetText)((CStringRes:GetRecorder(1936)).msgTextID, hour)
    end
  else
    do
      str = (TextManager.GetText)((CStringRes:GetRecorder(1936)).msgTextID, 0)
      return str
    end
  end
end

KillBossPage.UpdateLeftTime = function(self)
  -- function num : 0_20 , upvalues : _ENV, GetRemainTimeStr
  self._leftTimeData = self._leftTimeData - 1
  if self._leftTimeData < 0 then
    (GameTimer.RemoveTask)(self._timerId)
    self._timerId = 0
    return 
  end
  local str = GetRemainTimeStr(self._leftTimeData)
  ;
  (self._leftTime):SetText(str)
end

KillBossPage.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_21
  if proportion <= 0 then
    (self._rightBtn):SetActive(true)
    ;
    (self._leftBtn):SetActive(false)
  else
    if proportion >= 1 then
      (self._rightBtn):SetActive(false)
      ;
      (self._leftBtn):SetActive(true)
    else
      ;
      (self._rightBtn):SetActive(true)
      ;
      (self._leftBtn):SetActive(true)
    end
  end
end

KillBossPage.OnDialogDestroy = function(self, notification)
  -- function num : 0_22 , upvalues : _ENV
  if (notification.userInfo)._dialogName == "smallbattle.smallbattlefaileddialog" then
    (LuaNotificationCenter.PostNotification)(Common.n_TriggerGuide, self, nil)
  end
end

return KillBossPage

