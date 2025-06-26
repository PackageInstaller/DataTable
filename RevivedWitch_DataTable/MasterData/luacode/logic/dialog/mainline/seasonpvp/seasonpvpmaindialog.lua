-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/seasonpvp/seasonpvpmaindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local HeadPhotoTable = (BeanManager.GetTableByName)("headphoto.cheadphotoconfig")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local HeadPhotoFrameTable = (BeanManager.GetTableByName)("headphoto.cheadphotoframeconfig")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CDreamCellBattleInfo = (BeanManager.GetTableByName)("dungeonselect.cdreamcellbattleinfo")
local CDreamRank = (BeanManager.GetTableByName)("dungeonselect.cdreamrank")
local CDreamMain = (BeanManager.GetTableByName)("dungeonselect.cdreammain")
local CDreamTopic = (BeanManager.GetTableByName)("dungeonselect.cdreamtopic")
local timeutils = require("logic.utils.timeutils")
local CDreamPara = (BeanManager.GetTableByName)("dungeonselect.cdreampara")
local Item = require("logic.manager.experimental.types.item")
local Role = require("logic.manager.experimental.types.role")
local TableFrame = require("framework.ui.frame.table.tableframe")
local RedDotManager = require("logic.redpoint.reddotmanager")
local SeasonPvpMainDialog = class("SeasonPvpMainDialog", Dialog)
SeasonPvpMainDialog.AssetBundleName = "ui/layouts.seasonpvp"
SeasonPvpMainDialog.AssetName = "SeasonPVPMain"
SeasonPvpMainDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SeasonPvpMainDialog
  ((SeasonPvpMainDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._showNumbers = {1, 2, 3}
  self.enemyInfo = {}
end

SeasonPvpMainDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._cells = {}
  self._photos = {}
  self._headFrames = {}
  self._names = {}
  self._levels = {}
  self._teams = {}
  self._startBtn = {}
  self._teamRank = {}
  self._teamScore = {}
  for i = 1, 4 do
    do
      -- DECOMPILER ERROR at PC36: Confused about usage of register: R5 in 'UnsetPending'

      (self._cells)[i] = self:GetChild("CardCell" .. i)
      -- DECOMPILER ERROR at PC44: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (self._photos)[i] = self:GetChild("CardCell" .. i .. "/PlayerInfo/HeadPhoto/Photo")
      -- DECOMPILER ERROR at PC52: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (self._headFrames)[i] = self:GetChild("CardCell" .. i .. "/PlayerInfo/HeadPhoto/Frame")
      -- DECOMPILER ERROR at PC60: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (self._names)[i] = self:GetChild("CardCell" .. i .. "/PlayerInfo/NameBack/Name")
      ;
      ((self._names)[i]):SetText("")
      -- DECOMPILER ERROR at PC73: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (self._levels)[i] = self:GetChild("CardCell" .. i .. "/PlayerInfo/Level/Num")
      ;
      ((self._levels)[i]):SetText("")
      -- DECOMPILER ERROR at PC86: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (self._teamRank)[i] = self:GetChild("CardCell" .. i .. "/Rank/Num")
      ;
      ((self._teamRank)[i]):SetText("")
      -- DECOMPILER ERROR at PC99: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (self._teamScore)[i] = self:GetChild("CardCell" .. i .. "/Point/Num")
      ;
      ((self._teamScore)[i]):SetText("")
      -- DECOMPILER ERROR at PC112: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (self._startBtn)[i] = self:GetChild("CardCell" .. i .. "/StartBtn")
      ;
      ((self._startBtn)[i]):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnStartBtnClicked(i)
  end
, self)
      -- DECOMPILER ERROR at PC121: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (self._teams)[i] = {}
      -- DECOMPILER ERROR at PC130: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._teams)[i]).panel = self:GetChild("CardCell" .. i .. "/Team/Back")
      -- DECOMPILER ERROR at PC134: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._teams)[i]).charPanel = {}
      -- DECOMPILER ERROR at PC138: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._teams)[i])._frame = {}
      -- DECOMPILER ERROR at PC142: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._teams)[i])._photo = {}
      -- DECOMPILER ERROR at PC146: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._teams)[i])._unkown = {}
      -- DECOMPILER ERROR at PC150: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._teams)[i])._downRankBack = {}
      -- DECOMPILER ERROR at PC154: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._teams)[i])._level = {}
      -- DECOMPILER ERROR at PC158: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._teams)[i])._rankBack = {}
      -- DECOMPILER ERROR at PC162: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._teams)[i])._rank = {}
      -- DECOMPILER ERROR at PC166: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._teams)[i])._job = {}
      -- DECOMPILER ERROR at PC170: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._teams)[i])._breakLevelBackBlack = {}
      -- DECOMPILER ERROR at PC174: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._teams)[i])._breakLevelBack = {}
      -- DECOMPILER ERROR at PC178: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._teams)[i])._breakLevelNum = {}
      -- DECOMPILER ERROR at PC182: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._teams)[i])._breakLevel = {}
      -- DECOMPILER ERROR at PC186: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._teams)[i])._element = {}
      -- DECOMPILER ERROR at PC190: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._teams)[i])._grey = {}
      -- DECOMPILER ERROR at PC194: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._teams)[i])._select = {}
      -- DECOMPILER ERROR at PC198: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._teams)[i]).charUpgrade = {}
      for j = 1, 3 do
        do
          -- DECOMPILER ERROR at PC213: Confused about usage of register: R9 in 'UnsetPending'

          (((self._teams)[i]).charPanel)[j] = self:GetChild("CardCell" .. i .. "/Team/Char" .. j)
          -- DECOMPILER ERROR at PC225: Confused about usage of register: R9 in 'UnsetPending'

          ;
          (((self._teams)[i])._frame)[j] = self:GetChild("CardCell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/Frame")
          -- DECOMPILER ERROR at PC237: Confused about usage of register: R9 in 'UnsetPending'

          ;
          (((self._teams)[i])._photo)[j] = self:GetChild("CardCell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/Photo")
          -- DECOMPILER ERROR at PC249: Confused about usage of register: R9 in 'UnsetPending'

          ;
          (((self._teams)[i])._unkown)[j] = self:GetChild("CardCell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/Unknown")
          ;
          ((((self._teams)[i])._unkown)[j]):SetActive(false)
          -- DECOMPILER ERROR at PC268: Confused about usage of register: R9 in 'UnsetPending'

          ;
          (((self._teams)[i])._downRankBack)[j] = self:GetChild("CardCell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/DownRankBack")
          -- DECOMPILER ERROR at PC280: Confused about usage of register: R9 in 'UnsetPending'

          ;
          (((self._teams)[i])._level)[j] = self:GetChild("CardCell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/Level/Num")
          ;
          ((((self._teams)[i])._level)[j]):SetText("")
          -- DECOMPILER ERROR at PC299: Confused about usage of register: R9 in 'UnsetPending'

          ;
          (((self._teams)[i])._rankBack)[j] = self:GetChild("CardCell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/RankBack")
          -- DECOMPILER ERROR at PC311: Confused about usage of register: R9 in 'UnsetPending'

          ;
          (((self._teams)[i])._rank)[j] = self:GetChild("CardCell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/Rank")
          ;
          ((((self._teams)[i])._rank)[j]):SetActive(false)
          -- DECOMPILER ERROR at PC330: Confused about usage of register: R9 in 'UnsetPending'

          ;
          (((self._teams)[i])._job)[j] = self:GetChild("CardCell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/Job")
          ;
          ((((self._teams)[i])._job)[j]):SetActive(false)
          -- DECOMPILER ERROR at PC349: Confused about usage of register: R9 in 'UnsetPending'

          ;
          (((self._teams)[i])._breakLevelBackBlack)[j] = self:GetChild("CardCell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/BreakLevelBackBlack")
          -- DECOMPILER ERROR at PC361: Confused about usage of register: R9 in 'UnsetPending'

          ;
          (((self._teams)[i])._breakLevelBack)[j] = self:GetChild("CardCell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/BreakLevelBack")
          -- DECOMPILER ERROR at PC373: Confused about usage of register: R9 in 'UnsetPending'

          ;
          (((self._teams)[i])._breakLevelNum)[j] = self:GetChild("CardCell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/BreakLevelNum")
          ;
          ((((self._teams)[i])._breakLevelNum)[j]):SetText("")
          -- DECOMPILER ERROR at PC392: Confused about usage of register: R9 in 'UnsetPending'

          ;
          (((self._teams)[i])._breakLevel)[j] = self:GetChild("CardCell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/BreakLevel")
          -- DECOMPILER ERROR at PC404: Confused about usage of register: R9 in 'UnsetPending'

          ;
          (((self._teams)[i])._element)[j] = self:GetChild("CardCell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/Element")
          ;
          ((((self._teams)[i])._element)[j]):SetActive(false)
          -- DECOMPILER ERROR at PC423: Confused about usage of register: R9 in 'UnsetPending'

          ;
          (((self._teams)[i])._grey)[j] = self:GetChild("CardCell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/Grey")
          -- DECOMPILER ERROR at PC435: Confused about usage of register: R9 in 'UnsetPending'

          ;
          (((self._teams)[i])._select)[j] = self:GetChild("CardCell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/Select")
          ;
          ((((self._teams)[i])._frame)[j]):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_1 , upvalues : self, i, j
    self:OnCellClicked(i, j)
  end
, self)
          -- DECOMPILER ERROR at PC459: Confused about usage of register: R9 in 'UnsetPending'

          ;
          (((self._teams)[i]).charUpgrade)[j] = {panel = self:GetChild("CardCell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/CharUpgrade"), 
levelImage = {}
}
          for k = 1, 5 do
            -- DECOMPILER ERROR at PC478: Confused about usage of register: R13 in 'UnsetPending'

            (((((self._teams)[i]).charUpgrade)[j]).levelImage)[k] = self:GetChild("CardCell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/CharUpgrade/Img" .. k)
          end
        end
      end
    end
  end
  self._refrashBtn = self:GetChild("ChangeBtn")
  self._rewardBtn = self:GetChild("SoldBtn")
  self._rewardRed = self:GetChild("SoldBtn/RedDot")
  ;
  (self._rewardRed):SetActive(false)
  ;
  (self._refrashBtn):Subscribe_PointerClickEvent(self.OnRefrashBtnBtnClicked, self)
  ;
  (self._rewardBtn):Subscribe_PointerClickEvent(self.OpenRewardDialog, self)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._endTimeText = self:GetChild("Time/Txt2")
  self._DefenseBtn = self:GetChild("RecordBtn")
  ;
  (self._DefenseBtn):Subscribe_PointerClickEvent(self.OnRecordBtnClicked, self)
  self._attackTeamBtn = self:GetChild("TeamSet/GoBtn1")
  ;
  (self._attackTeamBtn):Subscribe_PointerClickEvent(self.OnAttackTeamBtnClicked, self)
  self._defenseTeamBtn = self:GetChild("TeamSet/GoBtn2")
  ;
  (self._defenseTeamBtn):Subscribe_PointerClickEvent(self.OnDefenseTeamBtnClicked, self)
  self._rankImage = self:GetChild("CurrentRank")
  self._rankText = self:GetChild("CurrentRank/NumMax")
  ;
  (self._rankText):SetText("")
  self._TopicList = {}
  for i = 1, 2 do
    -- DECOMPILER ERROR at PC571: Confused about usage of register: R5 in 'UnsetPending'

    (self._TopicList)[i] = {}
    -- DECOMPILER ERROR at PC579: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._TopicList)[i]).Icon = self:GetChild("Theme/Icon" .. i)
    ;
    (((self._TopicList)[i]).Icon):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_2 , upvalues : self, i
    self:OnTopicClicked(i)
  end
, self)
    -- DECOMPILER ERROR at PC594: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._TopicList)[i]).Name = self:GetChild("Theme/Name" .. i)
    ;
    (((self._TopicList)[i]).Name):SetText("")
    ;
    (((self._TopicList)[i]).Name):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_3 , upvalues : self, i
    self:OnTopicClicked(i)
  end
, self)
  end
  self._rankProgress = self:GetChild("Rank/ProgressBack/Progress")
  self._rankScoreCurText = self:GetChild("Rank/ProgressBack/Num/Num")
  ;
  (self._rankScoreCurText):SetText("")
  self._rankScoreMaxText = self:GetChild("Rank/ProgressBack/Num/NumMax")
  ;
  (self._rankScoreMaxText):SetText("")
  self._nextRankText = self:GetChild("Rank/NextRank")
  ;
  (self._nextRankText):SetText("")
  self._rankBtn = self:GetChild("RankBtn")
  ;
  (self._rankBtn):Subscribe_PointerClickEvent(self.OnRankBtnClicked, self)
  self._tipsBtn = self:GetChild("Tips/Ibtn")
  ;
  (self._tipsBtn):Subscribe_PointerClickEvent(self.OnTipsBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.ReloadRTopFrame, Common.n_RefreshCurrency, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnBagDialogDestroy, Common.n_DialogWillDestroy, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefrashRewardRed, Common.n_SeasonPvpAward, nil)
end

SeasonPvpMainDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

SeasonPvpMainDialog.Init = function(self)
  -- function num : 0_3 , upvalues : RedDotManager, _ENV, CDreamRank, CImagePathTable, CDreamMain, CDreamTopic, HeadPhotoTable, HeadPhotoFrameTable, CDreamPara, Role, timeutils
  (RedDotManager.ClearSeasonRedDot)()
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_RefreshFragmentPanelRed, nil)
  self._data = ((NekoData.BehaviorManager).BM_Battle):GetSeasonData()
  local awardData = {items = ((NekoData.BehaviorManager).BM_Activity):GetArenaReceiveAward()}
  if awardData.items and #awardData.items > 0 then
    ((NekoData.DataManager).DM_ItemAccountShow):AddShowDialogData({tag = (DataCommon.ShowDialogType).ItemAccount, data = awardData})
    ;
    ((NekoData.DataManager).DM_Activity):ClearArenaReceiveAward()
    ;
    (LuaNotificationCenter.AddObserver)(self, self.OnBagDialogDestroy, Common.n_DialogWillDestroy, nil)
    return 
  end
  local RankRecorder = CDreamRank:GetRecorder((self._data).stage)
  local spriteRecord = CImagePathTable:GetRecorder(RankRecorder.rankBigIcon)
  ;
  (self._rankImage):SetSprite(spriteRecord.assetBundle, spriteRecord.assetName)
  ;
  (self._rankText):SetText(RankRecorder.rankName)
  local MainRecorder = CDreamMain:GetRecorder((self._data).seasonId)
  local TopicList = (string.split)(MainRecorder.seasonTopic, ";")
  for i,v in ipairs(TopicList) do
    local Topic = tonumber(v)
    local TopicRecorder = CDreamTopic:GetRecorder(Topic)
    if TopicRecorder then
      local spriteRecord = CImagePathTable:GetRecorder(TopicRecorder.topicIcon)
      if spriteRecord then
        (((self._TopicList)[i]).Icon):SetSprite(spriteRecord.assetBundle, spriteRecord.assetName)
      end
      ;
      (((self._TopicList)[i]).Name):SetText((TextManager.GetText)(TopicRecorder.topicName))
    end
  end
  self._rankProgress = self:GetChild("Rank/ProgressBack/Progress")
  ;
  (self._rankScoreCurText):SetText((self._data).currentScore)
  ;
  (self._rankScoreMaxText):SetText(RankRecorder.rankUp)
  local progress = (self._data).currentScore / RankRecorder.rankUp
  ;
  (self._rankProgress):SetFillAmount(progress)
  local NextRankRecorder = CDreamRank:GetRecorder((self._data).stage + 1)
  if NextRankRecorder then
    (self._nextRankText):SetText(NextRankRecorder.rankName)
  else
    ;
    (self._nextRankText):SetText(RankRecorder.rankName)
  end
  for i,lineupInfo in ipairs((self._data).enemyInfo) do
    local headPhotoRecord = (HeadPhotoTable:GetRecorder((lineupInfo.enemyUserData).avatarId))
    local imageRecord = nil
    if headPhotoRecord then
      if not CImagePathTable:GetRecorder(headPhotoRecord.photoid) then
        imageRecord = DataCommon.DefaultImageAsset
      end
      ;
      ((self._photos)[i]):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    else
      LogErrorFormat("SeasonPvpMainDialog", "userInfo.avatarId %s is wrong", (lineupInfo.enemyUserData).avatarId)
    end
    local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder((lineupInfo.enemyUserData).frameId)
    if headPhotoFrameRecord then
      if not CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) then
        imageRecord = DataCommon.DefaultImageAsset
      end
      ;
      ((self._headFrames)[i]):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    else
      LogErrorFormat("SeasonPvpMainDialog", "userInfo.frameId %s is wrong", (lineupInfo.enemyUserData).frameId)
    end
    ;
    ((self._names)[i]):SetText((lineupInfo.enemyUserData).userName)
    ;
    ((self._levels)[i]):SetText((lineupInfo.enemyUserData).userLv)
    ;
    ((self._teamScore)[i]):SetText(lineupInfo.score)
    local TeamRankRecorder = CDreamRank:GetRecorder(lineupInfo.stage)
    if TeamRankRecorder then
      ((self._teamRank)[i]):SetText(TeamRankRecorder.rankName)
    end
    local dreamPara = (CDreamPara:GetRecorder(i)).value
    for m = #self._showNumbers, 2, -1 do
      local n = (math.random)(1, m)
      -- DECOMPILER ERROR at PC267: Confused about usage of register: R24 in 'UnsetPending'

      -- DECOMPILER ERROR at PC268: Confused about usage of register: R23 in 'UnsetPending'

      ;
      (self._showNumbers)[m] = (self._showNumbers)[n]
    end
    local hideList = {}
    for k = 1, dreamPara do
      hideList[(self._showNumbers)[k]] = true
    end
    -- DECOMPILER ERROR at PC281: Confused about usage of register: R19 in 'UnsetPending'

    ;
    (self.enemyInfo)[i] = {}
    -- DECOMPILER ERROR at PC284: Confused about usage of register: R19 in 'UnsetPending'

    ;
    ((self.enemyInfo)[i]).hideList = hideList
    for j = 1, 3 do
      local roleInfo = (lineupInfo.enemyRoleList)[j]
      if roleInfo then
        ((((self._teams)[i]).charPanel)[j]):SetActive(true)
        local tempRole = (Role.Create)(roleInfo.id)
        tempRole:SetLevel(roleInfo.lv)
        tempRole:SetBreakLv(roleInfo.breakLv)
        tempRole:SetRuneLevel(roleInfo.runeLevel)
        ;
        ((((self._teams)[i])._unkown)[j]):SetActive(false)
        ;
        ((((self._teams)[i])._photo)[j]):SetActive(false)
        ;
        ((((self._teams)[i])._frame)[j]):SetActive(true)
        ;
        ((((self._teams)[i])._downRankBack)[j]):SetActive(true)
        ;
        ((((self._teams)[i])._rank)[j]):SetActive(false)
        ;
        ((((self._teams)[i])._job)[j]):SetActive(false)
        ;
        ((((self._teams)[i])._breakLevelBackBlack)[j]):SetActive(false)
        ;
        ((((self._teams)[i])._breakLevelBack)[j]):SetActive(true)
        ;
        ((((self._teams)[i])._breakLevelNum)[j]):SetActive(false)
        ;
        ((((self._teams)[i])._element)[j]):SetActive(false)
        ;
        (((((self._teams)[i]).charUpgrade)[j]).panel):SetActive(false)
        for k = 1, 5 do
          ((((((self._teams)[i]).charUpgrade)[j]).levelImage)[k]):SetActive(false)
        end
        if hideList[j] then
          ((((self._teams)[i])._unkown)[j]):SetActive(true)
          ;
          ((((self._teams)[i])._level)[j]):SetText("?")
          local image = CImagePathTable:GetRecorder(10473)
          ;
          ((((self._teams)[i])._frame)[j]):SetSprite(image.assetBundle, image.assetName)
          image = CImagePathTable:GetRecorder(12842)
          ;
          ((((self._teams)[i])._downRankBack)[j]):SetSprite(image.assetBundle, image.assetName)
        else
          do
            do
              local image = tempRole:GetShapeLittleHeadImageRecord()
              ;
              ((((self._teams)[i])._photo)[j]):SetSprite(image.assetBundle, image.assetName)
              ;
              ((((self._teams)[i])._photo)[j]):SetActive(true)
              image = tempRole:GetSmallRarityFrameRecord()
              ;
              ((((self._teams)[i])._frame)[j]):SetSprite(image.assetBundle, image.assetName)
              ;
              ((((self._teams)[i])._frame)[j]):SetActive(true)
              image = tempRole:GetRarityBottomBackRecord()
              ;
              ((((self._teams)[i])._downRankBack)[j]):SetSprite(image.assetBundle, image.assetName)
              ;
              ((((self._teams)[i])._downRankBack)[j]):SetActive(true)
              ;
              ((((self._teams)[i])._level)[j]):SetText(tempRole:GetShowLv())
              image = tempRole:GetRarityImageRecord()
              ;
              ((((self._teams)[i])._rank)[j]):SetSprite(image.assetBundle, image.assetName)
              ;
              ((((self._teams)[i])._rank)[j]):SetActive(true)
              image = tempRole:GetVocationImageRecord()
              ;
              ((((self._teams)[i])._job)[j]):SetSprite(image.assetBundle, image.assetName)
              ;
              ((((self._teams)[i])._job)[j]):SetActive(true)
              local breakLv = tempRole:GetBreakLv()
              ;
              ((((self._teams)[i])._breakLevelBackBlack)[j]):SetActive(breakLv == 0)
              ;
              ((((self._teams)[i])._breakLevelBack)[j]):SetActive(breakLv > 0)
              ;
              ((((self._teams)[i])._breakLevelNum)[j]):SetActive(breakLv > 0)
              if breakLv > 0 then
                image = tempRole:GetCurBreakFrame1ImageRecord()
                ;
                ((((self._teams)[i])._breakLevelBack)[j]):SetSprite(image.assetBundle, image.assetName)
                ;
                ((((self._teams)[i])._breakLevelBack)[j]):SetActive(true)
                ;
                ((((self._teams)[i])._breakLevelNum)[j]):SetText(breakLv)
                ;
                ((((self._teams)[i])._breakLevelNum)[j]):SetActive(true)
              end
              image = tempRole:GetElementImageRecord()
              ;
              ((((self._teams)[i])._element)[j]):SetSprite(image.assetBundle, image.assetName)
              ;
              ((((self._teams)[i])._element)[j]):SetActive(true)
              local level = tempRole:GetRuneLevel()
              ;
              (((((self._teams)[i]).charUpgrade)[j]).panel):SetActive(level ~= 0)
              for k = 1, 5 do
                ((((((self._teams)[i]).charUpgrade)[j]).levelImage)[k]):SetActive(level == k)
              end
              ;
              ((((self._teams)[i]).charPanel)[j]):SetActive(false)
              -- DECOMPILER ERROR at PC666: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC666: LeaveBlock: unexpected jumping out IF_ELSE_STMT

              -- DECOMPILER ERROR at PC666: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC666: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC666: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    end
  end
  self._moneyTypeInfo = {
{moneyType = DataCommon.PVPKeys}
, 
{moneyType = DataCommon.PVPCoin}
}
  ;
  (self._endTimeText):SetText((timeutils.getLeftTimeStr)((self._data).leftTime))
  self:RefrashRewardRed()
  -- DECOMPILER ERROR: 9 unprocessed JMP targets
end

SeasonPvpMainDialog.RefrashRewardRed = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if (((NekoData.BehaviorManager).BM_Battle):GetSeasonNotify()).award and (((NekoData.BehaviorManager).BM_Battle):GetSeasonNotify()).award > 0 then
    (self._rewardRed):SetActive(true)
  else
    ;
    (self._rewardRed):SetActive(false)
  end
end

SeasonPvpMainDialog.OnStartBtnClicked = function(self, index)
  -- function num : 0_5 , upvalues : _ENV
  local data = ((NekoData.BehaviorManager).BM_Battle):GetSeasonData()
  local isSetAttackTeam = false
  local isDefendTeam = false
  for k,v in pairs(data.attackTeam) do
    if v > 0 then
      isSetAttackTeam = true
      break
    end
  end
  do
    for k,v in pairs(data.defendTeam) do
      if v > 0 then
        isDefendTeam = true
        break
      end
    end
    do
      if not isSetAttackTeam or not isDefendTeam then
        ((NekoData.BehaviorManager).BM_Message):SendMessageById(100508)
        return 
      end
      if data.leftAttackAccessPoint <= 0 then
        ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(151, nil, function()
    -- function num : 0_5_0 , upvalues : _ENV, index
    local fantasyProtocol = (LuaNetManager.CreateProtocol)("protocol.battle.cfantasyconflictbattlestart")
    if fantasyProtocol then
      fantasyProtocol.enemyID = index
      fantasyProtocol:Send()
    end
  end
)
        return 
      end
      local fantasyProtocol = (LuaNetManager.CreateProtocol)("protocol.battle.cfantasyconflictbattlestart")
      if fantasyProtocol then
        fantasyProtocol.enemyID = index
        fantasyProtocol:Send()
      end
    end
  end
end

SeasonPvpMainDialog.OnBagDialogDestroy = function(self, notification)
  -- function num : 0_6 , upvalues : _ENV
  if (notification.userInfo)._dialogName == "bag.itemaccountdialog" then
    self:Init(self._data)
    ;
    (LuaNotificationCenter.RemoveObserver)(self, Common.n_DialogWillDestroy)
  end
end

SeasonPvpMainDialog.OnCellClicked = function(self, teamIndex, roleIndex)
  -- function num : 0_7 , upvalues : _ENV
  if (((self.enemyInfo)[teamIndex]).hideList)[roleIndex] then
    return 
  end
  local roleList = {}
  for i,v in pairs((((self._data).enemyInfo)[teamIndex]).enemyRoleList) do
    if not (((self.enemyInfo)[teamIndex]).hideList)[i] then
      (table.insert)(roleList, v)
    end
  end
  local newList = {}
  local idx = 0
  local curIdx = 0
  for index,v in ipairs(roleList) do
    idx = idx + 1
    ;
    (table.insert)(newList, v)
    if v.id == (((((self._data).enemyInfo)[teamIndex]).enemyRoleList)[roleIndex]).id then
      curIdx = idx
    end
  end
  local dlg = (DialogManager.CreateSingletonDialog)("mainline.bossrush.checkotherroleinfodialog")
  if dlg then
    dlg:Init({index = curIdx, roleList = roleList}, (dlg.ShowType).PVP)
  end
end

SeasonPvpMainDialog.OnRefrashBtnBtnClicked = function(self)
  -- function num : 0_8 , upvalues : _ENV
  local csend = (LuaNetManager.CreateProtocol)("protocol.battle.cfantasyconflictresetenemy")
  if csend then
    csend:Send()
  end
end

SeasonPvpMainDialog.OnRecordBtnClicked = function(self)
  -- function num : 0_9 , upvalues : _ENV
  local csend = (LuaNetManager.CreateProtocol)("protocol.battle.cfantasyconflictdefendrecord")
  csend:Send()
end

SeasonPvpMainDialog.OnAttackTeamBtnClicked = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("mainline.seasonpvp.seasonteameditdialog")
  if dialog then
    dialog:SetData(1)
  end
end

SeasonPvpMainDialog.OnDefenseTeamBtnClicked = function(self)
  -- function num : 0_11 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("mainline.seasonpvp.seasonteameditdialog")
  if dialog then
    dialog:SetData(0)
  end
end

SeasonPvpMainDialog.OpenRewardDialog = function(self)
  -- function num : 0_12 , upvalues : _ENV
  local csend = (LuaNetManager.CreateProtocol)("protocol.battle.cfantasyconflictshowrewardprogress")
  csend:Send()
end

SeasonPvpMainDialog.NumberOfCell = function(self, frame)
  -- function num : 0_13
  if frame == self._topGroupFrame then
    return #self._moneyTypeInfo
  end
end

SeasonPvpMainDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_14
  if frame == self._topGroupFrame then
    return "shop.shoptopgroupcell"
  end
end

SeasonPvpMainDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_15
  if frame == self._topGroupFrame then
    return (self._moneyTypeInfo)[index]
  end
end

SeasonPvpMainDialog.OnBackBtnClicked = function(self)
  -- function num : 0_16
  self:Destroy()
end

SeasonPvpMainDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_17 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

SeasonPvpMainDialog.ReloadRTopFrame = function(self)
  -- function num : 0_18
end

SeasonPvpMainDialog.OnRankBtnClicked = function(self)
  -- function num : 0_19 , upvalues : _ENV
  local csend = (LuaNetManager.CreateProtocol)("protocol.ranking.carenaranking")
  csend.index = 0
  csend:Send()
end

SeasonPvpMainDialog.OnTopicClicked = function(self, index)
  -- function num : 0_20 , upvalues : CDreamMain, _ENV, CDreamTopic
  local MainRecorder = CDreamMain:GetRecorder((self._data).seasonId)
  local TopicList = (string.split)(MainRecorder.seasonTopic, ";")
  local Topic = tonumber(TopicList[index])
  local TopicRecorder = CDreamTopic:GetRecorder(Topic)
  local dialog = (DialogManager.CreateSingletonDialog)("mainline.seasonpvp.seasonpvpthemetips")
  if dialog then
    dialog:Init(TopicRecorder)
  end
end

SeasonPvpMainDialog.OnTipsBtnClicked = function(self)
  -- function num : 0_21 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("mainline.seasonpvp.seasonpvptipsdialog")):SetData(2256)
end

return SeasonPvpMainDialog

