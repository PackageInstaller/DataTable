-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedarkkingdragonclg/view/DarkKingDragonSpaceView.lua

module("logic.extensions.divinedarkkingdragonclg.view.DarkKingDragonSpaceView", package.seeall)

local DarkKingDragonSpaceView = class("DarkKingDragonSpaceView", ViewComponent)

function DarkKingDragonSpaceView:ctor()
	DarkKingDragonSpaceView.super.ctor(self)
end

function DarkKingDragonSpaceView:unbindEvents()
	DarkKingDragonSpaceView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function DarkKingDragonSpaceView:bindEvents()
	DarkKingDragonSpaceView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self.close, self)
end

function DarkKingDragonSpaceView:buildUI()
	DarkKingDragonSpaceView.super.buildUI(self)

	self._btnSure = self:getGo("btnSure")
	self._emptyTips = self:getGo("lock/emptyTips")

	local goTab = self:getGo("lock/tableview")
	local goCell = self:getGo("lock/tableview/tablecell")

	self._tableView = ScrollerList.create(goTab, goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txt = self:getTxt("txt")
	self._txtDesc = self:getTxt("txtDesc")
end

function DarkKingDragonSpaceView:onExit()
	DarkKingDragonSpaceView.super.onExit(self)
	self._tableView:dispose()
end

function DarkKingDragonSpaceView:onEnter()
	DarkKingDragonSpaceView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_DivineDarkKingDragonClgInfoRes, self._updateUIByInfo, self)

	self._activityId = 526001
	self._phaseId = 1

	local params = self:getOpenParam()

	if params then
		self._activityId = checknumber(params[1])
		self._phaseId = checknumber(params[2])
	end

	self:_updateUIByCfg()
	self:_updateUIByInfo()
	DivineDarkKingDragonClgController.instance:getInfo(self._activityId)
end

function DarkKingDragonSpaceView:_updateUIByCfg()
	self._phaseCfg = DivineDarkKingDragonClgConfig.instance:getPhaseCfgsByPhaseId(self._activityId, self._phaseId)
	self._txt.text = self._phaseCfg.actDesc
	self._txtDesc.text = self._phaseCfg.lockDesc
end

function DarkKingDragonSpaceView:_updateUIByInfo()
	self._lockRaceIds = {}

	local phaseInfo = DivineDarkKingDragonClgModel.instance:getPhaseInfo(self._activityId, self._phaseId)

	if phaseInfo then
		self._lockRaceIds = phaseInfo.lockRaceIds or {}
	end

	goutil.setActive(self._emptyTips, #self._lockRaceIds == 0)
	self._tableView:reloadData(self._lockRaceIds)
end

function DarkKingDragonSpaceView:_updateCell(view, cell, data, tag)
	local proxy = MaterialMgr.setCell(MatType.Pet, data, cell.gameObject)

	if proxy then
		proxy.binder:setAutoTips(false)
	end
end

function DarkKingDragonSpaceView:_clearCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

return DarkKingDragonSpaceView
