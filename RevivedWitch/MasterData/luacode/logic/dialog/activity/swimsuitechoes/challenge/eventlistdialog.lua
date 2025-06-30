-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/swimsuitechoes/challenge/eventlistdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Role = require("logic.manager.experimental.types.role")
local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local EventListDialog = class("EventListDialog", Dialog)
EventListDialog.AssetBundleName = "ui/layouts.activitysummer2"
EventListDialog.AssetName = "ActivitySummer2FullscreenMain"
EventListDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : EventListDialog, _ENV
  ((EventListDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SummerActivityEchoesManagerID)
end

EventListDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, TableFrame
  (UIBackManager.SetUIBackShow)(true)
  ;
  (UIBackManager.SetUIModalBackColor)(6)
  ;
  (self:GetChild("Title")):SetActive(false)
  ;
  (self:GetChild("ConfirmBtn/IllustrateText")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2167))
  ;
  (self:GetChild("ConfirmBtn/_Text")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2168))
  self._panel = self:GetChild("frame")
  self._frame = (TableFrame.Create)(self._panel, self, false, false, false, false)
  self._closeBtn = self:GetChild("BackBtn")
  ;
  (self._closeBtn):SetActive(false)
  ;
  (self:GetChild("MenuBtn")):SetActive(false)
  self._confirmBtn = self:GetChild("ConfirmBtn")
  ;
  (self._confirmBtn):SetActive(true)
  ;
  (self._confirmBtn):SetInteractable(false)
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.SendSelectEvent, self)
  self:Init()
end

EventListDialog.Init = function(self)
  -- function num : 0_2 , upvalues : _ENV
  GlobalGameFSM:SetBoolean("selectSummerEchoesEvent", true)
  local eventListData = (self._bm):GetEventListData()
  self._copyID = eventListData.curEvent
  self._teamId = ((NekoData.BehaviorManager).BM_Team):GetSRChallengeTeamId()
  self._data = eventListData.eventId
  ;
  (self._frame):ReloadAllCell()
  local helfFrame = (self._frame):GetTotalLength() / 2
  local anchor, offset = (self._panel):GetWidth()
  local midFrameTarget = offset / 2 - helfFrame
  ;
  (self._frame):SetMargin(midFrameTarget, 0)
  ;
  (self._frame):ReloadAllCell()
end

EventListDialog.OnDestroy = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (UIBackManager.SetUIBackShow)(false)
  if self._frame then
    (self._frame):Destroy()
  end
end

EventListDialog.OnBackBtnClicked = function(self)
  -- function num : 0_4
  self:Destroy()
end

EventListDialog.NumberOfCell = function(self, frame)
  -- function num : 0_5
  return #self._data
end

EventListDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_6
  return "activity.swimsuitechoes.challenge.eventlistcell"
end

EventListDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  return (self._data)[index]
end

EventListDialog.OnSelectEvent = function(self, id)
  -- function num : 0_8
  (self._confirmBtn):SetInteractable(true)
  self._selectId = id
  ;
  (self._frame):FireEvent("Select", id)
end

EventListDialog.SendSelectEvent = function(self)
  -- function num : 0_9 , upvalues : _ENV
  local csend = (LuaNetManager.CreateProtocol)("protocol.activity.cchoosebattleevent")
  csend.eventId = self._selectId
  csend:Send()
end

EventListDialog.GoBattle = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local csend = (LuaNetManager.CreateProtocol)("protocol.activity.csummerechoevent")
  csend.constructionID = 21
  csend.eventID = self._copyID
  csend.lineupID = self._teamId
  csend:Send()
  GlobalGameFSM:SetBoolean("selectSummerEchoesEvent", false)
  ;
  (((NekoData.DataManager).DM_Activity):GetManager(DataCommon.SummerActivityEchoesManagerID)):OnSBattleEvent(nil)
  self:Destroy()
end

return EventListDialog

