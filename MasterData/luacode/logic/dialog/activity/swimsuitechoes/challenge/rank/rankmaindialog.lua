local TableFrame = require("framework.ui.frame.table.tableframe")
local TabFrame = require("framework.ui.frame.tab.tabframe")
local CSRChallengeRank = BeanManager.GetTableByName("activity.csrchallengerank")
local RankMainDialog = class("RankMainDialog", Dialog)
RankMainDialog.AssetBundleName = "ui/layouts.activitysummer2"
RankMainDialog.AssetName = "ActivitySummer2XiGuaRank"

function RankMainDialog:Ctor(...)
  RankMainDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._tabData = {}
  self._timers = {}
  self._tags = {}
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SummerActivityEchoesManagerID)
end

function RankMainDialog:OnCreate()
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._bossPanel = self:GetChild("BossFrame")
  self._rankPanel = self:GetChild("Frame")
  self._title = self:GetChild("Title")
  self._title:SetText(TextManager.GetText(1901403))
  self._bossFrame = TableFrame.Create(self._bossPanel, self, true, true, true)
  self._rankTabFrame = TabFrame.Create(self._rankPanel, self)
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
end

function RankMainDialog:OnDestroy()
  for k, v in pairs(self._timers) do
    GameTimer.RemoveTask(v)
    self._timers[k] = nil
  end
  self._bossFrame:Destroy()
  self._rankTabFrame:Destroy()
  DialogManager.DestroySingletonDialog("activity.swimsuitechoes.challenge.rank.rankteaminfodialog")
end

local function DoReq(self)
  local protocol = LuaNetManager.CreateProtocol("protocol.ranking.csummerchallengeranking")
  protocol:Send()
end

function RankMainDialog:OnRefreshRankList(protocol)
  self._tabData[1] = {
    personalRankData = protocol.personRank,
    allRankData = protocol.ranking
  }
  if self._timers[1] then
    GameTimer.RemoveTask(self._timers[1])
    self._timers[1] = nil
  end
  self._timers[1] = GameTimer.AddTask(120, -1, function(id)
    self._tags[id] = nil
    if id == self._tabType then
      DoReq(self, id)
    end
  end, 1)
  self._tags[1] = self._timers[1]
  self._tabType = 1
  local tabCell = self._rankTabFrame:ToPage(self._tabType)
  tabCell:RefreshTabCell(self._tabData[1])
  self._bossFrame:FireEvent("ChooseBossRush", self._tabType)
end

function RankMainDialog:Init()
  self._bossRecordList = {}
  local allIDs = CSRChallengeRank:GetAllIds()
  local recorder
  for i, v in ipairs(allIDs) do
    recorder = CSRChallengeRank:GetRecorder(v)
    table.insert(self._bossRecordList, recorder)
  end
  self:SetType(1)
  self._bossFrame:ReloadAllCell()
  self._bossFrame:MoveToTop()
end

local function GetBossRecord(self, id)
  for i, v in ipairs(self._bossRecordList) do
    if v.id == id then
      return v
    end
  end
end

function RankMainDialog:SetType(value)
  DoReq(self, value)
end

function RankMainDialog:NumberOfCell(frame, index)
  return #self._bossRecordList
end

function RankMainDialog:CellAtIndex(frame, index)
  if frame == self._bossFrame then
    return "activity.swimsuitechoes.challenge.rank.rankbosscell"
  elseif frame == self._rankTabFrame then
    return "activity.swimsuitechoes.challenge.rank.ranktabcell"
  end
end

function RankMainDialog:DataAtIndex(frame, index)
  return self._bossRecordList[index]
end

function RankMainDialog:OnBackBtnClicked()
  self:Destroy()
end

function RankMainDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

return RankMainDialog
