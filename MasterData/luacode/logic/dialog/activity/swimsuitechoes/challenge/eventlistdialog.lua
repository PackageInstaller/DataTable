local Role = require("logic.manager.experimental.types.role")
local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local EventListDialog = class("EventListDialog", Dialog)
EventListDialog.AssetBundleName = "ui/layouts.activitysummer2"
EventListDialog.AssetName = "ActivitySummer2FullscreenMain"

function EventListDialog:Ctor(...)
  EventListDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SummerActivityEchoesManagerID)
end

function EventListDialog:OnCreate()
  UIBackManager.SetUIBackShow(true)
  UIBackManager.SetUIModalBackColor(6)
  self:GetChild("Title"):SetActive(false)
  self:GetChild("ConfirmBtn/IllustrateText"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2167))
  self:GetChild("ConfirmBtn/_Text"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2168))
  self._panel = self:GetChild("frame")
  self._frame = TableFrame.Create(self._panel, self, false, false, false, false)
  self._closeBtn = self:GetChild("BackBtn")
  self._closeBtn:SetActive(false)
  self:GetChild("MenuBtn"):SetActive(false)
  self._confirmBtn = self:GetChild("ConfirmBtn")
  self._confirmBtn:SetActive(true)
  self._confirmBtn:SetInteractable(false)
  self._confirmBtn:Subscribe_PointerClickEvent(self.SendSelectEvent, self)
  self:Init()
end

function EventListDialog:Init()
  GlobalGameFSM:SetBoolean("selectSummerEchoesEvent", true)
  local eventListData = self._bm:GetEventListData()
  self._copyID = eventListData.curEvent
  self._teamId = NekoData.BehaviorManager.BM_Team:GetSRChallengeTeamId()
  self._data = eventListData.eventId
  self._frame:ReloadAllCell()
  local helfFrame = self._frame:GetTotalLength() / 2
  local anchor, offset = self._panel:GetWidth()
  local midFrameTarget = offset / 2 - helfFrame
  self._frame:SetMargin(midFrameTarget, 0)
  self._frame:ReloadAllCell()
end

function EventListDialog:OnDestroy()
  UIBackManager.SetUIBackShow(false)
  if self._frame then
    self._frame:Destroy()
  end
end

function EventListDialog:OnBackBtnClicked()
  self:Destroy()
end

function EventListDialog:NumberOfCell(frame)
  return #self._data
end

function EventListDialog:CellAtIndex(frame, index)
  return "activity.swimsuitechoes.challenge.eventlistcell"
end

function EventListDialog:DataAtIndex(frame, index)
  return self._data[index]
end

function EventListDialog:OnSelectEvent(id)
  self._confirmBtn:SetInteractable(true)
  self._selectId = id
  self._frame:FireEvent("Select", id)
end

function EventListDialog:SendSelectEvent()
  local csend = LuaNetManager.CreateProtocol("protocol.activity.cchoosebattleevent")
  csend.eventId = self._selectId
  csend:Send()
end

function EventListDialog:GoBattle()
  local csend = LuaNetManager.CreateProtocol("protocol.activity.csummerechoevent")
  csend.constructionID = 21
  csend.eventID = self._copyID
  csend.lineupID = self._teamId
  csend:Send()
  GlobalGameFSM:SetBoolean("selectSummerEchoesEvent", false)
  NekoData.DataManager.DM_Activity:GetManager(DataCommon.SummerActivityEchoesManagerID):OnSBattleEvent(nil)
  self:Destroy()
end

return EventListDialog
