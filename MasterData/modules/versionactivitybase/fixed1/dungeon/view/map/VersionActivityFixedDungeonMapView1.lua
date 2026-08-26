-- chunkname: @modules/versionactivitybase/fixed1/dungeon/view/map/VersionActivityFixedDungeonMapView1.lua

module("modules.versionactivitybase.fixed1.dungeon.view.map.VersionActivityFixedDungeonMapView1", package.seeall)

local VersionActivityFixedDungeonMapView1 = class("VersionActivityFixedDungeonMapView1", VersionActivityFixedDungeonMapView)

function VersionActivityFixedDungeonMapView1:_editableInitView()
	VersionActivityFixedDungeonMapView1.super._editableInitView(self)

	self._btnnote = gohelper.findChildButtonWithAudio(self.viewGO, "#go_topright/#btn_note")
	self._btnreport = gohelper.findChildButtonWithAudio(self.viewGO, "#go_topright/#btn_report")
	self._notereddot = gohelper.findChild(self.viewGO, "#go_topright/#btn_note/#go_reddot")

	RedDotController.instance:addRedDot(self._notereddot, RedDotEnum.DotNode.V3a2DungeonNote)

	local firstNoteConfig = VersionActivityFixedDungeonConfig1.instance:getChapterReport(1)

	self._firstNoteElementId = firstNoteConfig.element

	gohelper.setActive(self._btnreport.gameObject, false)
	gohelper.setActive(self._btnnote, false)
	self:_initReportElements()
end

function VersionActivityFixedDungeonMapView1:_initReportElements()
	self._reportList = VersionActivityFixedDungeonConfig1.instance:getOptionConfigs()
end

function VersionActivityFixedDungeonMapView1:addEvents()
	VersionActivityFixedDungeonMapView1.super.addEvents(self)
	self._btnnote:AddClickListener(self._btnnoteOnClick, self)
	self._btnreport:AddClickListener(self._btnreportOnClick, self)
end

function VersionActivityFixedDungeonMapView1:removeEvents()
	VersionActivityFixedDungeonMapView1.super.removeEvents(self)
	self._btnnote:RemoveClickListener()
	self._btnreport:RemoveClickListener()
end

function VersionActivityFixedDungeonMapView1:_btnnoteOnClick()
	self.viewContainer:initNoteElementRecordInfos()

	local bigVersion, smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()
	local enum = VersionActivityFixedHelper.getVersionActivityEnum(bigVersion, smallVersion)

	Activity113Rpc.instance:sendGetAct113InfoRequest(enum.ActivityId.Dungeon, self._getInfoCallback, self)
end

function VersionActivityFixedDungeonMapView1:_getInfoCallback(cmd, resultCode, msg)
	if resultCode == 0 then
		local bigVersion, smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()
		local viewName = VersionActivityFixedHelper.getVersionActivityDungeonReportFullViewName(bigVersion, smallVersion)

		ViewMgr.instance:openView(viewName, msg.acceptedRewardId)
	end
end

function VersionActivityFixedDungeonMapView1:_btnreportOnClick()
	if not self._isReportFinish then
		GameFacade.showToast(321304)

		return
	end

	local bigVersion, smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()
	local viewName = VersionActivityFixedHelper.getVersionActivityDungeonReportTipsViewName(bigVersion, smallVersion)

	ViewMgr.instance:openView(viewName)
end

function VersionActivityFixedDungeonMapView1:hideBtnUI()
	VersionActivityFixedDungeonMapView1.super.hideBtnUI(self)

	if not self.viewContainer:showTimeline() then
		self.animator:Play("mapepisodelist_close", 0, 0)
	end
end

function VersionActivityFixedDungeonMapView1:showBtnUI()
	VersionActivityFixedDungeonMapView1.super.showBtnUI(self)

	if not self.viewContainer:showTimeline() then
		self.animator:Play("open_map", 0, 0)
	end
end

return VersionActivityFixedDungeonMapView1
