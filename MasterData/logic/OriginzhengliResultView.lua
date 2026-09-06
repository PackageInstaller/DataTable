-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originzhengli/view/OriginzhengliResultView.lua

module("logic.extensions.originzhengli.view.OriginzhengliResultView", package.seeall)

local OriginzhengliResultView = class("OriginzhengliResultView", ViewComponent)
local settleType = {
	UltimateCount = "UltimateCount",
	CircleCount = "CircleCount",
	ActiveCount = "ActiveCount"
}

function OriginzhengliResultView:ctor()
	OriginzhengliResultView.super.ctor(self)
end

function OriginzhengliResultView:unbindEvents()
	OriginzhengliResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnCancel)
end

function OriginzhengliResultView:bindEvents()
	OriginzhengliResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickCancel, self)
end

function OriginzhengliResultView:buildUI()
	OriginzhengliResultView.super.buildUI(self)

	self._btnSure = self:getGo("btnSure")
	self._btnCancel = self:getGo("btnCancel")
	self._goRoundNum = self:getGo("info/showInfos/roundNum")
	self._goKillCount = self:getGo("info/showInfos/killCount")
	self._goActiveNum = self:getGo("info/showInfos/activeNum")
	self._txtValueRoundNum = self:getTxt("info/showInfos/roundNum/txtValue")
	self._txtValueKillCount = self:getTxt("info/showInfos/killCount/txtValue")
	self._txtValueActiveNum = self:getTxt("info/showInfos/activeNum/txtValue")
	self._txtValueScore = self:getTxt("info/score/txtValue")

	local goTab = self:getGo("info/lock/tableview")
	local goCell = self:getGo("info/lock/tableview/tablecell")

	self._tableView = ScrollerList.create(goTab, goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function OriginzhengliResultView:onExit()
	OriginzhengliResultView.super.onExit(self)
	self._tableView:dispose()
end

function OriginzhengliResultView:onEnter()
	OriginzhengliResultView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_OriginZhengliSaveClgRes, self._handleConfirm, self)

	self._resultInfo = OriginZhengliModel.instance:getLastFightInfo()

	if self._resultInfo == nil then
		self:_onClickCancel()

		return
	end

	self._activityId = self._resultInfo.activityId
	self._stageId = self._resultInfo.stageId

	self:_updateUIByCfg()
	self:_updateUIByInfo()
end

function OriginzhengliResultView:_updateUIByCfg()
	self._stageCfg = OriginZhengliConfig.instance:getStageCfgById(self._activityId, self._stageId)

	goutil.setActive(self._goRoundNum, false)
	goutil.setActive(self._goKillCount, false)
	goutil.setActive(self._goActiveNum, false)

	for _, planId in ipairs((self._stageCfg or nil) and (self._stageCfg.settlePlan or {})) do
		local planCfg = OriginZhengliConfig.instance:getSettlePlanCfg(self._activityId, planId, 1)

		if planCfg then
			if planCfg.settleType == settleType.CircleCount then
				goutil.setActive(self._goRoundNum, true)
			elseif planCfg.settleType == settleType.UltimateCount then
				goutil.setActive(self._goKillCount, true)
			elseif planCfg.settleType == settleType.ActiveCount then
				goutil.setActive(self._goActiveNum, true)
			end
		end
	end
end

function OriginzhengliResultView:_updateUIByInfo()
	if not self._resultInfo.gainPoints then
		if not self._resultInfo.activeCount then
			local activeCount = 0

			if not self._resultInfo.ultimateCount then
				local killCount = 0

				if not self._resultInfo.circleCount then
					local roundNum = 0

					if not self._resultInfo.banRaceId then
						local banRaceIds = {}

						self._txtValueRoundNum.text = tostring(roundNum)
						self._txtValueKillCount.text = tostring(killCount)
						self._txtValueActiveNum.text = tostring(activeCount)
						self._txtValueScore.text = tostring(self._resultInfo.gainPoints)

						self._tableView:reloadData(banRaceIds)
						self._tableView:setCenterMode(true)
					end
				end
			end
		end
	end
end

function OriginzhengliResultView:_updateCell(view, cell, data, tag)
	local proxy = MaterialMgr.setCell(MatType.Pet, data, cell.gameObject)

	if proxy then
		proxy.binder:setAutoTips(false)
	end
end

function OriginzhengliResultView:_clearCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function OriginzhengliResultView:_onClickSure()
	OriginZhengliController.instance:saveChallenge(self._activityId)
end

function OriginzhengliResultView:_onClickCancel()
	self:_handleConfirm()
end

function OriginzhengliResultView:_handleConfirm()
	self:close()
	BattleController.instance:endBattle()
end

return OriginzhengliResultView
