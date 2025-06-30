-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/christmas/rankmaindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local TabFrame = require("framework.ui.frame.tab.tabframe")
local CChrisBossRush = (BeanManager.GetTableByName)("dungeonselect.cchrisbossrush")
local RankMainDialog = class("RankMainDialog", Dialog)
RankMainDialog.AssetBundleName = "ui/layouts.activitystar"
RankMainDialog.AssetName = "ActivityStarRank"
RankMainDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RankMainDialog, _ENV
  ((RankMainDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._tabData = {}
  self._timers = {}
  self._tags = {}
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.StarMirageManagerID)
end

RankMainDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, TableFrame, TabFrame
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._bossPanel = self:GetChild("BossFrame")
  self._rankPanel = self:GetChild("Frame")
  self._title = self:GetChild("Title")
  self._level2Tips = self:GetChild("Level2Tips")
  ;
  (self._title):SetText((TextManager.GetText)(1901403))
  ;
  (self._level2Tips):SetText((TextManager.GetText)(1901398))
  self._bossFrame = (TableFrame.Create)(self._bossPanel, self, true, true, true)
  self._rankTabFrame = (TabFrame.Create)(self._rankPanel, self)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self:Init()
end

RankMainDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  for k,v in pairs(self._timers) do
    (GameTimer.RemoveTask)(v)
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (self._timers)[k] = nil
  end
  ;
  (self._bossFrame):Destroy()
  ;
  (self._rankTabFrame):Destroy()
  ;
  (DialogManager.DestroySingletonDialog)("activity.starmirage.rankteaminfodialog")
  local dialog = (DialogManager.GetDialog)("activity.christmas.christmasmaindialog")
  if dialog then
    dialog:SetActive(true)
  end
  dialog = (DialogManager.GetDialog)("activity.christmas.christmasmain2dialog")
  if dialog then
    dialog:SetActive(true)
  end
end

local DoReq = function(self, reqType)
  -- function num : 0_3 , upvalues : _ENV
  self._reqType = reqType
  local protocol = (LuaNetManager.CreateProtocol)("protocol.ranking.cactivitychallengeranking")
  protocol.activity = (DataCommon.Activities).Christmas
  protocol.id = self._reqType
  protocol:Send()
end

RankMainDialog.OnRefreshRankList = function(self, protocol)
  -- function num : 0_4 , upvalues : _ENV, DoReq
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  (self._tabData)[protocol.id] = {personalRankData = protocol.personRank, allRankData = protocol.ranking}
  if (self._timers)[protocol.id] then
    (GameTimer.RemoveTask)((self._timers)[protocol.id])
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self._timers)[protocol.id] = nil
  end
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._timers)[protocol.id] = (GameTimer.AddTask)(120, -1, function(id)
    -- function num : 0_4_0 , upvalues : self, DoReq
    -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

    (self._tags)[id] = nil
    if id == self._tabType then
      DoReq(self, id)
    end
  end
, protocol.id)
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._tags)[protocol.id] = (self._timers)[protocol.id]
  if self._reqType == protocol.id then
    self._reqType = nil
    self._tabType = protocol.id
    local tabCell = (self._rankTabFrame):ToPage(self._tabType)
    tabCell:RefreshTabCell((self._tabData)[protocol.id])
    ;
    (self._bossFrame):FireEvent("ChooseBossRush", self._tabType)
  else
    do
      tabCell = (self._rankTabFrame):GetCellAtIndex(protocol.id)
      tabCell:RefreshTabCell((self._tabData)[protocol.id], true)
    end
  end
end

RankMainDialog.Init = function(self)
  -- function num : 0_5 , upvalues : CChrisBossRush, _ENV
  self._bossRecordList = {}
  ;
  (CChrisBossRush:GetAllIds())
  local allIDs = nil
  local recorder = nil
  for i,v in ipairs(allIDs) do
    recorder = CChrisBossRush:GetRecorder(v)
    ;
    (table.insert)(self._bossRecordList, recorder)
  end
  ;
  (self._bossFrame):ReloadAllCell()
  ;
  (self._bossFrame):MoveToTop()
end

local GetBossRecord = function(self, id)
  -- function num : 0_6 , upvalues : _ENV
  for i,v in ipairs(self._bossRecordList) do
    if v.id == id then
      return v
    end
  end
end

RankMainDialog.SetType = function(self, value)
  -- function num : 0_7 , upvalues : DoReq
  DoReq(self, value)
end

RankMainDialog.NumberOfCell = function(self, frame, index)
  -- function num : 0_8
  return #self._bossRecordList
end

RankMainDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_9
  if frame == self._bossFrame then
    return "activity.christmas.rankbosscell"
  else
    if frame == self._rankTabFrame then
      return "activity.christmas.ranktabcell"
    end
  end
end

RankMainDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_10
  return (self._bossRecordList)[index]
end

RankMainDialog.OnBackBtnClicked = function(self)
  -- function num : 0_11
  self:Destroy()
end

RankMainDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_12 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

return RankMainDialog

