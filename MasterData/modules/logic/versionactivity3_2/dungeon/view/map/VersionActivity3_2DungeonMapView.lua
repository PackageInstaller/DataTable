-- chunkname: @modules/logic/versionactivity3_2/dungeon/view/map/VersionActivity3_2DungeonMapView.lua

module("modules.logic.versionactivity3_2.dungeon.view.map.VersionActivity3_2DungeonMapView", package.seeall)

local VersionActivity3_2DungeonMapView = class("VersionActivity3_2DungeonMapView", VersionActivityFixedDungeonMapView)

function VersionActivity3_2DungeonMapView:_editableInitView()
	VersionActivity3_2DungeonMapView.super._editableInitView(self)

	self._btnnote = gohelper.findChildButtonWithAudio(self.viewGO, "#go_topright/#btn_note")
	self._btnreport = gohelper.findChildButtonWithAudio(self.viewGO, "#go_topright/#btn_report")
	self._notereddot = gohelper.findChild(self.viewGO, "#go_topright/#btn_note/#go_reddot")

	RedDotController.instance:addRedDot(self._notereddot, RedDotEnum.DotNode.V3a2DungeonNote)

	local firstNoteConfig = lua_v3a2_chapter_report.configList[1]

	self._firstNoteElementId = firstNoteConfig.element

	self:_initReportElements()
	self:_updateNoteBtn()
	self:_updateReportBtn()
end

function VersionActivity3_2DungeonMapView:_initReportElements()
	self._reportList = VersionActivity3_2DungeonConfig.instance:getOptionConfigs()
end

function VersionActivity3_2DungeonMapView:addEvents()
	VersionActivity3_2DungeonMapView.super.addEvents(self)
	self._btnnote:AddClickListener(self._btnnoteOnClick, self)
	self._btnreport:AddClickListener(self._btnreportOnClick, self)
end

function VersionActivity3_2DungeonMapView:removeEvents()
	VersionActivity3_2DungeonMapView.super.removeEvents(self)
	self._btnnote:RemoveClickListener()
	self._btnreport:RemoveClickListener()
end

function VersionActivity3_2DungeonMapView:_btnnoteOnClick()
	self.viewContainer:initNoteElementRecordInfos()
	Activity113Rpc.instance:sendGetAct113InfoRequest(VersionActivity3_2Enum.ActivityId.Dungeon, self._getInfoCallback, self)
end

function VersionActivity3_2DungeonMapView:_getInfoCallback(cmd, resultCode, msg)
	if resultCode == 0 then
		ViewMgr.instance:openView(ViewName.VersionActivity3_2DungeonReportFullView, msg.acceptedRewardId)
	end
end

function VersionActivity3_2DungeonMapView:_btnreportOnClick()
	if not self._isReportFinish then
		GameFacade.showToast(ToastEnum.V3a2_Dungeon_Report_NotFinish)

		return
	end

	ViewMgr.instance:openView(ViewName.VersionActivity3_2DungeonReportTipsView)
end

function VersionActivity3_2DungeonMapView:_updateNoteBtn()
	local isFinish = DungeonMapModel.instance:elementIsFinished(self._firstNoteElementId)

	gohelper.setActive(self._btnnote, isFinish)
end

function VersionActivity3_2DungeonMapView:_updateReportBtn()
	local isFinish = true

	for _, v in ipairs(self._reportList) do
		if not DungeonMapModel.instance:elementIsFinished(v.id) then
			isFinish = false

			break
		end
	end

	self._isReportFinish = isFinish

	gohelper.setActive(self._btnreport, true)
end

function VersionActivity3_2DungeonMapView:onRemoveElement(elementId)
	VersionActivity3_2DungeonMapView.super.onRemoveElement(self, elementId)
	self:_updateNoteBtn()
	self:_updateReportBtn()
end

function VersionActivity3_2DungeonMapView:hideBtnUI()
	VersionActivity3_2DungeonMapView.super.hideBtnUI(self)

	if not self.viewContainer:showTimeline() then
		self.animator:Play("mapepisodelist_close", 0, 0)
	end
end

function VersionActivity3_2DungeonMapView:showBtnUI()
	VersionActivity3_2DungeonMapView.super.showBtnUI(self)

	if not self.viewContainer:showTimeline() then
		self.animator:Play("open_map", 0, 0)
	end
end

return VersionActivity3_2DungeonMapView
