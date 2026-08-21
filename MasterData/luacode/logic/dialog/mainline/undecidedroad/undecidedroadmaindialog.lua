-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/undecidedroad/undecidedroadmaindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CWeidingBattleConfig = (BeanManager.GetTableByName)("dungeonselect.cweidingbattleconfig")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local UndecidedRoadMainDialog = class("UndecidedRoadMainDialog", Dialog)
local BattleType = (LuaNetManager.CreateBean)("protocol.activity.challengerecord")
UndecidedRoadMainDialog.AssetBundleName = "ui/layouts.activityroad"
UndecidedRoadMainDialog.AssetName = "ActivityRoadMain"
UndecidedRoadMainDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : UndecidedRoadMainDialog
  ((UndecidedRoadMainDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

UndecidedRoadMainDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._cell = {}
  for i = 1, 3 do
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R5 in 'UnsetPending'

    (self._cell)[i] = {}
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._cell)[i]).cell = self:GetChild("Cell" .. i)
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._cell)[i]).bossImg = self:GetChild("Cell" .. i .. "/Boss")
    -- DECOMPILER ERROR at PC34: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._cell)[i]).startBtn = self:GetChild("Cell" .. i .. "/StartBtn")
  end
  self._dayTxt = self:GetChild("Cell3/TitleBack/Txt")
  self._bossNameWeekTxt = self:GetChild("Cell2/Name")
  self._bossNameDayTxt = self:GetChild("Cell3/Name")
  self._bossWeekScoreTxt = self:GetChild("Cell2/Num1")
  self._bossDayScoreTxt = self:GetChild("Cell3/Num1")
  self._recommendWeekTxt = self:GetChild("Cell2/Num2")
  self._recommendDayTxt = self:GetChild("Cell3/Num2")
  self._recordWeekBtn = self:GetChild("Cell2/RecordBtn")
  self._recordDayBtn = self:GetChild("Cell3/RecordBtn")
  self._txtw1 = self:GetChild("Cell2/Txt1")
  self._txtw2 = self:GetChild("Cell2/Txt2")
  self._txtd1 = self:GetChild("Cell3/Txt1")
  self._txtd2 = self:GetChild("Cell3/Txt2")
  self._TopBack = self:GetChild("TopBack")
  self._resetTime = self:GetChild("TopBack/Time/Text")
  self._tipBtn = self:GetChild("TopBack/Tips/Ibtn")
  self._rewardBtn = self:GetChild("RewardBtn")
  self._rewardRedDot = self:GetChild("RewardBtn/RedDot")
  self._RecordBtn = self:GetChild("RecordBtn")
  self._totalNumTxt = self:GetChild("NumPanel/Num")
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  ;
  (self._rewardRedDot):SetActive(false)
  self._cell2Lock = self:GetChild("Cell2Lock")
  self._cell3Lock = self:GetChild("Cell3Lock")
  self._lock2Txt = self:GetChild("Cell2Lock/Txt")
  self._lock3Txt = self:GetChild("Cell3Lock/Txt")
  ;
  (self:GetChild("RankBtn")):Subscribe_PointerClickEvent(self.OnRankBtnClick, self)
  ;
  (((self._cell)[1]).startBtn):Subscribe_PointerClickEvent(self.OnTrainingClicked, self)
  ;
  (((self._cell)[2]).startBtn):Subscribe_PointerClickEvent(self.OnWeekStartBtnClicked, self)
  ;
  (((self._cell)[3]).startBtn):Subscribe_PointerClickEvent(self.OnDayStartBtnClicked, self)
  ;
  (self._recordWeekBtn):Subscribe_PointerClickEvent(self.OnRecordWeekBtnClicked, self)
  ;
  (self._recordDayBtn):Subscribe_PointerClickEvent(self.OnRecordDayBtnClicked, self)
  ;
  (self._tipBtn):Subscribe_PointerClickEvent(self.OnTipBtnClicked, self)
  ;
  (self._rewardBtn):Subscribe_PointerClickEvent(self.OnRewardBtnClicked, self)
  ;
  (self._RecordBtn):Subscribe_PointerClickEvent(self.OnRecordBtnClicked, self)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  ;
  ((NekoData.DataManager).DM_Game):CheckUndecidedRoadRed()
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_RefreshUndecidedRoadRedDot, nil, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.Refresh, Common.n_EnterMianCity, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshUI, Common.n_RefreshUndecidedRoadState, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshAwardRedDot, Common.n_RefreshUndecidedRoadAward, nil)
end

UndecidedRoadMainDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._task then
    (ServerGameTimer.RemoveTask)(self._task)
    self._task = nil
  end
  ;
  (DialogManager.DestroySingletonDialog)("mainline.undecidedroad.undecidedroadruledialog")
  ;
  (DialogManager.DestroySingletonDialog)("mainline.undecidedroad.undecidedroadrewarddialog")
  ;
  (DialogManager.DestroySingletonDialog)("mainline.undecidedroad.undecidedroadrankdialog")
  ;
  (DialogManager.DestroySingletonDialog)("mainline.undecidedroad.undecidedroadbossrecorddialog")
  ;
  (DialogManager.DestroySingletonDialog)("mainline.undecidedroad.undecidedroadrecorddialog")
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

UndecidedRoadMainDialog.Init = function(self)
  -- function num : 0_3 , upvalues : _ENV
  self:RefreshUI()
  local csend = (LuaNetManager.CreateProtocol)("protocol.activity.copenrewardlist")
  if csend then
    csend:Send()
  end
end

UndecidedRoadMainDialog.OnBackBtnClicked = function(self)
  -- function num : 0_4
  self:Destroy()
end

UndecidedRoadMainDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

UndecidedRoadMainDialog.OnTrainingClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local csend = (LuaNetManager.CreateProtocol)("protocol.activity.copentrain")
  if csend then
    csend:Send()
  end
end

UndecidedRoadMainDialog.OnWeekStartBtnClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("mainline.undecidedroad.undecidedroadeditdialog")):Init(self._weekBattleData)
end

UndecidedRoadMainDialog.OnDayStartBtnClicked = function(self)
  -- function num : 0_8 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("mainline.undecidedroad.undecidedroadeditdialog")):Init(self._dailyBattleData)
end

UndecidedRoadMainDialog.OnRecordWeekBtnClicked = function(self)
  -- function num : 0_9 , upvalues : _ENV, BattleType
  ((NekoData.BehaviorManager).BM_UndecidedRoad):CheckChallengeRecord(BattleType.WEEK, (self._weekBattleData).battleId)
end

UndecidedRoadMainDialog.OnRecordDayBtnClicked = function(self)
  -- function num : 0_10 , upvalues : _ENV, BattleType
  ((NekoData.BehaviorManager).BM_UndecidedRoad):CheckChallengeRecord(BattleType.DAILY, (self._dailyBattleData).battleId)
end

UndecidedRoadMainDialog.OnTipBtnClicked = function(self)
  -- function num : 0_11 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("mainline.undecidedroad.undecidedroadruledialog")):Init()
end

UndecidedRoadMainDialog.OnRewardBtnClicked = function(self)
  -- function num : 0_12 , upvalues : _ENV, CStringRes
  local csend = (LuaNetManager.CreateProtocol)("protocol.activity.copenrewardlist")
  if csend then
    csend:Send()
  end
  if ((NekoData.BehaviorManager).BM_UndecidedRoad):GetReceiveIsOpen() then
    local dlg = (DialogManager.CreateSingletonDialog)("mainline.undecidedroad.undecidedroadrewarddialog")
    if dlg then
      dlg:Init()
    end
  else
    do
      ;
      ((NekoData.BehaviorManager).BM_Message):AddMessageTip((TextManager.GetText)((CStringRes:GetRecorder(1615)).msgTextID))
    end
  end
end

UndecidedRoadMainDialog.OnRecordBtnClicked = function(self)
  -- function num : 0_13 , upvalues : _ENV, BattleType, CStringRes
  local isOpen = ((NekoData.BehaviorManager).BM_UndecidedRoad):GetSeasonIsOpen()
  if isOpen then
    ((NekoData.BehaviorManager).BM_UndecidedRoad):CheckChallengeRecord(BattleType.SEASON)
  else
    ;
    ((NekoData.BehaviorManager).BM_Message):AddMessageTip((TextManager.GetText)((CStringRes:GetRecorder(1615)).msgTextID))
  end
end

UndecidedRoadMainDialog.ReloadTask = function(self)
  -- function num : 0_14 , upvalues : _ENV
  if not self._endTime or self._endTime <= 0 then
    (self._resetTime):SetText((TextManager.GetText)(701230))
    if self._task then
      (ServerGameTimer.RemoveTask)(self._task)
      self._task = nil
    end
    return 
  end
  self._endTime = self._endTime - 1000
  local sec = (math.floor)(self._endTime / 1000)
  if sec <= 0 then
    (self._resetTime):SetText((TextManager.GetText)(701230))
    if self._task then
      (ServerGameTimer.RemoveTask)(self._task)
      self._task = nil
    end
    return 
  end
  local str = (TextManager.GetText)(1901009)
  str = (string.gsub)(str, "%$parameter1%$", (math.floor)((os.date)("!%d", sec) - 1))
  str = (string.gsub)(str, "%$parameter2%$", (os.date)("!%H", sec))
  ;
  (self._resetTime):SetText(str)
end

UndecidedRoadMainDialog.RefreshUI = function(self)
  -- function num : 0_15 , upvalues : _ENV, CStringRes, BattleType, CWeidingBattleConfig, CImagePathTable
  local isOpen = ((NekoData.BehaviorManager).BM_UndecidedRoad):GetSeasonIsOpen()
  ;
  (((self._cell)[2]).bossImg):SetActive(false)
  ;
  (((self._cell)[2]).startBtn):SetActive(false)
  ;
  (self._bossNameWeekTxt):SetActive(false)
  ;
  (self._bossWeekScoreTxt):SetActive(false)
  ;
  (self._recommendWeekTxt):SetActive(false)
  ;
  (self._recordWeekBtn):SetActive(false)
  ;
  (self._txtw1):SetActive(false)
  ;
  (self._txtw2):SetActive(false)
  ;
  (((self._cell)[2]).cell):SetActive(false)
  ;
  (self._lock2Txt):SetActive(false)
  ;
  (self._cell2Lock):SetActive(false)
  ;
  (self._dayTxt):SetText((TextManager.GetText)(1901008))
  ;
  (((self._cell)[3]).bossImg):SetActive(false)
  ;
  (((self._cell)[3]).startBtn):SetActive(false)
  ;
  (self._bossNameDayTxt):SetActive(false)
  ;
  (self._bossDayScoreTxt):SetActive(false)
  ;
  (self._recommendDayTxt):SetActive(false)
  ;
  (self._recordDayBtn):SetActive(false)
  ;
  (self._txtd1):SetActive(false)
  ;
  (self._txtd2):SetActive(false)
  ;
  (((self._cell)[3]).cell):SetActive(false)
  ;
  (self._lock3Txt):SetActive(false)
  ;
  (self._cell3Lock):SetActive(false)
  self._totalScore = ((NekoData.BehaviorManager).BM_UndecidedRoad):GetTotalScore()
  if not isOpen then
    (self._cell2Lock):SetActive(true)
    ;
    (self._cell3Lock):SetActive(true)
    ;
    (self._lock2Txt):SetActive(true)
    ;
    (self._lock3Txt):SetActive(true)
    ;
    (self._lock2Txt):SetText((TextManager.GetText)((CStringRes:GetRecorder(1565)).msgTextID))
    ;
    (self._lock3Txt):SetText((TextManager.GetText)((CStringRes:GetRecorder(1565)).msgTextID))
    ;
    (self._resetTime):SetText((TextManager.GetText)(701230))
    self._endTime = 0
    self._totalScore = 0
    ;
    (self._totalNumTxt):SetText(self._totalScore)
    return 
  else
    if not ((NekoData.BehaviorManager).BM_UndecidedRoad):GetSeasonData() then
      local data = {}
    end
    self._endTime = data.leftTime or 0
    if not data.challengeInfo then
      self._challenge = {}
      self._weekBattleData = {}
      self._dailyBattleData = {}
      for id,battleInfo in pairs(self._challenge) do
        -- DECOMPILER ERROR at PC207: Confused about usage of register: R8 in 'UnsetPending'

        -- DECOMPILER ERROR at PC207: Unhandled construct in 'MakeBoolean' P1

        if id ~= BattleType.TRAIN or id == BattleType.WEEK then
          (self._weekBattleData).battletype = BattleType.WEEK
          -- DECOMPILER ERROR at PC210: Confused about usage of register: R8 in 'UnsetPending'

          ;
          (self._weekBattleData).battleId = battleInfo.battleId
          -- DECOMPILER ERROR at PC213: Confused about usage of register: R8 in 'UnsetPending'

          ;
          (self._weekBattleData).score = battleInfo.score
        end
        -- DECOMPILER ERROR at PC219: Confused about usage of register: R8 in 'UnsetPending'

        if id == BattleType.DAILY then
          (self._dailyBattleData).battletype = BattleType.DAILY
          -- DECOMPILER ERROR at PC222: Confused about usage of register: R8 in 'UnsetPending'

          ;
          (self._dailyBattleData).battleId = battleInfo.battleId
          -- DECOMPILER ERROR at PC225: Confused about usage of register: R8 in 'UnsetPending'

          ;
          (self._dailyBattleData).score = battleInfo.score
        end
      end
      ;
      (self._totalNumTxt):SetText(self._totalScore)
      local hasWeekData = next(self._weekBattleData) ~= nil
      ;
      (((self._cell)[2]).bossImg):SetActive(hasWeekData)
      ;
      (((self._cell)[2]).startBtn):SetActive(hasWeekData)
      ;
      (self._bossNameWeekTxt):SetActive(hasWeekData)
      ;
      (self._bossWeekScoreTxt):SetActive(hasWeekData)
      ;
      (self._recommendWeekTxt):SetActive(hasWeekData)
      ;
      (self._recordWeekBtn):SetActive(hasWeekData)
      ;
      (self._txtw1):SetActive(hasWeekData)
      ;
      (self._txtw2):SetActive(hasWeekData)
      do
        local hasDayData = next(self._dailyBattleData) ~= nil
        ;
        (((self._cell)[3]).bossImg):SetActive(hasDayData)
        ;
        (((self._cell)[3]).startBtn):SetActive(hasDayData)
        ;
        (self._bossNameDayTxt):SetActive(hasDayData)
        ;
        (self._bossDayScoreTxt):SetActive(hasDayData)
        ;
        (self._recommendDayTxt):SetActive(hasDayData)
        ;
        (self._recordDayBtn):SetActive(hasDayData)
        ;
        (self._txtd1):SetActive(hasDayData)
        ;
        (self._txtd2):SetActive(hasDayData)
        if hasWeekData then
          (((self._cell)[2]).cell):SetActive(true)
          local battleRecorder = CWeidingBattleConfig:GetRecorder((self._weekBattleData).battleId)
          if not CImagePathTable:GetRecorder(battleRecorder.image) then
            local Image = DataCommon.DefaultImageAsset
          end
          ;
          (((self._cell)[2]).bossImg):SetSprite(Image.assetBundle, Image.assetName)
          ;
          (self._bossNameWeekTxt):SetText((TextManager.GetText)(battleRecorder.nameTextID))
          ;
          (self._bossWeekScoreTxt):SetText((self._weekBattleData).score)
          ;
          (self._recommendWeekTxt):SetText(battleRecorder.recommendpoints)
        else
          (self._cell2Lock):SetActive(true)
          ;
          (self._lock2Txt):SetActive(true)
          ;
          (self._lock2Txt):SetText((TextManager.GetText)((CStringRes:GetRecorder(1565)).msgTextID))
        end
        if hasDayData then
          (((self._cell)[3]).cell):SetActive(true)
          local battleRecorder = CWeidingBattleConfig:GetRecorder((self._dailyBattleData).battleId)
          if not CImagePathTable:GetRecorder(battleRecorder.image) then
            local Image = DataCommon.DefaultImageAsset
          end
          ;
          (((self._cell)[3]).bossImg):SetSprite(Image.assetBundle, Image.assetName)
          ;
          (self._bossNameDayTxt):SetText((TextManager.GetText)(battleRecorder.nameTextID))
          ;
          (self._bossDayScoreTxt):SetText((self._dailyBattleData).score)
          ;
          (self._recommendDayTxt):SetText(battleRecorder.recommendpoints)
          local curday = ((NekoData.BehaviorManager).BM_UndecidedRoad):GetCurDay()
          ;
          (self._dayTxt):SetText((TextManager.GetText)(1901008) .. curday)
        else
          (self._cell3Lock):SetActive(true)
          ;
          (self._lock3Txt):SetActive(true)
          ;
          (self._lock3Txt):SetText((TextManager.GetText)((CStringRes:GetRecorder(1565)).msgTextID))
        end
        if self._task then
          (ServerGameTimer.RemoveTask)(self._task)
          self._task = nil
        end
        self._task = (ServerGameTimer.AddTask)(0, 1, function()
    -- function num : 0_15_0 , upvalues : self
    self:ReloadTask()
  end
, nil)
        -- DECOMPILER ERROR: 10 unprocessed JMP targets
      end
    end
  end
end

UndecidedRoadMainDialog.RefreshAwardRedDot = function(self)
  -- function num : 0_16 , upvalues : _ENV
  (self._rewardRedDot):SetActive(((NekoData.BehaviorManager).BM_UndecidedRoad):HaveAvailable())
end

UndecidedRoadMainDialog.Refresh = function(self)
  -- function num : 0_17 , upvalues : _ENV
  local csend = (LuaNetManager.CreateProtocol)("protocol.activity.copenundecidedroad")
  if csend then
    csend:Send()
  end
  local csend = (LuaNetManager.CreateProtocol)("protocol.activity.copenrewardlist")
  if csend then
    csend:Send()
  end
  ;
  (DialogManager.DestroySingletonDialog)("mainline.undecidedroad.undecidedroadeditdialog")
end

UndecidedRoadMainDialog.OnRankBtnClick = function(self)
  -- function num : 0_18 , upvalues : _ENV, CStringRes
  local isOpen = ((NekoData.BehaviorManager).BM_UndecidedRoad):GetSeasonIsOpen()
  if isOpen then
    (DialogManager.CreateSingletonDialog)("mainline.undecidedroad.undecidedroadrankdialog")
  else
    ;
    ((NekoData.BehaviorManager).BM_Message):AddMessageTip((TextManager.GetText)((CStringRes:GetRecorder(1615)).msgTextID))
  end
end

return UndecidedRoadMainDialog

