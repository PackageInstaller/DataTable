-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedarkkingdragonclg/view/DarkKingDragonResultView.lua

module("logic.extensions.divinedarkkingdragonclg.view.DarkKingDragonResultView", package.seeall)

local DarkKingDragonResultView = class("DarkKingDragonResultView", ViewComponent)

function DarkKingDragonResultView:ctor()
	DarkKingDragonResultView.super.ctor(self)
end

function DarkKingDragonResultView:unbindEvents()
	DarkKingDragonResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnCancel_btnCancel)
end

function DarkKingDragonResultView:bindEvents()
	DarkKingDragonResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickCancel, self)
end

function DarkKingDragonResultView:buildUI()
	DarkKingDragonResultView.super.buildUI(self)

	self._btnSure = self:getGo("btnSure")
	self._btnCancel = self:getGo("btnCancel")
	self._emptyTips = self:getGo("normal/lock/emptyTips")

	local goTab = self:getGo("normal/lock/tableview")
	local goCell = self:getGo("normal/lock/tableview/tablecell")

	self._tableView = ScrollerList.create(goTab, goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._normal = self:getGo("normal")
	self._lastStage = self:getGo("lastStage")
	self._txtValue = self:getTxt("normal/txtSettleDesc/txtValue")
	self._txtValue2 = self:getTxt("normal/angle/txtValue")
	self._txtSettleDesc = self:getTxt("normal/txtSettleDesc")
	self._txtDesc = self:getTxt("normal/txtDesc")
end

function DarkKingDragonResultView:onExit()
	DarkKingDragonResultView.super.onExit(self)
	self._tableView:dispose()
end

function DarkKingDragonResultView:onEnter()
	DarkKingDragonResultView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_DivineDarkKingDragonClgConfirmRes, self._handleConfirm, self)

	local params = self:getOpenParam()

	self._resultInfo = params[1]

	if self._resultInfo == nil then
		self:_onClickCancel()

		return
	end

	self._num = self._resultInfo.num or 0
	self._activityId = self._resultInfo.activityId
	self._phaseId = self._resultInfo.phaseId
	self._stageId = self._resultInfo.stageId
	self._curLockRaceIds = self._resultInfo.lockRaceIds or {}

	self:_updateUI()
end

function DarkKingDragonResultView:_updateUI()
	self._phaseCfgs = DivineDarkKingDragonClgConfig.instance:getPhaseCfgsByActId(self._activityId) or {}

	goutil.setActive(self._normal, #self._phaseCfgs > self._phaseId)
	goutil.setActive(self._lastStage, #self._phaseCfgs == self._phaseId)

	self._lockRaceIds = {}

	local phaseInfo = DivineDarkKingDragonClgModel.instance:getPhaseInfo(self._activityId, self._phaseId)

	if phaseInfo then
		self._lockRaceIds = phaseInfo.lockRaceIds or {}
	end

	goutil.setActive(self._emptyTips, #self._curLockRaceIds == 0)
	self._tableView:reloadData(self._curLockRaceIds)

	local curPhaseCfg = self._phaseCfgs[self._phaseId]

	if curPhaseCfg then
		self._txtValue.text = self._num

		local angle = DivineDarkKingDragonClgConfig.instance:getAngleByPhaseIdAndNum(self._activityId, self._phaseId, self._num)

		self._txtValue2.text = string.format("%d°", angle)
		self._txtSettleDesc.text = curPhaseCfg.settlementDesc
		self._txtDesc.text = curPhaseCfg.lockDesc
	end
end

function DarkKingDragonResultView:_updateCell(view, cell, data, tag)
	local proxy = MaterialMgr.setCell(MatType.Pet, data, cell.gameObject)

	if proxy then
		proxy.binder:setAutoTips(false)
	end
end

function DarkKingDragonResultView:_clearCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function DarkKingDragonResultView:_onClickSure()
	DivineDarkKingDragonClgController.instance:confirm(self._activityId, self._phaseId, self._stageId, true)
end

function DarkKingDragonResultView:_onClickCancel()
	self:close()
	BattleController.instance:endBattle()
end

function DarkKingDragonResultView:_handleConfirm()
	self:close()
	BattleController.instance:endBattle()
end

return DarkKingDragonResultView
