-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/bossrush/bossrushweekmaindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CWeeklyBossRush = (BeanManager.GetTableByName)("dungeonselect.cweeklybossrush")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CVarConfig = (BeanManager.GetTableByName)("var.cvarconfig")
local CBattleConstCfg = (BeanManager.GetTableByName)("battle.cbattleconstcfg")
local CBattleInfo = (BeanManager.GetTableByName)("battle.cbattleinfo")
local CMonsterConfigTable = (BeanManager.GetTableByName)("npc.cmonsterconfig")
local BossChallenge = (LuaNetManager.GetBeanDef)("protocol.ranking.bosschallenge")
local Status = (LuaNetManager.GetBeanDef)("protocol.task.taskstatus")
local BossRushWeekMainDialog = class("BossRushWeekMainDialog", Dialog)
BossRushWeekMainDialog.AssetBundleName = "ui/layouts.mainline"
BossRushWeekMainDialog.AssetName = "BossRushWeekMain"
local SecToDay = 86400
local SecToHour = 3600
local SecToMin = 60
local BossRushWeekTaskType = 16
BossRushWeekMainDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BossRushWeekMainDialog, _ENV, CVarConfig
  ((BossRushWeekMainDialog.super).Ctor)(self, ...)
  self._cacheRankData = {}
  self._personalRankData = {}
  self._bm = (NekoData.BehaviorManager).BM_WeekBoss
  self._nightmareConfirmTimes = tonumber((CVarConfig:GetRecorder(118)).Value)
end

BossRushWeekMainDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._difficultTxt = self:GetChild("Frame/Left/CellFrame/Difficulty/Txt")
  self._enemyInfoBtn = self:GetChild("Frame/Left/EnemyBtn")
  self._enemyInfoBtnTxt = self:GetChild("Frame/Left/EnemyBtn/_Text")
  self._bossImg = self:GetChild("Frame/Left/CellFrame/Photo")
  self._bossNameTxt = self:GetChild("Frame/Left/CellFrame/Name")
  self._quickTimeTitleTxt = self:GetChild("Frame/Right/Top/TxtBack1/Txt")
  self._quickTimeTxt = self:GetChild("Frame/Right/Top/TxtBack1/Time")
  self._quickDifficultTxt = self:GetChild("Frame/Right/Top/TxtBack1/Time/DifficultyTxt")
  self._rankLabel = self:GetChild("Frame/Right/Top/TxtBack2/Txt")
  self._rankTxt = self:GetChild("Frame/Right/Top/TxtBack2/Rank")
  self._cultivateBtn = self:GetChild("Frame/Right/CultivateBtn")
  self._cultivateBtnRedDot = self:GetChild("Frame/Right/CultivateBtn/RedDot")
  self._cultivateBtnTxt = self:GetChild("Frame/Right/CultivateBtn/Text")
  self._awardBtn = self:GetChild("Frame/Right/AwardBtn")
  self._awardBtnRedDot = self:GetChild("Frame/Right/AwardBtn/RedDot")
  self._awardBtnTxt = self:GetChild("Frame/Right/AwardBtn/Text")
  self._rankBtn = self:GetChild("Frame/Right/RankBtn")
  self._rankBtnRedDot = self:GetChild("Frame/Right/RankBtn/RedDot")
  ;
  (self._rankBtnRedDot):SetActive(false)
  self._rankBtnTxt = self:GetChild("Frame/Right/RankBtn/Text")
  self._achievementBtn = self:GetChild("Frame/Right/AchievementBtn")
  self._achievementBtnRedDot = self:GetChild("Frame/Right/AchievementBtn/RedDot")
  self._achievementBtnTxt = self:GetChild("Frame/Right/AchievementBtn/Text")
  self._battleBtn = self:GetChild("Frame/Right/Battle/BattleBtn")
  self._battleBtnTxt = self:GetChild("Frame/Right/Battle/BattleBtn/Text")
  self._battleBtnTipsTxt = self:GetChild("Frame/Right/Text")
  self._battleBtnRedDot = self:GetChild("Frame/Right/RedDot")
  self._title = self:GetChild("Top/Title")
  self._tipsTxt = self:GetChild("Top/Tips/Txt")
  self._tipsBtn = self:GetChild("Top/Tips/Ibtn")
  self._lastTimeTxt = self:GetChild("Top/TopBack/Time/Text")
  self._absent = self:GetChild("Frame/Right/Top/TxtBack1/NoneTxt")
  self._noRank = self:GetChild("Frame/Right/Top/TxtBack2/NoneTxt")
  ;
  (self._enemyInfoBtn):Subscribe_PointerClickEvent(self.OnEnemyInfoBtnClicked, self)
  ;
  (self._cultivateBtn):Subscribe_PointerClickEvent(self.OnCultivateBtnClicked, self)
  ;
  (self._awardBtn):Subscribe_PointerClickEvent(self.OnAwardBtnClicked, self)
  ;
  (self._rankBtn):Subscribe_PointerClickEvent(self.OnRankBtnClicked, self)
  ;
  (self._achievementBtn):Subscribe_PointerClickEvent(self.OnAchievementBtnClicked, self)
  ;
  (self._battleBtn):Subscribe_PointerClickEvent(self.OnBattleBtnClicked, self)
  ;
  (self._tipsBtn):Subscribe_PointerClickEvent(self.OnTipsBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSOpenWeekBossPanel, Common.n_SOpenWeekBossPanel, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSWeekBossRedPoint, Common.n_SWeekBossRedPoint, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshRewardRed, Common.n_SReceiveWeekAward, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshAchievementRedDot, Common.n_WeekBossTaskRedPoint, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshTimes, Common.n_SWeekBossTime, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnWeekBossRefresh, Common.n_WeekBossRefresh, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshCultivateRedDot, Common.n_SImproveTalent, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshRankList, Common.n_SWeekChallengeRanking, nil)
end

BossRushWeekMainDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  if self._rankRefreshCDTimeTask then
    (GameTimer.RemoveTask)(self._rankRefreshCDTimeTask)
    self._rankRefreshCDTimeTask = nil
  end
  if self._nightmareTimeRefreshTask then
    (ServerGameTimer.RemoveTask)(self._nightmareTimeRefreshTask)
    self._nightmareTimeRefreshTask = nil
  end
  if self._countTimeTask then
    (ServerGameTimer.RemoveTask)(self._countTimeTask)
    self._countTimeTask = nil
  end
  ;
  (DialogManager.DestroySingletonDialog)("mainline.fragment.fragmentlevelinfodialog")
  ;
  (DialogManager.DestroySingletonDialog)("mainline.bossrush.bossrushweekcultivatedialog")
  ;
  (DialogManager.DestroySingletonDialog)("mainline.bossrush.bossstageawardpaneldialog")
  ;
  (DialogManager.DestroySingletonDialog)("mainline.bossrush.bossrushweekrankdialog")
  ;
  (DialogManager.DestroySingletonDialog)("mainline.bossrush.bossrushweekachievementdialog")
  ;
  (DialogManager.DestroySingletonDialog)("mainline.bossrush.bossrushtipsdialog")
  ;
  (DialogManager.DestroySingletonDialog)("teamedit.teameditprewardialog")
end

local GetNightmareDelTimeStr = function(ms)
  -- function num : 0_3 , upvalues : SecToDay, _ENV, SecToHour, SecToMin
  local sec = ms // 1000
  local str = nil
  if SecToDay < sec then
    str = (TextManager.GetText)(1901575)
    str = (string.gsub)(str, "%$parameter1%$", sec // SecToDay)
    str = (string.gsub)(str, "%$parameter2%$", sec % SecToDay // SecToHour)
  else
    if SecToHour < sec then
      str = (TextManager.GetText)(1901574)
      str = (string.gsub)(str, "%$parameter1%$", sec // SecToHour)
    else
      if SecToMin < sec then
        str = (TextManager.GetText)(1901573)
        str = (string.gsub)(str, "%$parameter1%$", sec // SecToMin)
      else
        str = (TextManager.GetText)(1901573)
        str = (string.gsub)(str, "%$parameter1%$", 1)
      end
    end
  end
  return str
end

BossRushWeekMainDialog.NightmareTimerTask = function(self)
  -- function num : 0_4 , upvalues : _ENV, GetNightmareDelTimeStr
  if self._nightmareTimeNumber == nil then
    if self._nightmareTimeRefreshTask then
      (ServerGameTimer.RemoveTask)(self._nightmareTimeRefreshTask)
      self._nightmareTimeRefreshTask = nil
    end
    return 
  end
  self._nightmareTimeNumber = self._nightmareTimeNumber - 1000
  if self._nightmareTimeNumber > 0 then
    (self._battleBtnTipsTxt):SetText(GetNightmareDelTimeStr(self._nightmareTimeNumber))
  else
    ;
    (self._battleBtnTipsTxt):SetText((TextManager.GetText)(1901576))
    if self._nightmareTimeRefreshTask then
      (ServerGameTimer.RemoveTask)(self._nightmareTimeRefreshTask)
      self._nightmareTimeRefreshTask = nil
    end
  end
end

local GetCountTimerDelTimeStr = function(ms)
  -- function num : 0_5 , upvalues : _ENV, SecToDay, SecToHour, SecToMin
  local sec = ms // 1000
  local str = nil
  if ((NekoData.BehaviorManager).BM_WeekBoss):GetLeftTime() ~= -1 then
    if SecToDay < sec then
      str = (TextManager.GetText)(1901567)
      str = (string.gsub)(str, "%$parameter1%$", sec // SecToDay)
      str = (string.gsub)(str, "%$parameter2%$", sec % SecToDay // SecToHour)
    else
      if SecToHour < sec then
        str = (TextManager.GetText)(1901566)
        str = (string.gsub)(str, "%$parameter1%$", sec // SecToHour)
      else
        if SecToMin < sec then
          str = (TextManager.GetText)(1901565)
          str = (string.gsub)(str, "%$parameter1%$", sec // SecToMin)
        else
          str = (TextManager.GetText)(1901565)
          str = (string.gsub)(str, "%$parameter1%$", 1)
        end
      end
    end
  else
    if ((NekoData.BehaviorManager).BM_WeekBoss):GetResetTime() ~= -1 then
      if SecToHour < sec then
        str = (TextManager.GetText)(1901569)
        str = (string.gsub)(str, "%$parameter1%$", sec // SecToHour)
      else
        if SecToMin < sec then
          str = (TextManager.GetText)(1901568)
          str = (string.gsub)(str, "%$parameter1%$", sec // SecToMin)
        else
          str = (TextManager.GetText)(1901568)
          str = (string.gsub)(str, "%$parameter1%$", 1)
        end
      end
    end
  end
  return str
end

BossRushWeekMainDialog.CountTimeTask = function(self)
  -- function num : 0_6 , upvalues : _ENV, GetCountTimerDelTimeStr
  if self._timeNumber == nil then
    if self._countTimeTask then
      (ServerGameTimer.RemoveTask)(self._countTimeTask)
      self._countTimeTask = nil
    end
    return 
  end
  self._timeNumber = self._timeNumber - 1000
  if self._timeNumber > 0 then
    (self._lastTimeTxt):SetActive(true)
    ;
    (self._lastTimeTxt):SetText(GetCountTimerDelTimeStr(self._timeNumber))
  else
    ;
    (self._lastTimeTxt):SetActive(false)
    if self._countTimeTask then
      (ServerGameTimer.RemoveTask)(self._countTimeTask)
      self._countTimeTask = nil
    end
  end
end

BossRushWeekMainDialog.RefreshCell = function(self)
  -- function num : 0_7 , upvalues : _ENV
  (self._quickTimeTitleTxt):SetText((TextManager.GetText)(1901571))
  ;
  (self._rankLabel):SetText((TextManager.GetText)(1901572))
  ;
  (self._tipsTxt):SetText((TextManager.GetText)(1901563))
  ;
  (self._absent):SetText((TextManager.GetText)(1901595))
  ;
  (self._noRank):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1421))
  ;
  (self._enemyInfoBtnTxt):SetText((TextManager.GetText)(1901570))
  ;
  (self._rankBtnTxt):SetText((TextManager.GetText)(1901560))
  ;
  (self._awardBtnTxt):SetText((TextManager.GetText)(1901559))
  ;
  (self._battleBtnTxt):SetText((TextManager.GetText)(1901558))
  ;
  (self._cultivateBtnTxt):SetText((TextManager.GetText)(1901561))
  ;
  (self._achievementBtnTxt):SetText((TextManager.GetText)(1901562))
  self:RefreshTimes()
  local data = (self._bm):GetWeekBossRushData()
  if not data then
    LogWarning("BossRushWeekMainDialog", "SOpenWeekBossPanel dont receive")
    return 
  end
  self:RefreshData(data)
  self:OnSWeekBossRedPoint()
end

BossRushWeekMainDialog.RefreshTimes = function(self)
  -- function num : 0_8 , upvalues : _ENV
  self._nightmareTimeNumber = (self._bm):GetNightmareTime()
  if self._nightmareTimeNumber ~= -1 then
    if self._nightmareTimeRefreshTask then
      (ServerGameTimer.RemoveTask)(self._nightmareTimeRefreshTask)
      self._nightmareTimeRefreshTask = nil
    end
    self._nightmareTimeRefreshTask = (ServerGameTimer.AddTask)(0, 1, function()
    -- function num : 0_8_0 , upvalues : self
    self:NightmareTimerTask()
  end
, nil)
  else
    ;
    (self._battleBtnTipsTxt):SetText((TextManager.GetText)(1901576))
  end
  local leftTime = (self._bm):GetLeftTime()
  local resetTime = (self._bm):GetResetTime()
  self._timeNumber = -1
  if leftTime ~= -1 then
    self._timeNumber = leftTime
  else
    if resetTime ~= -1 then
      self._timeNumber = resetTime
    else
      LogError("BossRushWeekMainDialog", "SOpenWeekBossPanel leftTime and resetTime both -1")
    end
  end
  if self._timeNumber ~= -1 then
    if self._countTimeTask then
      (ServerGameTimer.RemoveTask)(self._countTimeTask)
      self._countTimeTask = nil
    end
    self._countTimeTask = (ServerGameTimer.AddTask)(0, 1, function()
    -- function num : 0_8_1 , upvalues : self
    self:CountTimeTask()
  end
, nil)
  end
end

BossRushWeekMainDialog.RefreshData = function(self, data)
  -- function num : 0_9 , upvalues : CWeeklyBossRush, _ENV, CBattleInfo, CMonsterConfigTable, CImagePathTable, BossChallenge, CStringRes
  self._currentWeekBossId = (data.bosses).id
  self._awardGot = (data.bosses).awardGot
  self._awardTotalNum = (data.bosses).awardTotalNum
  self._difficultTimes = (data.bosses).times
  self._currentVictoryTimes = (data.bosses).victoryTimes
  if self._difficultTimes == self._nightmareConfirmTimes - 1 then
    (self._bm):SetLocalIntWithName((((self._bm).LocalParamData).NightmareChallengeConfirm).nameTxt, ((((self._bm).LocalParamData).NightmareChallengeConfirm).showType).Show)
  end
  local recorder = CWeeklyBossRush:GetRecorder(self._currentWeekBossId)
  if not recorder then
    LogErrorFormat("BossRushWeekMainDialog", "bosses.id %s is not in cweeklybossrush", self._currentWeekBossId)
  end
  local bossBattleId = (recorder.bossbattleID)[(data.bosses).times + 1]
  local level = 0
  if bossBattleId then
    local cbattleinfoRecord = CBattleInfo:GetRecorder(bossBattleId)
    if not cbattleinfoRecord then
      LogErrorFormat("BossRushWeekMainDialog", "cweeklybossrush id %s bossbattleID times+1(index) %s id %s is not in cbattleinfo", recorder.id, (data.bosses).times + 1, bossBattleId)
    else
      local cmonsterRecord = CMonsterConfigTable:GetRecorder(cbattleinfoRecord.bossID)
      if not cmonsterRecord then
        LogErrorFormat("BossRushWeekMainDialog", "cweeklybossrush id %s bossbattleID times+1(index) %s id %s bossID %s is not in cmonsterconfig", recorder.id, (data.bosses).times + 1, bossBattleId, cbattleinfoRecord.bossID)
      else
        level = cmonsterRecord.npcLevel
      end
    end
  else
    do
      LogErrorFormat("BossRushWeekMainDialog", "times+1(index) %s not exist in cweeklybossrush id %s bossbattleID", (data.bosses).times + 1, recorder.id)
      self._monsterLv = level
      local image = CImagePathTable:GetRecorder(recorder.image)
      ;
      (self._bossImg):SetSprite(image.assetBundle, image.assetName)
      ;
      (self._bossNameTxt):SetText((TextManager.GetText)(recorder.nameTextID))
      self._stageIdList = recorder.stageID
      ;
      (self._difficultTxt):SetText(((NekoData.BehaviorManager).BM_Game):GetBossRushDifficultyColorStr((data.bosses).times, nil, true))
      if (data.bosses).status == 0 then
        (self._absent):SetActive(true)
        ;
        (self._rankTxt):SetActive(false)
        ;
        (self._noRank):SetActive(true)
        ;
        (self._quickTimeTxt):SetActive(false)
      else
        ;
        (self._absent):SetActive(false)
        if (data.bosses).rank == BossChallenge.NOT_ON_LIST then
          (self._rankTxt):SetActive(false)
          ;
          (self._noRank):SetActive(true)
        else
          ;
          (self._rankTxt):SetActive(true)
          ;
          (self._noRank):SetActive(false)
          ;
          (self._rankTxt):SetText((data.bosses).rank)
        end
        local str = (CStringRes:GetRecorder(1107)).msgTextID
        str = (TextManager.GetText)(str)
        local num = (data.bosses).passTime / 1000
        local ret = ((NekoData.BehaviorManager).BM_Game):GetPreciseDecimal(num, 1)
        str = (string.gsub)(str, "%$parameter1%$", ret)
        ;
        (self._quickTimeTxt):SetActive(true)
        ;
        (self._quickTimeTxt):SetText(str)
        ;
        (self._quickDifficultTxt):SetText(((NekoData.BehaviorManager).BM_Game):GetBossRushDifficultyColorStr((data.bosses).victoryTimes, nil, true))
      end
    end
  end
end

BossRushWeekMainDialog.OnEnemyInfoBtnClicked = function(self)
  -- function num : 0_10 , upvalues : _ENV, CWeeklyBossRush
  if not self:CheckCurrentBossId() then
    return 
  end
  local dialog = (DialogManager.CreateSingletonDialog)("mainline.fragment.fragmentlevelinfodialog")
  if dialog then
    local recorder = CWeeklyBossRush:GetRecorder(self._currentWeekBossId)
    dialog:SetData({recorder.bossIllustrationID}, self._monsterLv)
  end
end

BossRushWeekMainDialog.OnCultivateBtnClicked = function(self)
  -- function num : 0_11 , upvalues : _ENV
  if not (self._bm):IsOpen() then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100476)
    return 
  end
  local protocol = (LuaNetManager.CreateProtocol)("protocol.battle.cweekbosstalent")
  protocol:Send()
end

BossRushWeekMainDialog.OnAwardBtnClicked = function(self)
  -- function num : 0_12 , upvalues : _ENV
  if not self:CheckCurrentBossId() then
    return 
  end
  ;
  ((DialogManager.CreateSingletonDialog)("mainline.bossrush.bossstageawardpaneldialog")):Refresh(self._stageIdList, self._awardGot, self._awardTotalNum, self._currentWeekBossId, self._difficultTimes, (TextManager.GetText)(1901597), true)
end

BossRushWeekMainDialog.RefreshRankList = function(self, notification)
  -- function num : 0_13 , upvalues : _ENV
  self._cacheRankData = (notification.userInfo).ranking
  self._personalRankData = (notification.userInfo).personRank
  local dialog = (DialogManager.GetDialog)("mainline.bossrush.bossrushweekrankdialog")
  if dialog then
    dialog:SetData(self._cacheRankData, self._personalRankData)
  end
end

BossRushWeekMainDialog.OnRankBtnClicked = function(self)
  -- function num : 0_14 , upvalues : _ENV
  if not self:CheckCurrentBossId() then
    return 
  end
  local dialog = (DialogManager.CreateSingletonDialog)("mainline.bossrush.bossrushweekrankdialog")
  local needReq = false
  if not self._cacheRankData then
    needReq = true
  end
  if needReq or not self._rankRefreshCDTimeTask then
    local protocol = (LuaNetManager.CreateProtocol)("protocol.ranking.cweekchallengeranking")
    protocol:Send()
    if self._rankRefreshCDTimeTask then
      (GameTimer.RemoveTask)(self._rankRefreshCDTimeTask)
      self._rankRefreshCDTimeTask = nil
    end
    self._rankRefreshCDTimeTask = (GameTimer.AddTask)(5, -1, function(self)
    -- function num : 0_14_0
    self._rankRefreshCDTimeTask = nil
  end
, self)
  else
    do
      dialog:SetData(self._cacheRankData, self._personalRankData)
    end
  end
end

BossRushWeekMainDialog.OnAchievementBtnClicked = function(self)
  -- function num : 0_15 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("mainline.bossrush.bossrushweekachievementdialog")
end

BossRushWeekMainDialog.OnBattleBtnClicked = function(self)
  -- function num : 0_16 , upvalues : _ENV
  local sendClickedRedDotNotify = false
  if (self._bm):GetLocalIntWithType(((self._bm).LocalParamData).ChallengeHasBeenClicked) == ((((self._bm).LocalParamData).ChallengeHasBeenClicked).showType).Show then
    sendClickedRedDotNotify = true
  end
  ;
  (self._bm):SetLocalIntWithName((((self._bm).LocalParamData).ChallengeHasBeenClicked).nameTxt, ((((self._bm).LocalParamData).ChallengeHasBeenClicked).showType).No)
  if sendClickedRedDotNotify then
    (LuaNotificationCenter.PostNotification)(Common.n_WeekBossChallengeRedPoint, self, nil)
  end
  if not (self._bm):IsOpen() then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100476)
    return 
  end
  if not self:CheckCurrentBossId() then
    return 
  end
  if self._difficultTimes == self._nightmareConfirmTimes and self._currentVictoryTimes == self._nightmareConfirmTimes and not (self._bm):IsNightmareOpen() and (self._bm):GetLocalIntWithType(((self._bm).LocalParamData).NightmareChallengeConfirm) == ((((self._bm).LocalParamData).NightmareChallengeConfirm).showType).Show then
    (self._bm):SetLocalIntWithName((((self._bm).LocalParamData).NightmareChallengeConfirm).nameTxt, ((((self._bm).LocalParamData).NightmareChallengeConfirm).showType).No)
    ;
    ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(142, {}, function()
    -- function num : 0_16_0 , upvalues : self
    self:OpenTeamEditDialog()
  end
, {}, nil, {})
  else
    self:OpenTeamEditDialog()
  end
  self:RereshBattleRedDot()
end

BossRushWeekMainDialog.OpenTeamEditDialog = function(self)
  -- function num : 0_17 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("teamedit.teameditprewardialog")
  if dialog then
    dialog:SetCopyInfo("WeekBoss", self._currentWeekBossId)
  end
end

BossRushWeekMainDialog.OnTipsBtnClicked = function(self)
  -- function num : 0_18 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("mainline.bossrush.bossrushtipsdialog")):SetData(1901563, 1901564)
end

BossRushWeekMainDialog.OnSOpenWeekBossPanel = function(self, notification)
  -- function num : 0_19
  self:RefreshData(notification.userInfo)
  self:OnSWeekBossRedPoint()
end

BossRushWeekMainDialog.OnSWeekBossRedPoint = function(self)
  -- function num : 0_20
  self:RefreshAchievementRedDot()
  self:OnRefreshRewardRed()
  self:RefreshCultivateRedDot()
  self:RereshBattleRedDot()
end

BossRushWeekMainDialog.OnRefreshRewardRed = function(self)
  -- function num : 0_21
  (self._awardBtnRedDot):SetActive((self._bm):GetRedDotWithType(((self._bm).RedDotType).Reward))
end

BossRushWeekMainDialog.RefreshAchievementRedDot = function(self)
  -- function num : 0_22 , upvalues : _ENV, BossRushWeekTaskType, Status
  local taskList = ((NekoData.BehaviorManager).BM_Task):GetTasksByType(BossRushWeekTaskType)
  for _,v in pairs(taskList) do
    if v:GetStatus() == Status.FINISHED then
      (self._achievementBtnRedDot):SetActive(true)
      return 
    end
  end
  ;
  (self._achievementBtnRedDot):SetActive(false)
end

BossRushWeekMainDialog.RefreshCultivateRedDot = function(self)
  -- function num : 0_23
  (self._cultivateBtnRedDot):SetActive((self._bm):GetRedDotWithType(((self._bm).RedDotType).Cultivate))
end

BossRushWeekMainDialog.RereshBattleRedDot = function(self)
  -- function num : 0_24
  if not (self._bm):IsOpen() then
    (self._battleBtnRedDot):SetActive(false)
  else
    ;
    (self._battleBtnRedDot):SetActive((self._bm):GetLocalIntWithType(((self._bm).LocalParamData).ChallengeHasBeenClicked) ~= ((((self._bm).LocalParamData).ChallengeHasBeenClicked).showType).Show and (self._bm):GetRedDotWithType(((self._bm).RedDotType).Challenge))
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

BossRushWeekMainDialog.OnWeekBossRefresh = function(self)
  -- function num : 0_25 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("mainline.fragment.fragmentlevelinfodialog")
  ;
  (DialogManager.DestroySingletonDialog)("mainline.bossrush.bossrushweekcultivatedialog")
  ;
  (DialogManager.DestroySingletonDialog)("mainline.bossrush.bossstageawardpaneldialog")
  ;
  (DialogManager.DestroySingletonDialog)("mainline.bossrush.bossrushweekrankdialog")
  ;
  (DialogManager.DestroySingletonDialog)("mainline.bossrush.bossrushweekachievementdialog")
  ;
  (DialogManager.DestroySingletonDialog)("teamedit.teameditprewardialog")
end

BossRushWeekMainDialog.CheckCurrentBossId = function(self)
  -- function num : 0_26 , upvalues : _ENV
  if not self._currentWeekBossId then
    LogError("BossRushWeekMainDialog", "no current boss id. Maybe not receive SOpenWeekBossPanel")
    return false
  end
  return true
end

return BossRushWeekMainDialog

