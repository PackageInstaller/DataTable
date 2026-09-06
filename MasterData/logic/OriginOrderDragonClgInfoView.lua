-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originorderdragonclg/view/OriginOrderDragonClgInfoView.lua

module("logic.extensions.originorderdragonclg.view.OriginOrderDragonClgInfoView", package.seeall)

local OriginOrderDragonClgInfoView = class("OriginOrderDragonClgInfoView", ViewComponent)

function OriginOrderDragonClgInfoView:ctor()
	OriginOrderDragonClgInfoView.super.ctor(self)
end

function OriginOrderDragonClgInfoView:unbindEvents()
	OriginOrderDragonClgInfoView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnCancel)
end

function OriginOrderDragonClgInfoView:bindEvents()
	OriginOrderDragonClgInfoView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickCancel, self)
end

function OriginOrderDragonClgInfoView:buildUI()
	OriginOrderDragonClgInfoView.super.buildUI(self)

	self._btnSure = self:getGo("btnSure")
	self._btnCancel = self:getGo("btnCancel")
	self._txtValueHitCount = self:getTxt("normal/hitCount/txtValue")
	self._txtValueHpPresent = self:getTxt("normal/hpPresent/txtValue")
	self._txtValueScore = self:getTxt("normal/score/txtValue")

	local goTab = self:getGo("normal/lock/tableview")
	local goCell = self:getGo("normal/lock/tableview/tablecell")

	self._tableView = ScrollerList.create(goTab, goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function OriginOrderDragonClgInfoView:onExit()
	OriginOrderDragonClgInfoView.super.onExit(self)
	self._tableView:dispose()
end

function OriginOrderDragonClgInfoView:onEnter()
	OriginOrderDragonClgInfoView.super.onEnter(self)

	local params = self:getOpenParam()

	if params then
		self._activityId = checknumber(params[1])
		self._stageId = checknumber(params[2])
	end

	if self._activityId == 0 then
		self._activityId = 568001
	end

	if self._stageId == 0 then
		self._stageId = 1
	end

	self:_updateUIByCfg()
	self:_updateUIByInfo()
end

function OriginOrderDragonClgInfoView:_updateUIByCfg()
	self._stageCfg = OriginOrderDragonClgConfig.instance:getStageCfgById(self._activityId, self._stageId)
end

function OriginOrderDragonClgInfoView:_updateUIByInfo()
	local newScore = 0
	local hitCount = 0
	local hpWanPercent = 0
	local raceIds = {}
	local stageInfo = OriginOrderDragonClgModel.instance:getStageInfoById(self._activityId, self._stageId)

	if stageInfo then
		newScore = stageInfo.score or 0
		hitCount = stageInfo.hitCount or 0
		hpWanPercent = stageInfo.hpWanPercent or 0
		raceIds = stageInfo.raceIds or {}
	end

	local hpPresent = hpWanPercent / 100

	self._txtValueHitCount.text = hitCount
	self._txtValueHpPresent.text = string.format("%.2f", hpPresent)

	if self._stageCfg then
		if not self._stageCfg.hpWanScoreRate then
			local hpWanScoreRate = 0

			if self._stageCfg then
				if not self._stageCfg.hitCountScoreRate then
					local hitCountScoreRate = 0
					local showHitCountScoreRate = tostring(hitCountScoreRate)

					self._txtValueScore.text = string.format("<color=#20b376>%s</color> (<color=#eb4642>%s</color> * %s + <color=#eb4642>%s</color> * %s)", newScore, hitCount, (hitCountScoreRate < 0 or nil) and string.format("(-%s)", tostring(math.abs(hitCountScoreRate))), hpPresent, hpWanScoreRate * 100)

					self._tableView:reloadData(raceIds)
					self._tableView:setCenterMode(true)
				end
			end
		end
	end
end

function OriginOrderDragonClgInfoView:_updateCell(view, cell, data, tag)
	local proxy = MaterialMgr.setCell(MatType.Pet, data, cell.gameObject)

	if proxy then
		proxy.binder:setAutoTips(false)
	end
end

function OriginOrderDragonClgInfoView:_clearCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function OriginOrderDragonClgInfoView:_onClickSure()
	self:close()
end

function OriginOrderDragonClgInfoView:_onClickCancel()
	self:close()
	OriginOrderDragonClgController.instance:showMissionView(self._activityId, self._stageId)
end

return OriginOrderDragonClgInfoView
