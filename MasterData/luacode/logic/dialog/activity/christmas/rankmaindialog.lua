local TableFrame = require("framework.ui.frame.table.tableframe")
local TabFrame = require("framework.ui.frame.tab.tabframe")
local CChrisBossRush = BeanManager.GetTableByName("dungeonselect.cchrisbossrush")
local RankMainDialog = class("RankMainDialog", Dialog)
RankMainDialog.AssetBundleName = "ui/layouts.activitystar"
RankMainDialog.AssetName = "ActivityStarRank"

function RankMainDialog:Ctor(...)
  RankMainDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._tabData = {}
  self._timers = {}
  self._tags = {}
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.StarMirageManagerID)
end

function RankMainDialog:OnCreate()
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._bossPanel = self:GetChild("BossFrame")
  self._rankPanel = self:GetChild("Frame")
  self._title = self:GetChild("Title")
  self._level2Tips = self:GetChild("Level2Tips")
  self._title:SetText(TextManager.GetText(1901403))
  self._level2Tips:SetText(TextManager.GetText(1901398))
  self._bossFrame = TableFrame.Create(self._bossPanel, self, true, true, true)
  self._rankTabFrame = TabFrame.Create(self._rankPanel, self)
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self:Init()
end

function RankMainDialog:OnDestroy()
  for k, v in pairs(self._timers) do
    GameTimer.RemoveTask(v)
    self._timers[k] = nil
  end
  self._bossFrame:Destroy()
  self._rankTabFrame:Destroy()
  DialogManager.DestroySingletonDialog("activity.starmirage.rankteaminfodialog")
  local dialog = DialogManager.GetDialog("activity.christmas.christmasmaindialog")
  if dialog then
    dialog:SetActive(true)
  end
  dialog = DialogManager.GetDialog("activity.christmas.christmasmain2dialog")
  if dialog then
    dialog:SetActive(true)
  end
end

local function DoReq(self, reqType)
  self._reqType = reqType
  local protocol = LuaNetManager.CreateProtocol("protocol.ranking.cactivitychallengeranking")
  protocol.activity = DataCommon.Activities.Christmas
  protocol.id = self._reqType
  protocol:Send()
end

function RankMainDialog:OnRefreshRankList(protocol)
  self._tabData[protocol.id] = {
    personalRankData = protocol.personRank,
    allRankData = protocol.ranking
  }
  if self._timers[protocol.id] then
    GameTimer.RemoveTask(self._timers[protocol.id])
    self._timers[protocol.id] = nil
  end
  self._timers[protocol.id] = GameTimer.AddTask(120, -1, function(id)
    self._tags[id] = nil
    if id == self._tabType then
      DoReq(self, id)
    end
  end, protocol.id)
  self._tags[protocol.id] = self._timers[protocol.id]
  if self._reqType == protocol.id then
    self._reqType = nil
    self._tabType = protocol.id
    local tabCell = self._rankTabFrame:ToPage(self._tabType)
    tabCell:RefreshTabCell(self._tabData[protocol.id])
    self._bossFrame:FireEvent("ChooseBossRush", self._tabType)
  else
    tabCell = self._rankTabFrame:GetCellAtIndex(protocol.id)
    tabCell:RefreshTabCell(self._tabData[protocol.id], true)
  end
end

function RankMainDialog:Init()
  self._bossRecordList = {}
  local allIDs = CChrisBossRush:GetAllIds()
  local recorder
  for i, v in ipairs(allIDs) do
    recorder = CChrisBossRush:GetRecorder(v)
    table.insert(self._bossRecordList, recorder)
  end
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
    return "activity.christmas.rankbosscell"
  elseif frame == self._rankTabFrame then
    return "activity.christmas.ranktabcell"
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
