-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/starmirage/rankmaindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local TabFrame = require("framework.ui.frame.tab.tabframe")
local TypeEnum = {
[(DataCommon.Activities).StarMirage] = {bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.StarMirageManagerID), type = (DataCommon.StarMirage).Type, 
tabTypeEnum = {[((DataCommon.StarMirage).Type).Easy] = 10007, [((DataCommon.StarMirage).Type).Hard] = 10015}
, difficultyColorStrType = "StarMirage"}
, 
[(DataCommon.Activities).Anniversary] = {bm = (NekoData.BehaviorManager).BM_Anniversary, type = (DataCommon.Anniversary).Type, 
tabTypeEnum = {[((DataCommon.Anniversary).Type).Easy] = 40001417, [((DataCommon.Anniversary).Type).Hard] = 40001418}
, difficultyColorStrType = "Anniversary", titleString = ((NekoData.BehaviorManager).BM_Message):GetString(2001), deadlineString = ((NekoData.BehaviorManager).BM_Message):GetString(2074)}
, 
[(DataCommon.Activities).StarMirageCopy] = {bm = (NekoData.BehaviorManager).BM_StarMirageCopy, type = ((DataCommon.StarMirage1)[(DataCommon.Activities).StarMirageCopy]).Type, 
tabTypeEnum = {[(((DataCommon.StarMirage1)[(DataCommon.Activities).StarMirageCopy]).Type).Easy] = 10047}
, difficultyColorStrType = "StarMirage", titleString = ((NekoData.BehaviorManager).BM_Message):GetString(2001), deadlineString = ((NekoData.BehaviorManager).BM_Message):GetString(2121)}
}
local RankMainDialog = class("RankMainDialog", Dialog)
RankMainDialog.AssetBundleName = "ui/layouts.activitystar"
RankMainDialog.AssetName = "ActivityStarRank"
RankMainDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RankMainDialog
  ((RankMainDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._tabData = {}
  self._timers = {}
  self._tags = {}
  self._activityId = nil
end

RankMainDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, TabFrame
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._title = self:GetChild("Title")
  self._deadline = self:GetChild("Level2Tips")
  self._bossPanel = self:GetChild("BossFrame")
  self._rankPanel = self:GetChild("Frame")
  self._bossFrame = (TableFrame.Create)(self._bossPanel, self, true, true, true)
  self._rankTabFrame = (TabFrame.Create)(self._rankPanel, self)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
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
end

local DoReq = function(self, reqType)
  -- function num : 0_3 , upvalues : _ENV
  self._reqType = reqType
  local protocol = (LuaNetManager.CreateProtocol)("protocol.ranking.cactivitychallengeranking")
  protocol.activity = self._activityId
  protocol.id = self._reqType
  protocol:Send()
end

RankMainDialog.OnRefreshRankList = function(self, protocol)
  -- function num : 0_4 , upvalues : _ENV, DoReq
  if protocol.activity ~= self._activityId then
    LogErrorFormat("RankMainDialog", "protocol_activity(: %s) and dialog_activityId(: %s) do not match!", protocol.activity, self._activityId)
    return 
  end
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._tabData)[protocol.id] = {personalRankData = protocol.personRank, allRankData = protocol.ranking}
  if (self._timers)[protocol.id] then
    (GameTimer.RemoveTask)((self._timers)[protocol.id])
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self._timers)[protocol.id] = nil
  end
  -- DECOMPILER ERROR at PC42: Confused about usage of register: R2 in 'UnsetPending'

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
  -- DECOMPILER ERROR at PC48: Confused about usage of register: R2 in 'UnsetPending'

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
  -- function num : 0_5 , upvalues : TypeEnum, _ENV
  self._typeData = TypeEnum[self._activityId]
  if not self._typeData then
    LogErrorFormat("RankMainDialog", "Not Find data by activityId: %s.", self._activityId)
    return 
  end
  if (self._typeData).titleString then
    (self._title):SetText((self._typeData).titleString)
  end
  if (self._typeData).deadlineString then
    (self._deadline):SetText((self._typeData).deadlineString)
  end
  self._bossRecordList = ((self._typeData).bm):GetRankBossInfo()
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

RankMainDialog.SetType = function(self, activityId, value)
  -- function num : 0_7 , upvalues : _ENV, GetBossRecord, DoReq
  if not self._activityId or activityId and self._activityId ~= activityId then
    self._activityId = activityId
    self:Init()
  end
  if not self._activityId then
    LogError("not init.")
  end
  local type = ((self._typeData).tabTypeEnum)[value]
  if not GetBossRecord(self, type) then
    type = ((self._typeData).tabTypeEnum)[((self._typeData).type).Easy]
  end
  if self._tabType ~= type then
    local data = (self._tabData)[type]
    if not data or not (self._tags)[type] then
      DoReq(self, type)
    else
      self._tabType = type
      local tabCell = (self._rankTabFrame):ToPage(self._tabType)
      tabCell:RefreshTabCell(data)
      ;
      (self._bossFrame):FireEvent("ChooseBossRush", self._tabType)
    end
  end
end

RankMainDialog.NumberOfCell = function(self, frame, index)
  -- function num : 0_8
  return #self._bossRecordList
end

RankMainDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_9
  if frame == self._bossFrame then
    return "activity.starmirage.rankbosscell"
  else
    if frame == self._rankTabFrame then
      return "activity.starmirage.ranktabcell"
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

