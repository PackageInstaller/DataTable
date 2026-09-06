-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originorderdragonclg/view/OriginOrderDragonClgResultView.lua

module("logic.extensions.originorderdragonclg.view.OriginOrderDragonClgResultView", package.seeall)

local OriginOrderDragonClgResultView = class("OriginOrderDragonClgResultView", ViewComponent)

function OriginOrderDragonClgResultView:ctor()
	OriginOrderDragonClgResultView.super.ctor(self)
end

function OriginOrderDragonClgResultView:unbindEvents()
	OriginOrderDragonClgResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnCancel)
end

function OriginOrderDragonClgResultView:bindEvents()
	OriginOrderDragonClgResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickCancel, self)
end

function OriginOrderDragonClgResultView:buildUI()
	OriginOrderDragonClgResultView.super.buildUI(self)

	self._btnSure = self:getGo("btnSure")
	self._btnCancel = self:getGo("btnCancel")
	self._txtValueHitCount = self:getTxt("normal/hitCount/txtValue")
	self._txtValueHpPresent = self:getTxt("normal/hpPresent/txtValue")
	self._txtValueScore = self:getTxt("normal/score/txtValue")

	local goTab = self:getGo("normal/lock/tableview")
	local goCell = self:getGo("normal/lock/tableview/tablecell")

	self._tableView = ScrollerList.create(goTab, goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._markDown = self:getGo("normal/markDown")
end

function OriginOrderDragonClgResultView:onExit()
	OriginOrderDragonClgResultView.super.onExit(self)
	self._tableView:dispose()
end

function OriginOrderDragonClgResultView:onEnter()
	OriginOrderDragonClgResultView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_OriginOrderDragonClgConfirmRes, self._handleConfirm, self)

	local params = self:getOpenParam()

	self._resultInfo = params[1]

	if self._resultInfo == nil then
		self:_onClickCancel()

		return
	end

	self._activityId = self._resultInfo.activityId
	self._stageId = self._resultInfo.stageId
	self._newStageInfo = self._resultInfo.stageInfo

	self:_updateUIByCfg()
	self:_updateUIByInfo()
end

function OriginOrderDragonClgResultView:_updateUIByCfg()
	self._stageCfg = OriginOrderDragonClgConfig.instance:getStageCfgById(self._activityId, self._stageId)
end

function OriginOrderDragonClgResultView:_updateUIByInfo()
	local oldScore = 0
	local oldStageInfo = OriginOrderDragonClgModel.instance:getStageInfoById(self._activityId, self._stageId)

	if oldStageInfo then
		oldScore = oldStageInfo.score or 0
	end

	if not self._newStageInfo.score then
		local newScore = 0

		goutil.setActive(self._markDown, newScore < oldScore)

		if not self._newStageInfo.hitCount then
			local hitCount = 0

			if not self._newStageInfo.hpWanPercent then
				local hpWanPercent = 0
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

								if not self._newStageInfo.raceIds then
									self._tableView:reloadData(self._newStageInfo.raceIds)
									self._tableView:setCenterMode(true)
								end
							end
						end
					end
				end
			end
		end
	end
end

function OriginOrderDragonClgResultView:_updateCell(view, cell, data, tag)
	local proxy = MaterialMgr.setCell(MatType.Pet, data, cell.gameObject)

	if proxy then
		proxy.binder:setAutoTips(false)
	end
end

function OriginOrderDragonClgResultView:_clearCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function OriginOrderDragonClgResultView:_onClickSure()
	OriginOrderDragonClgController.instance:confirm(self._activityId, self._stageId, true)
end

function OriginOrderDragonClgResultView:_onClickCancel()
	OriginOrderDragonClgController.instance:confirm(self._activityId, self._stageId, false)
end

function OriginOrderDragonClgResultView:_handleConfirm()
	self:close()
	BattleController.instance:endBattle()
end

return OriginOrderDragonClgResultView
