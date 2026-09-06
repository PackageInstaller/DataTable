local TableFrame = require("framework.ui.frame.table.tableframe")
local TabFrame = require("framework.ui.frame.tab.tabframe")
local TypeEnum = {
  [DataCommon.Activities.StarMirage] = {
    bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.StarMirageManagerID),
    type = DataCommon.StarMirage.Type,
    tabTypeEnum = {
      [DataCommon.StarMirage.Type.Easy] = 10007,
      [DataCommon.StarMirage.Type.Hard] = 10015
    },
    difficultyColorStrType = "StarMirage"
  },
  [DataCommon.Activities.Anniversary] = {
    bm = NekoData.BehaviorManager.BM_Anniversary,
    type = DataCommon.Anniversary.Type,
    tabTypeEnum = {
      [DataCommon.Anniversary.Type.Easy] = 40001417,
      [DataCommon.Anniversary.Type.Hard] = 40001418
    },
    difficultyColorStrType = "Anniversary",
    titleString = NekoData.BehaviorManager.BM_Message:GetString(2001),
    deadlineString = NekoData.BehaviorManager.BM_Message:GetString(2074)
  },
  [DataCommon.Activities.StarMirageCopy] = {
    bm = NekoData.BehaviorManager.BM_StarMirageCopy,
    type = DataCommon.StarMirage1[DataCommon.Activities.StarMirageCopy].Type,
    tabTypeEnum = {
      [DataCommon.StarMirage1[DataCommon.Activities.StarMirageCopy].Type.Easy] = 10047
    },
    difficultyColorStrType = "StarMirage",
    titleString = NekoData.BehaviorManager.BM_Message:GetString(2001),
    deadlineString = NekoData.BehaviorManager.BM_Message:GetString(2121)
  }
}
local RankMainDialog = class("RankMainDialog", Dialog)
RankMainDialog.AssetBundleName = "ui/layouts.activitystar"
RankMainDialog.AssetName = "ActivityStarRank"

function RankMainDialog:Ctor(...)
  RankMainDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._tabData = {}
  self._timers = {}
  self._tags = {}
  self._activityId = nil
end

function RankMainDialog:OnCreate()
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._title = self:GetChild("Title")
  self._deadline = self:GetChild("Level2Tips")
  self._bossPanel = self:GetChild("BossFrame")
  self._rankPanel = self:GetChild("Frame")
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
  DialogManager.DestroySingletonDialog("activity.starmirage.rankteaminfodialog")
end

local function DoReq(self, reqType)
  self._reqType = reqType
  local protocol = LuaNetManager.CreateProtocol("protocol.ranking.cactivitychallengeranking")
  protocol.activity = self._activityId
  protocol.id = self._reqType
  protocol:Send()
end

function RankMainDialog:OnRefreshRankList(protocol)
  if protocol.activity ~= self._activityId then
    LogErrorFormat("RankMainDialog", "protocol_activity(: %s) and dialog_activityId(: %s) do not match!", protocol.activity, self._activityId)
    return
  end
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
  self._typeData = TypeEnum[self._activityId]
  if not self._typeData then
    LogErrorFormat("RankMainDialog", "Not Find data by activityId: %s.", self._activityId)
    return
  end
  if self._typeData.titleString then
    self._title:SetText(self._typeData.titleString)
  end
  if self._typeData.deadlineString then
    self._deadline:SetText(self._typeData.deadlineString)
  end
  self._bossRecordList = self._typeData.bm:GetRankBossInfo()
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

function RankMainDialog:SetType(activityId, value)
  if not self._activityId or activityId and self._activityId ~= activityId then
    self._activityId = activityId
    self:Init()
  end
  if not self._activityId then
    LogError("not init.")
  end
  local type = self._typeData.tabTypeEnum[value]
  if not GetBossRecord(self, type) then
    type = self._typeData.tabTypeEnum[self._typeData.type.Easy]
  end
  if self._tabType ~= type then
    local data = self._tabData[type]
    if not data or not self._tags[type] then
      DoReq(self, type)
    else
      self._tabType = type
      local tabCell = self._rankTabFrame:ToPage(self._tabType)
      tabCell:RefreshTabCell(data)
      self._bossFrame:FireEvent("ChooseBossRush", self._tabType)
    end
  end
end

function RankMainDialog:NumberOfCell(frame, index)
  return #self._bossRecordList
end

function RankMainDialog:CellAtIndex(frame, index)
  if frame == self._bossFrame then
    return "activity.starmirage.rankbosscell"
  elseif frame == self._rankTabFrame then
    return "activity.starmirage.ranktabcell"
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
