-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/bossrush/bossrushcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BossChallenge = (LuaNetManager.GetBeanDef)("protocol.ranking.bosschallenge")
local BossRushPanelCell = class("BossRushPanelCell", Dialog)
BossRushPanelCell.AssetBundleName = "ui/layouts.mainline"
BossRushPanelCell.AssetName = "BossRushPanelCell"
local TableFrame = require("framework.ui.frame.table.tableframe")
local cimagepath = (BeanManager.GetTableByName)("ui.cimagepath")
BossRushPanelCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BossRushPanelCell
  ((BossRushPanelCell.super).Ctor)(self, ...)
  self._groupName = "Cell"
  self._stageData = {}
end

BossRushPanelCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, TableFrame
  self._img = self:GetChild("Photo")
  self._name = self:GetChild("Name")
  self._difficultyTxt = self:GetChild("Difficulty/Txt2")
  self._time = {label = self:GetChild("Txt2"), value = self:GetChild("Time"), difficultyTxt = self:GetChild("Time/DifficultyTxt")}
  ;
  ((self._time).label):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1419))
  self._rank = {label = self:GetChild("Txt3"), value = self:GetChild("Rank")}
  self._absent = self:GetChild("TxtNoRecord")
  self._noRank = self:GetChild("Txt3NoRank")
  ;
  (self._absent):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1420))
  ;
  (self._noRank):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1421))
  self._rewardPanel = self:GetChild("Reward")
  self._redIcon = self:GetChild("Reward/GetBtn/RedDot")
  self._total = self:GetChild("Reward/Total")
  self._num = self:GetChild("Reward/Num")
  self._stageFrame = self:GetChild("Reward/Frame")
  self._helper = (TableFrame.Create)(self._stageFrame, self, false, false)
  ;
  (self:GetChild("StartBtn")):Subscribe_PointerClickEvent(self.OnStartBtnClick, self)
  ;
  (self:GetChild("Reward")):Subscribe_PointerClickEvent(self.OnRewardPanelClick, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshRedIcon, Common.n_RefreshBossPanelRed, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshStageAward, Common.n_ReceiveBossPanelStageAward, nil)
end

BossRushPanelCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._helper):Destroy()
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

BossRushPanelCell.RefreshCell = function(self)
  -- function num : 0_3 , upvalues : cimagepath, _ENV, BossChallenge
  local image = cimagepath:GetRecorder(((self._cellData).cfg).image)
  ;
  (self._img):SetSprite(image.assetBundle, image.assetName)
  ;
  (self._name):SetText((TextManager.GetText)(((self._cellData).cfg).nameTextID))
  ;
  (self._difficultyTxt):SetText(((NekoData.BehaviorManager).BM_Game):GetBossRushDifficultyColorStr(((self._cellData).info).times))
  local totalStage = (table.nums)(((self._cellData).cfg).stageid)
  ;
  (self._total):SetText(totalStage)
  ;
  (self._num):SetText(((self._cellData).info).awardTotalNum)
  if (table.nums)(((self._cellData).info).awardGot) < ((self._cellData).info).awardTotalNum then
    (self._redIcon):SetActive(true)
  else
    ;
    (self._redIcon):SetActive(false)
  end
  self._stageData = {}
  for i = 1, totalStage do
    local data = {}
    data.pass = i <= ((self._cellData).info).awardTotalNum
    ;
    (table.insert)(self._stageData, data)
  end
  ;
  (self._helper):ReloadAllCell()
  if ((self._cellData).info).status == 0 then
    ((self._time).label):SetActive(false)
    ;
    ((self._time).value):SetActive(false)
    ;
    (self._absent):SetActive(true)
    ;
    ((self._rank).label):SetActive(false)
    ;
    ((self._rank).value):SetActive(false)
    ;
    (self._noRank):SetActive(true)
  else
    ((self._time).label):SetActive(true)
    ;
    ((self._time).value):SetActive(true)
    ;
    (self._absent):SetActive(false)
    if ((self._cellData).info).rank == BossChallenge.NOT_ON_LIST then
      ((self._rank).label):SetActive(false)
      ;
      ((self._rank).value):SetActive(false)
      ;
      (self._noRank):SetActive(true)
    else
      ((self._rank).label):SetActive(true)
      ;
      ((self._rank).value):SetActive(true)
      ;
      (self._noRank):SetActive(false)
      ;
      ((self._rank).value):SetText(((self._cellData).info).rank)
    end
    local str = (((BeanManager.GetTableByName)("message.cstringres")):GetRecorder(1107)).msgTextID
    str = (TextManager.GetText)(str)
    local num = ((self._cellData).info).passTime / 1000
    local ret = ((NekoData.BehaviorManager).BM_Game):GetPreciseDecimal(num, 1)
    str = (string.gsub)(str, "%$parameter1%$", ret)
    ;
    ((self._time).value):SetText(str)
    ;
    ((self._time).difficultyTxt):SetText(((NekoData.BehaviorManager).BM_Game):GetBossRushDifficultyColorStr(((self._cellData).info).victoryTimes))
  end
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

BossRushPanelCell.RefreshRedIcon = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local redInfo = ((NekoData.BehaviorManager).BM_Game):GetBossPanelRedInfo()
  if redInfo and redInfo[(self._cellData).id] then
    (self._redIcon):SetActive(true)
  else
    ;
    (self._redIcon):SetActive(false)
  end
end

BossRushPanelCell.RefreshStageAward = function(self, notification)
  -- function num : 0_5 , upvalues : _ENV
  if (notification.userInfo).id == ((self._cellData).cfg).id then
    (table.insert)(((self._cellData).info).awardGot, (notification.userInfo).stageId)
  end
end

BossRushPanelCell.NumberOfCell = function(self, helper)
  -- function num : 0_6
  return #self._stageData
end

BossRushPanelCell.CellAtIndex = function(self, helper, index)
  -- function num : 0_7
  return "mainline.bossrush.bossrushpanelstagecell"
end

BossRushPanelCell.DataAtIndex = function(self, helper, index)
  -- function num : 0_8
  return (self._stageData)[index]
end

BossRushPanelCell.OnRewardPanelClick = function(self)
  -- function num : 0_9 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("mainline.bossrush.bossstageawardpaneldialog")):Refresh(((self._cellData).cfg).stageid, ((self._cellData).info).awardGot, ((self._cellData).info).awardTotalNum, ((self._cellData).cfg).id, ((self._cellData).info).times, ((self._cellData).cfg).name)
end

BossRushPanelCell.OnStartBtnClick = function(self)
  -- function num : 0_10
  (self._delegate):OnCellClick((self._cellData).id)
end

return BossRushPanelCell

