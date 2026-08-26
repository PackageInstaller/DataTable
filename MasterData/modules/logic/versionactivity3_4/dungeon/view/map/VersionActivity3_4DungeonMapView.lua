-- chunkname: @modules/logic/versionactivity3_4/dungeon/view/map/VersionActivity3_4DungeonMapView.lua

module("modules.logic.versionactivity3_4.dungeon.view.map.VersionActivity3_4DungeonMapView", package.seeall)

local VersionActivity3_4DungeonMapView = class("VersionActivity3_4DungeonMapView", VersionActivityFixedDungeonMapView)

function VersionActivity3_4DungeonMapView:_editableInitView()
	VersionActivity3_4DungeonMapView.super._editableInitView(self)

	self._btnnote = gohelper.findChildButtonWithAudio(self.viewGO, "#go_topright/#btn_note")
	self._btnreport = gohelper.findChildButtonWithAudio(self.viewGO, "#go_topright/#btn_report")
	self._notereddot = gohelper.findChild(self.viewGO, "#go_topright/#btn_note/#go_reddot")

	RedDotController.instance:addRedDot(self._notereddot, RedDotEnum.DotNode.V3a2DungeonNote)

	local firstNoteConfig = VersionActivity3_4DungeonConfig.instance:getChapterReport(1)

	self._firstNoteElementId = firstNoteConfig.element

	gohelper.setActive(self._btnreport.gameObject, false)
	gohelper.setActive(self._btnnote, false)
	self:_initReportElements()
end

function VersionActivity3_4DungeonMapView:_initReportElements()
	self._reportList = VersionActivity3_4DungeonConfig.instance:getOptionConfigs()
end

function VersionActivity3_4DungeonMapView:addEvents()
	VersionActivity3_4DungeonMapView.super.addEvents(self)
	self._btnnote:AddClickListener(self._btnnoteOnClick, self)
	self._btnreport:AddClickListener(self._btnreportOnClick, self)
end

function VersionActivity3_4DungeonMapView:removeEvents()
	VersionActivity3_4DungeonMapView.super.removeEvents(self)
	self._btnnote:RemoveClickListener()
	self._btnreport:RemoveClickListener()
end

function VersionActivity3_4DungeonMapView:_btnnoteOnClick()
	self.viewContainer:initNoteElementRecordInfos()
	Activity113Rpc.instance:sendGetAct113InfoRequest(VersionActivity3_4Enum.ActivityId.Dungeon, self._getInfoCallback, self)
end

function VersionActivity3_4DungeonMapView:_getInfoCallback(cmd, resultCode, msg)
	if resultCode == 0 then
		ViewMgr.instance:openView(ViewName.VersionActivity3_4DungeonReportFullView, msg.acceptedRewardId)
	end
end

function VersionActivity3_4DungeonMapView:_btnreportOnClick()
	if not self._isReportFinish then
		GameFacade.showToast(ToastEnum.DungeonMapReportFinish)

		return
	end

	ViewMgr.instance:openView(ViewName.VersionActivity3_4DungeonReportTipsView)
end

function VersionActivity3_4DungeonMapView:hideBtnUI()
	VersionActivity3_4DungeonMapView.super.hideBtnUI(self)

	if not self.viewContainer:showTimeline() then
		self.animator:Play("mapepisodelist_close", 0, 0)
	end
end

function VersionActivity3_4DungeonMapView:showBtnUI()
	VersionActivity3_4DungeonMapView.super.showBtnUI(self)

	if not self.viewContainer:showTimeline() then
		self.animator:Play("open_map", 0, 0)
	end
end

return VersionActivity3_4DungeonMapView
