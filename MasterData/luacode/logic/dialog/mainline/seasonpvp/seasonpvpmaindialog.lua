local HeadPhotoTable = BeanManager.GetTableByName("headphoto.cheadphotoconfig")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local HeadPhotoFrameTable = BeanManager.GetTableByName("headphoto.cheadphotoframeconfig")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CDreamCellBattleInfo = BeanManager.GetTableByName("dungeonselect.cdreamcellbattleinfo")
local CDreamRank = BeanManager.GetTableByName("dungeonselect.cdreamrank")
local CDreamMain = BeanManager.GetTableByName("dungeonselect.cdreammain")
local CDreamTopic = BeanManager.GetTableByName("dungeonselect.cdreamtopic")
local timeutils = require("logic.utils.timeutils")
local CDreamPara = BeanManager.GetTableByName("dungeonselect.cdreampara")
local Item = require("logic.manager.experimental.types.item")
local Role = require("logic.manager.experimental.types.role")
local TableFrame = require("framework.ui.frame.table.tableframe")
local RedDotManager = require("logic.redpoint.reddotmanager")
local SeasonPvpMainDialog = class("SeasonPvpMainDialog", Dialog)
SeasonPvpMainDialog.AssetBundleName = "ui/layouts.seasonpvp"
SeasonPvpMainDialog.AssetName = "SeasonPVPMain"

function SeasonPvpMainDialog:Ctor(...)
  SeasonPvpMainDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._showNumbers = {
    1,
    2,
    3
  }
  self.enemyInfo = {}
end

function SeasonPvpMainDialog:OnCreate()
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
    self._cells[i] = self:GetChild("CardCell" .. i)
    self._photos[i] = self:GetChild("CardCell" .. i .. "/PlayerInfo/HeadPhoto/Photo")
    self._headFrames[i] = self:GetChild("CardCell" .. i .. "/PlayerInfo/HeadPhoto/Frame")
    self._names[i] = self:GetChild("CardCell" .. i .. "/PlayerInfo/NameBack/Name")
    self._names[i]:SetText("")
    self._levels[i] = self:GetChild("CardCell" .. i .. "/PlayerInfo/Level/Num")
    self._levels[i]:SetText("")
    self._teamRank[i] = self:GetChild("CardCell" .. i .. "/Rank/Num")
    self._teamRank[i]:SetText("")
    self._teamScore[i] = self:GetChild("CardCell" .. i .. "/Point/Num")
    self._teamScore[i]:SetText("")
    self._startBtn[i] = self:GetChild("CardCell" .. i .. "/StartBtn")
    self._startBtn[i]:Subscribe_PointerClickEvent(function()
      self:OnStartBtnClicked(i)
    end, self)
    self._teams[i] = {}
    self._teams[i].panel = self:GetChild("CardCell" .. i .. "/Team/Back")
    self._teams[i].charPanel = {}
    self._teams[i]._frame = {}
    self._teams[i]._photo = {}
    self._teams[i]._unkown = {}
    self._teams[i]._downRankBack = {}
    self._teams[i]._level = {}
    self._teams[i]._rankBack = {}
    self._teams[i]._rank = {}
    self._teams[i]._job = {}
    self._teams[i]._breakLevelBackBlack = {}
    self._teams[i]._breakLevelBack = {}
    self._teams[i]._breakLevelNum = {}
    self._teams[i]._breakLevel = {}
    self._teams[i]._element = {}
    self._teams[i]._grey = {}
    self._teams[i]._select = {}
    self._teams[i].charUpgrade = {}
    for j = 1, 3 do
      self._teams[i].charPanel[j] = self:GetChild("CardCell" .. i .. "/Team/Char" .. j)
      self._teams[i]._frame[j] = self:GetChild("CardCell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/Frame")
      self._teams[i]._photo[j] = self:GetChild("CardCell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/Photo")
      self._teams[i]._unkown[j] = self:GetChild("CardCell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/Unknown")
      self._teams[i]._unkown[j]:SetActive(false)
      self._teams[i]._downRankBack[j] = self:GetChild("CardCell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/DownRankBack")
      self._teams[i]._level[j] = self:GetChild("CardCell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/Level/Num")
      self._teams[i]._level[j]:SetText("")
      self._teams[i]._rankBack[j] = self:GetChild("CardCell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/RankBack")
      self._teams[i]._rank[j] = self:GetChild("CardCell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/Rank")
      self._teams[i]._rank[j]:SetActive(false)
      self._teams[i]._job[j] = self:GetChild("CardCell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/Job")
      self._teams[i]._job[j]:SetActive(false)
      self._teams[i]._breakLevelBackBlack[j] = self:GetChild("CardCell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/BreakLevelBackBlack")
      self._teams[i]._breakLevelBack[j] = self:GetChild("CardCell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/BreakLevelBack")
      self._teams[i]._breakLevelNum[j] = self:GetChild("CardCell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/BreakLevelNum")
      self._teams[i]._breakLevelNum[j]:SetText("")
      self._teams[i]._breakLevel[j] = self:GetChild("CardCell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/BreakLevel")
      self._teams[i]._element[j] = self:GetChild("CardCell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/Element")
      self._teams[i]._element[j]:SetActive(false)
      self._teams[i]._grey[j] = self:GetChild("CardCell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/Grey")
      self._teams[i]._select[j] = self:GetChild("CardCell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/Select")
      self._teams[i]._frame[j]:Subscribe_PointerClickEvent(function()
        self:OnCellClicked(i, j)
      end, self)
      self._teams[i].charUpgrade[j] = {
        panel = self:GetChild("CardCell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/CharUpgrade"),
        levelImage = {}
      }
      for k = 1, 5 do
        self._teams[i].charUpgrade[j].levelImage[k] = self:GetChild("CardCell" .. i .. "/Team/Char" .. j .. "/CharSmallCell/CharUpgrade/Img" .. k)
      end
    end
  end
  self._refrashBtn = self:GetChild("ChangeBtn")
  self._rewardBtn = self:GetChild("SoldBtn")
  self._rewardRed = self:GetChild("SoldBtn/RedDot")
  self._rewardRed:SetActive(false)
  self._refrashBtn:Subscribe_PointerClickEvent(self.OnRefrashBtnBtnClicked, self)
  self._rewardBtn:Subscribe_PointerClickEvent(self.OpenRewardDialog, self)
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._endTimeText = self:GetChild("Time/Txt2")
  self._DefenseBtn = self:GetChild("RecordBtn")
  self._DefenseBtn:Subscribe_PointerClickEvent(self.OnRecordBtnClicked, self)
  self._attackTeamBtn = self:GetChild("TeamSet/GoBtn1")
  self._attackTeamBtn:Subscribe_PointerClickEvent(self.OnAttackTeamBtnClicked, self)
  self._defenseTeamBtn = self:GetChild("TeamSet/GoBtn2")
  self._defenseTeamBtn:Subscribe_PointerClickEvent(self.OnDefenseTeamBtnClicked, self)
  self._rankImage = self:GetChild("CurrentRank")
  self._rankText = self:GetChild("CurrentRank/NumMax")
  self._rankText:SetText("")
  self._TopicList = {}
  for i = 1, 2 do
    self._TopicList[i] = {}
    self._TopicList[i].Icon = self:GetChild("Theme/Icon" .. i)
    self._TopicList[i].Icon:Subscribe_PointerClickEvent(function()
      self:OnTopicClicked(i)
    end, self)
    self._TopicList[i].Name = self:GetChild("Theme/Name" .. i)
    self._TopicList[i].Name:SetText("")
    self._TopicList[i].Name:Subscribe_PointerClickEvent(function()
      self:OnTopicClicked(i)
    end, self)
  end
  self._rankProgress = self:GetChild("Rank/ProgressBack/Progress")
  self._rankScoreCurText = self:GetChild("Rank/ProgressBack/Num/Num")
  self._rankScoreCurText:SetText("")
  self._rankScoreMaxText = self:GetChild("Rank/ProgressBack/Num/NumMax")
  self._rankScoreMaxText:SetText("")
  self._nextRankText = self:GetChild("Rank/NextRank")
  self._nextRankText:SetText("")
  self._rankBtn = self:GetChild("RankBtn")
  self._rankBtn:Subscribe_PointerClickEvent(self.OnRankBtnClicked, self)
  self._tipsBtn = self:GetChild("Tips/Ibtn")
  self._tipsBtn:Subscribe_PointerClickEvent(self.OnTipsBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.ReloadRTopFrame, Common.n_RefreshCurrency, nil)
  LuaNotificationCenter.AddObserver(self, self.OnBagDialogDestroy, Common.n_DialogWillDestroy, nil)
  LuaNotificationCenter.AddObserver(self, self.RefrashRewardRed, Common.n_SeasonPvpAward, nil)
end

function SeasonPvpMainDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function SeasonPvpMainDialog:Init()
  RedDotManager.ClearSeasonRedDot()
  LuaNotificationCenter.PostNotification(Common.n_RefreshFragmentPanelRed, nil)
  self._data = NekoData.BehaviorManager.BM_Battle:GetSeasonData()
  local awardData = {
    items = NekoData.BehaviorManager.BM_Activity:GetArenaReceiveAward()
  }
  if awardData.items and #awardData.items > 0 then
    NekoData.DataManager.DM_ItemAccountShow:AddShowDialogData({
      tag = DataCommon.ShowDialogType.ItemAccount,
      data = awardData
    })
    NekoData.DataManager.DM_Activity:ClearArenaReceiveAward()
    LuaNotificationCenter.AddObserver(self, self.OnBagDialogDestroy, Common.n_DialogWillDestroy, nil)
    return
  end
  local RankRecorder = CDreamRank:GetRecorder(self._data.stage)
  local spriteRecord = CImagePathTable:GetRecorder(RankRecorder.rankBigIcon)
  self._rankImage:SetSprite(spriteRecord.assetBundle, spriteRecord.assetName)
  self._rankText:SetText(RankRecorder.rankName)
  CS.UnityEngine.PlayerPrefs.SetInt("seasonId", self._data.seasonId)
  local MainRecorder = CDreamMain:GetRecorder(self._data.seasonId)
  local TopicList = string.split(MainRecorder.seasonTopic, ";")
  for i, v in ipairs(TopicList) do
    local Topic = tonumber(v)
    local TopicRecorder = CDreamTopic:GetRecorder(Topic)
    if TopicRecorder then
      local spriteRecord = CImagePathTable:GetRecorder(TopicRecorder.topicIcon)
      if spriteRecord then
        self._TopicList[i].Icon:SetSprite(spriteRecord.assetBundle, spriteRecord.assetName)
      end
      self._TopicList[i].Name:SetText(TextManager.GetText(TopicRecorder.topicName))
    end
  end
  self._rankProgress = self:GetChild("Rank/ProgressBack/Progress")
  self._rankScoreCurText:SetText(self._data.currentScore)
  self._rankScoreMaxText:SetText(RankRecorder.rankUp)
  local progress = self._data.currentScore / RankRecorder.rankUp
  self._rankProgress:SetFillAmount(progress)
  local NextRankRecorder = CDreamRank:GetRecorder(self._data.stage + 1)
  if NextRankRecorder then
    self._nextRankText:SetText(NextRankRecorder.rankName)
  else
    self._nextRankText:SetText(RankRecorder.rankName)
  end
  for i, lineupInfo in ipairs(self._data.enemyInfo) do
    local headPhotoRecord = HeadPhotoTable:GetRecorder(lineupInfo.enemyUserData.avatarId)
    local imageRecord
    if headPhotoRecord then
      imageRecord = CImagePathTable:GetRecorder(headPhotoRecord.photoid) or DataCommon.DefaultImageAsset
      self._photos[i]:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    else
      LogErrorFormat("SeasonPvpMainDialog", "userInfo.avatarId %s is wrong", lineupInfo.enemyUserData.avatarId)
    end
    local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(lineupInfo.enemyUserData.frameId)
    if headPhotoFrameRecord then
      imageRecord = CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) or DataCommon.DefaultImageAsset
      self._headFrames[i]:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    else
      LogErrorFormat("SeasonPvpMainDialog", "userInfo.frameId %s is wrong", lineupInfo.enemyUserData.frameId)
    end
    self._names[i]:SetText(lineupInfo.enemyUserData.userName)
    self._levels[i]:SetText(lineupInfo.enemyUserData.userLv)
    self._teamScore[i]:SetText(lineupInfo.score)
    local TeamRankRecorder = CDreamRank:GetRecorder(lineupInfo.stage)
    if TeamRankRecorder then
      self._teamRank[i]:SetText(TeamRankRecorder.rankName)
    end
    local dreamPara = CDreamPara:GetRecorder(i).value
    for m = #self._showNumbers, 2, -1 do
      local n = math.random(1, m)
      self._showNumbers[m], self._showNumbers[n] = self._showNumbers[n], self._showNumbers[m]
    end
    local hideList = {}
    for k = 1, dreamPara do
      hideList[self._showNumbers[k]] = true
    end
    self.enemyInfo[i] = {}
    self.enemyInfo[i].hideList = hideList
    for j = 1, 3 do
      local roleInfo = lineupInfo.enemyRoleList[j]
      if roleInfo then
        self._teams[i].charPanel[j]:SetActive(true)
        local tempRole = Role.Create(roleInfo.id)
        tempRole:SetLevel(roleInfo.lv)
        tempRole:SetBreakLv(roleInfo.breakLv)
        tempRole:SetRuneLevel(roleInfo.runeLevel)
        self._teams[i]._unkown[j]:SetActive(false)
        self._teams[i]._photo[j]:SetActive(false)
        self._teams[i]._frame[j]:SetActive(true)
        self._teams[i]._downRankBack[j]:SetActive(true)
        self._teams[i]._rank[j]:SetActive(false)
        self._teams[i]._job[j]:SetActive(false)
        self._teams[i]._breakLevelBackBlack[j]:SetActive(false)
        self._teams[i]._breakLevelBack[j]:SetActive(true)
        self._teams[i]._breakLevelNum[j]:SetActive(false)
        self._teams[i]._element[j]:SetActive(false)
        self._teams[i].charUpgrade[j].panel:SetActive(false)
        for k = 1, 5 do
          self._teams[i].charUpgrade[j].levelImage[k]:SetActive(false)
        end
        if hideList[j] then
          self._teams[i]._unkown[j]:SetActive(true)
          self._teams[i]._level[j]:SetText("?")
          local image = CImagePathTable:GetRecorder(10473)
          self._teams[i]._frame[j]:SetSprite(image.assetBundle, image.assetName)
          image = CImagePathTable:GetRecorder(12842)
          self._teams[i]._downRankBack[j]:SetSprite(image.assetBundle, image.assetName)
        else
          local image = tempRole:GetShapeLittleHeadImageRecord()
          self._teams[i]._photo[j]:SetSprite(image.assetBundle, image.assetName)
          self._teams[i]._photo[j]:SetActive(true)
          image = tempRole:GetSmallRarityFrameRecord()
          self._teams[i]._frame[j]:SetSprite(image.assetBundle, image.assetName)
          self._teams[i]._frame[j]:SetActive(true)
          image = tempRole:GetRarityBottomBackRecord()
          self._teams[i]._downRankBack[j]:SetSprite(image.assetBundle, image.assetName)
          self._teams[i]._downRankBack[j]:SetActive(true)
          self._teams[i]._level[j]:SetText(tempRole:GetShowLv())
          image = tempRole:GetRarityImageRecord()
          self._teams[i]._rank[j]:SetSprite(image.assetBundle, image.assetName)
          self._teams[i]._rank[j]:SetActive(true)
          image = tempRole:GetVocationImageRecord()
          self._teams[i]._job[j]:SetSprite(image.assetBundle, image.assetName)
          self._teams[i]._job[j]:SetActive(true)
          local breakLv = tempRole:GetBreakLv()
          self._teams[i]._breakLevelBackBlack[j]:SetActive(breakLv == 0)
          self._teams[i]._breakLevelBack[j]:SetActive(0 < breakLv)
          self._teams[i]._breakLevelNum[j]:SetActive(0 < breakLv)
          if 0 < breakLv then
            image = tempRole:GetCurBreakFrame1ImageRecord()
            self._teams[i]._breakLevelBack[j]:SetSprite(image.assetBundle, image.assetName)
            self._teams[i]._breakLevelBack[j]:SetActive(true)
            self._teams[i]._breakLevelNum[j]:SetText(breakLv)
            self._teams[i]._breakLevelNum[j]:SetActive(true)
          end
          image = tempRole:GetElementImageRecord()
          self._teams[i]._element[j]:SetSprite(image.assetBundle, image.assetName)
          self._teams[i]._element[j]:SetActive(true)
          local level = tempRole:GetRuneLevel()
          self._teams[i].charUpgrade[j].panel:SetActive(level ~= 0)
          for k = 1, 5 do
            self._teams[i].charUpgrade[j].levelImage[k]:SetActive(level == k)
          end
        end
      else
        self._teams[i].charPanel[j]:SetActive(false)
      end
    end
  end
  self._moneyTypeInfo = {
    {
      moneyType = DataCommon.PVPKeys
    },
    {
      moneyType = DataCommon.PVPCoin
    }
  }
  self._endTimeText:SetText(timeutils.getLeftTimeStr(self._data.leftTime))
  self:RefrashRewardRed()
end

function SeasonPvpMainDialog:RefrashRewardRed()
  if NekoData.BehaviorManager.BM_Battle:GetSeasonNotify() and NekoData.BehaviorManager.BM_Battle:GetSeasonNotify().award and NekoData.BehaviorManager.BM_Battle:GetSeasonNotify().award > 0 then
    self._rewardRed:SetActive(true)
  else
    self._rewardRed:SetActive(false)
  end
end

function SeasonPvpMainDialog:OnStartBtnClicked(index)
  local data = NekoData.BehaviorManager.BM_Battle:GetSeasonData()
  local isSetAttackTeam = false
  local isDefendTeam = false
  for k, v in pairs(data.attackTeam) do
    if 0 < v then
      isSetAttackTeam = true
      break
    end
  end
  for k, v in pairs(data.defendTeam) do
    if 0 < v then
      isDefendTeam = true
      break
    end
  end
  if not isSetAttackTeam or not isDefendTeam then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100508)
    return
  end
  if 0 >= data.leftAttackAccessPoint then
    NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(151, nil, function()
      local fantasyProtocol = LuaNetManager.CreateProtocol("protocol.battle.cfantasyconflictbattlestart")
      if fantasyProtocol then
        fantasyProtocol.enemyID = index
        fantasyProtocol:Send()
      end
    end)
    return
  end
  local fantasyProtocol = LuaNetManager.CreateProtocol("protocol.battle.cfantasyconflictbattlestart")
  if fantasyProtocol then
    fantasyProtocol.enemyID = index
    fantasyProtocol:Send()
  end
end

function SeasonPvpMainDialog:OnBagDialogDestroy(notification)
  if notification.userInfo._dialogName == "bag.itemaccountdialog" then
    self:Init(self._data)
    LuaNotificationCenter.RemoveObserver(self, Common.n_DialogWillDestroy)
  end
end

function SeasonPvpMainDialog:OnCellClicked(teamIndex, roleIndex)
  if self.enemyInfo[teamIndex].hideList[roleIndex] then
    return
  end
  local roleList = {}
  for i, v in pairs(self._data.enemyInfo[teamIndex].enemyRoleList) do
    if not self.enemyInfo[teamIndex].hideList[i] then
      table.insert(roleList, v)
    end
  end
  local newList = {}
  local idx = 0
  local curIdx = 0
  for index, v in ipairs(roleList) do
    idx = idx + 1
    table.insert(newList, v)
    if v.id == self._data.enemyInfo[teamIndex].enemyRoleList[roleIndex].id then
      curIdx = idx
    end
  end
  local dlg = DialogManager.CreateSingletonDialog("mainline.bossrush.checkotherroleinfodialog")
  if dlg then
    dlg:Init({index = curIdx, roleList = roleList}, dlg.ShowType.PVP)
  end
end

function SeasonPvpMainDialog:OnRefrashBtnBtnClicked()
  local csend = LuaNetManager.CreateProtocol("protocol.battle.cfantasyconflictresetenemy")
  if csend then
    csend:Send()
  end
end

function SeasonPvpMainDialog:OnRecordBtnClicked()
  local csend = LuaNetManager.CreateProtocol("protocol.battle.cfantasyconflictdefendrecord")
  csend:Send()
end

function SeasonPvpMainDialog:OnAttackTeamBtnClicked()
  local dialog = DialogManager.CreateSingletonDialog("mainline.seasonpvp.seasonteameditdialog")
  if dialog then
    dialog:SetData(1)
  end
end

function SeasonPvpMainDialog:OnDefenseTeamBtnClicked()
  local dialog = DialogManager.CreateSingletonDialog("mainline.seasonpvp.seasonteameditdialog")
  if dialog then
    dialog:SetData(0)
  end
end

function SeasonPvpMainDialog:OpenRewardDialog()
  local csend = LuaNetManager.CreateProtocol("protocol.battle.cfantasyconflictshowrewardprogress")
  csend:Send()
end

function SeasonPvpMainDialog:NumberOfCell(frame)
  if frame == self._topGroupFrame then
    return #self._moneyTypeInfo
  end
end

function SeasonPvpMainDialog:CellAtIndex(frame, index)
  if frame == self._topGroupFrame then
    return "shop.shoptopgroupcell"
  end
end

function SeasonPvpMainDialog:DataAtIndex(frame, index)
  if frame == self._topGroupFrame then
    return self._moneyTypeInfo[index]
  end
end

function SeasonPvpMainDialog:OnBackBtnClicked()
  self:Destroy()
end

function SeasonPvpMainDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

function SeasonPvpMainDialog:ReloadRTopFrame()
end

function SeasonPvpMainDialog:OnRankBtnClicked()
  local csend = LuaNetManager.CreateProtocol("protocol.ranking.carenaranking")
  csend.index = 0
  csend:Send()
end

function SeasonPvpMainDialog:OnTopicClicked(index)
  local MainRecorder = CDreamMain:GetRecorder(self._data.seasonId)
  local TopicList = string.split(MainRecorder.seasonTopic, ";")
  local Topic = tonumber(TopicList[index])
  local TopicRecorder = CDreamTopic:GetRecorder(Topic)
  local dialog = DialogManager.CreateSingletonDialog("mainline.seasonpvp.seasonpvpthemetips")
  if dialog then
    dialog:Init(TopicRecorder)
  end
end

function SeasonPvpMainDialog:OnTipsBtnClicked()
  DialogManager.CreateSingletonDialog("mainline.seasonpvp.seasonpvptipsdialog"):SetData(2256)
end

return SeasonPvpMainDialog
