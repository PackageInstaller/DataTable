local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CWeidingBattleConfig = BeanManager.GetTableByName("dungeonselect.cweidingbattleconfig")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local UndecidedRoadMainDialog = class("UndecidedRoadMainDialog", Dialog)
local BattleType = LuaNetManager.CreateBean("protocol.activity.challengerecord")
UndecidedRoadMainDialog.AssetBundleName = "ui/layouts.activityroad"
UndecidedRoadMainDialog.AssetName = "ActivityRoadMain"

function UndecidedRoadMainDialog:Ctor(...)
  UndecidedRoadMainDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function UndecidedRoadMainDialog:OnCreate()
  self._cell = {}
  for i = 1, 3 do
    self._cell[i] = {}
    self._cell[i].cell = self:GetChild("Cell" .. i)
    self._cell[i].bossImg = self:GetChild("Cell" .. i .. "/Boss")
    self._cell[i].startBtn = self:GetChild("Cell" .. i .. "/StartBtn")
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
  self._rewardRedDot:SetActive(false)
  self._cell2Lock = self:GetChild("Cell2Lock")
  self._cell3Lock = self:GetChild("Cell3Lock")
  self._lock2Txt = self:GetChild("Cell2Lock/Txt")
  self._lock3Txt = self:GetChild("Cell3Lock/Txt")
  self:GetChild("RankBtn"):Subscribe_PointerClickEvent(self.OnRankBtnClick, self)
  self._cell[1].startBtn:Subscribe_PointerClickEvent(self.OnTrainingClicked, self)
  self._cell[2].startBtn:Subscribe_PointerClickEvent(self.OnWeekStartBtnClicked, self)
  self._cell[3].startBtn:Subscribe_PointerClickEvent(self.OnDayStartBtnClicked, self)
  self._recordWeekBtn:Subscribe_PointerClickEvent(self.OnRecordWeekBtnClicked, self)
  self._recordDayBtn:Subscribe_PointerClickEvent(self.OnRecordDayBtnClicked, self)
  self._tipBtn:Subscribe_PointerClickEvent(self.OnTipBtnClicked, self)
  self._rewardBtn:Subscribe_PointerClickEvent(self.OnRewardBtnClicked, self)
  self._RecordBtn:Subscribe_PointerClickEvent(self.OnRecordBtnClicked, self)
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  NekoData.DataManager.DM_Game:CheckUndecidedRoadRed()
  LuaNotificationCenter.PostNotification(Common.n_RefreshUndecidedRoadRedDot, nil, nil)
  LuaNotificationCenter.AddObserver(self, self.Refresh, Common.n_EnterMianCity, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshUI, Common.n_RefreshUndecidedRoadState, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshAwardRedDot, Common.n_RefreshUndecidedRoadAward, nil)
end

function UndecidedRoadMainDialog:OnDestroy()
  if self._task then
    ServerGameTimer.RemoveTask(self._task)
    self._task = nil
  end
  DialogManager.DestroySingletonDialog("mainline.undecidedroad.undecidedroadruledialog")
  DialogManager.DestroySingletonDialog("mainline.undecidedroad.undecidedroadrewarddialog")
  DialogManager.DestroySingletonDialog("mainline.undecidedroad.undecidedroadrankdialog")
  DialogManager.DestroySingletonDialog("mainline.undecidedroad.undecidedroadbossrecorddialog")
  DialogManager.DestroySingletonDialog("mainline.undecidedroad.undecidedroadrecorddialog")
  LuaNotificationCenter.RemoveObserver(self)
end

function UndecidedRoadMainDialog:Init()
  self:RefreshUI()
  local csend = LuaNetManager.CreateProtocol("protocol.activity.copenrewardlist")
  if csend then
    csend:Send()
  end
end

function UndecidedRoadMainDialog:OnBackBtnClicked()
  self:Destroy()
end

function UndecidedRoadMainDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

function UndecidedRoadMainDialog:OnTrainingClicked()
  local csend = LuaNetManager.CreateProtocol("protocol.activity.copentrain")
  if csend then
    csend:Send()
  end
end

function UndecidedRoadMainDialog:OnWeekStartBtnClicked()
  DialogManager.CreateSingletonDialog("mainline.undecidedroad.undecidedroadeditdialog"):Init(self._weekBattleData)
end

function UndecidedRoadMainDialog:OnDayStartBtnClicked()
  DialogManager.CreateSingletonDialog("mainline.undecidedroad.undecidedroadeditdialog"):Init(self._dailyBattleData)
end

function UndecidedRoadMainDialog:OnRecordWeekBtnClicked()
  NekoData.BehaviorManager.BM_UndecidedRoad:CheckChallengeRecord(BattleType.WEEK, self._weekBattleData.battleId)
end

function UndecidedRoadMainDialog:OnRecordDayBtnClicked()
  NekoData.BehaviorManager.BM_UndecidedRoad:CheckChallengeRecord(BattleType.DAILY, self._dailyBattleData.battleId)
end

function UndecidedRoadMainDialog:OnTipBtnClicked()
  DialogManager.CreateSingletonDialog("mainline.undecidedroad.undecidedroadruledialog"):Init()
end

function UndecidedRoadMainDialog:OnRewardBtnClicked()
  local csend = LuaNetManager.CreateProtocol("protocol.activity.copenrewardlist")
  if csend then
    csend:Send()
  end
  if NekoData.BehaviorManager.BM_UndecidedRoad:GetReceiveIsOpen() then
    local dlg = DialogManager.CreateSingletonDialog("mainline.undecidedroad.undecidedroadrewarddialog")
    if dlg then
      dlg:Init()
    end
  else
    NekoData.BehaviorManager.BM_Message:AddMessageTip(TextManager.GetText(CStringRes:GetRecorder(1615).msgTextID))
  end
end

function UndecidedRoadMainDialog:OnRecordBtnClicked()
  local isOpen = NekoData.BehaviorManager.BM_UndecidedRoad:GetSeasonIsOpen()
  if isOpen then
    NekoData.BehaviorManager.BM_UndecidedRoad:CheckChallengeRecord(BattleType.SEASON)
  else
    NekoData.BehaviorManager.BM_Message:AddMessageTip(TextManager.GetText(CStringRes:GetRecorder(1615).msgTextID))
  end
end

function UndecidedRoadMainDialog:ReloadTask()
  if not self._endTime or self._endTime <= 0 then
    self._resetTime:SetText(TextManager.GetText(701230))
    if self._task then
      ServerGameTimer.RemoveTask(self._task)
      self._task = nil
    end
    return
  end
  self._endTime = self._endTime - 1000
  local sec = math.floor(self._endTime / 1000)
  if sec <= 0 then
    self._resetTime:SetText(TextManager.GetText(701230))
    if self._task then
      ServerGameTimer.RemoveTask(self._task)
      self._task = nil
    end
    return
  end
  local str = TextManager.GetText(1901009)
  str = string.gsub(str, "%$parameter1%$", math.floor(os.date("!%d", sec) - 1))
  str = string.gsub(str, "%$parameter2%$", os.date("!%H", sec))
  self._resetTime:SetText(str)
end

function UndecidedRoadMainDialog:RefreshUI()
  local isOpen = NekoData.BehaviorManager.BM_UndecidedRoad:GetSeasonIsOpen()
  self._cell[2].bossImg:SetActive(false)
  self._cell[2].startBtn:SetActive(false)
  self._bossNameWeekTxt:SetActive(false)
  self._bossWeekScoreTxt:SetActive(false)
  self._recommendWeekTxt:SetActive(false)
  self._recordWeekBtn:SetActive(false)
  self._txtw1:SetActive(false)
  self._txtw2:SetActive(false)
  self._cell[2].cell:SetActive(false)
  self._lock2Txt:SetActive(false)
  self._cell2Lock:SetActive(false)
  self._dayTxt:SetText(TextManager.GetText(1901008))
  self._cell[3].bossImg:SetActive(false)
  self._cell[3].startBtn:SetActive(false)
  self._bossNameDayTxt:SetActive(false)
  self._bossDayScoreTxt:SetActive(false)
  self._recommendDayTxt:SetActive(false)
  self._recordDayBtn:SetActive(false)
  self._txtd1:SetActive(false)
  self._txtd2:SetActive(false)
  self._cell[3].cell:SetActive(false)
  self._lock3Txt:SetActive(false)
  self._cell3Lock:SetActive(false)
  self._totalScore = NekoData.BehaviorManager.BM_UndecidedRoad:GetTotalScore()
  if not isOpen then
    self._cell2Lock:SetActive(true)
    self._cell3Lock:SetActive(true)
    self._lock2Txt:SetActive(true)
    self._lock3Txt:SetActive(true)
    self._lock2Txt:SetText(TextManager.GetText(CStringRes:GetRecorder(1565).msgTextID))
    self._lock3Txt:SetText(TextManager.GetText(CStringRes:GetRecorder(1565).msgTextID))
    self._resetTime:SetText(TextManager.GetText(701230))
    self._endTime = 0
    self._totalScore = 0
    self._totalNumTxt:SetText(self._totalScore)
    return
  else
    local data = NekoData.BehaviorManager.BM_UndecidedRoad:GetSeasonData() or {}
    self._endTime = data.leftTime or 0
    self._challenge = data.challengeInfo or {}
    self._weekBattleData = {}
    self._dailyBattleData = {}
    for id, battleInfo in pairs(self._challenge) do
      if id == BattleType.TRAIN then
      end
      if id == BattleType.WEEK then
        self._weekBattleData.battletype = BattleType.WEEK
        self._weekBattleData.battleId = battleInfo.battleId
        self._weekBattleData.score = battleInfo.score
      end
      if id == BattleType.DAILY then
        self._dailyBattleData.battletype = BattleType.DAILY
        self._dailyBattleData.battleId = battleInfo.battleId
        self._dailyBattleData.score = battleInfo.score
      end
    end
    self._totalNumTxt:SetText(self._totalScore)
    local hasWeekData = next(self._weekBattleData) ~= nil
    self._cell[2].bossImg:SetActive(hasWeekData)
    self._cell[2].startBtn:SetActive(hasWeekData)
    self._bossNameWeekTxt:SetActive(hasWeekData)
    self._bossWeekScoreTxt:SetActive(hasWeekData)
    self._recommendWeekTxt:SetActive(hasWeekData)
    self._recordWeekBtn:SetActive(hasWeekData)
    self._txtw1:SetActive(hasWeekData)
    self._txtw2:SetActive(hasWeekData)
    local hasDayData = next(self._dailyBattleData) ~= nil
    self._cell[3].bossImg:SetActive(hasDayData)
    self._cell[3].startBtn:SetActive(hasDayData)
    self._bossNameDayTxt:SetActive(hasDayData)
    self._bossDayScoreTxt:SetActive(hasDayData)
    self._recommendDayTxt:SetActive(hasDayData)
    self._recordDayBtn:SetActive(hasDayData)
    self._txtd1:SetActive(hasDayData)
    self._txtd2:SetActive(hasDayData)
    if hasWeekData then
      self._cell[2].cell:SetActive(true)
      local battleRecorder = CWeidingBattleConfig:GetRecorder(self._weekBattleData.battleId)
      local Image = CImagePathTable:GetRecorder(battleRecorder.image) or DataCommon.DefaultImageAsset
      self._cell[2].bossImg:SetSprite(Image.assetBundle, Image.assetName)
      self._bossNameWeekTxt:SetText(TextManager.GetText(battleRecorder.nameTextID))
      self._bossWeekScoreTxt:SetText(self._weekBattleData.score)
      self._recommendWeekTxt:SetText(battleRecorder.recommendpoints)
    else
      self._cell2Lock:SetActive(true)
      self._lock2Txt:SetActive(true)
      self._lock2Txt:SetText(TextManager.GetText(CStringRes:GetRecorder(1565).msgTextID))
    end
    if hasDayData then
      self._cell[3].cell:SetActive(true)
      local battleRecorder = CWeidingBattleConfig:GetRecorder(self._dailyBattleData.battleId)
      local Image = CImagePathTable:GetRecorder(battleRecorder.image) or DataCommon.DefaultImageAsset
      self._cell[3].bossImg:SetSprite(Image.assetBundle, Image.assetName)
      self._bossNameDayTxt:SetText(TextManager.GetText(battleRecorder.nameTextID))
      self._bossDayScoreTxt:SetText(self._dailyBattleData.score)
      self._recommendDayTxt:SetText(battleRecorder.recommendpoints)
      local curday = NekoData.BehaviorManager.BM_UndecidedRoad:GetCurDay()
      self._dayTxt:SetText(TextManager.GetText(1901008) .. curday)
    else
      self._cell3Lock:SetActive(true)
      self._lock3Txt:SetActive(true)
      self._lock3Txt:SetText(TextManager.GetText(CStringRes:GetRecorder(1565).msgTextID))
    end
    if self._task then
      ServerGameTimer.RemoveTask(self._task)
      self._task = nil
    end
    self._task = ServerGameTimer.AddTask(0, 1, function()
      self:ReloadTask()
    end, nil)
  end
end

function UndecidedRoadMainDialog:RefreshAwardRedDot()
  self._rewardRedDot:SetActive(NekoData.BehaviorManager.BM_UndecidedRoad:HaveAvailable())
end

function UndecidedRoadMainDialog:Refresh()
  local csend = LuaNetManager.CreateProtocol("protocol.activity.copenundecidedroad")
  if csend then
    csend:Send()
  end
  local csend = LuaNetManager.CreateProtocol("protocol.activity.copenrewardlist")
  if csend then
    csend:Send()
  end
  DialogManager.DestroySingletonDialog("mainline.undecidedroad.undecidedroadeditdialog")
end

function UndecidedRoadMainDialog:OnRankBtnClick()
  local isOpen = NekoData.BehaviorManager.BM_UndecidedRoad:GetSeasonIsOpen()
  if isOpen then
    DialogManager.CreateSingletonDialog("mainline.undecidedroad.undecidedroadrankdialog")
  else
    NekoData.BehaviorManager.BM_Message:AddMessageTip(TextManager.GetText(CStringRes:GetRecorder(1615).msgTextID))
  end
end

return UndecidedRoadMainDialog
