-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktower/view/PeakTowerMainView.lua

module("logic.extensions.peaktower.view.PeakTowerMainView", package.seeall)

local PeakTowerMainView = class("PeakTowerMainView", ViewComponent)

function PeakTowerMainView:ctor()
	PeakTowerMainView.super.ctor(self)
end

function PeakTowerMainView:unbindEvents()
	PeakTowerMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnBasic)
	GameUtil.rmClickHandler(self._btnLegend)
	GameUtil.rmClickHandler(self._btnBuff)
	GameUtil.rmClickHandler(self._btnPrize)
	GameUtil.rmClickHandler(self._btnRank)
end

function PeakTowerMainView:bindEvents()
	PeakTowerMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTips, self)
	GameUtil.addClickHandler(self._btnBasic, self._onClickBasic, self)
	GameUtil.addClickHandler(self._btnLegend, self._onClickLegend, self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBuff, self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickPrize, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
end

function PeakTowerMainView:buildUI()
	PeakTowerMainView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._btnBasic = self:getGo("btnBasic")
	self._btnLegend = self:getGo("btnLegend")
	self._btnBuff = self:getGo("btnBuff")
	self._btnPrize = self:getGo("btnPrize")
	self._prizeRedpoint = self:getGo("btnPrize/redpoint")
	self._btnRank = self:getGo("btnRank")
	self._txtBasicScore = self:getTxt("btnBasic/score/txt")
	self._basicPrizeCon = self:getGo("btnPrize/bubble/con")
	self._txtLegendScore = self:getTxt("btnLegend/tips/txt")
	self._legendPrizeCon = self:getGo("btnLegend/bubble/con")
	self._txtTime = self:getTxt("time/txtTime")
end

function PeakTowerMainView:onExit()
	PeakTowerMainView.super.onExit(self)
	MaterialMgr.resetAll(self._basicPrizeCon)
	MaterialMgr.resetAll(self._legendPrizeCon)
	RedPointController.instance:unregRedPoint(self._prizeRedpoint)
end

function PeakTowerMainView:onEnter()
	PeakTowerMainView.super.onEnter(self)
	self:addGEvent(GlobalNotify.PM_PeakTowerInfoRes, self._refreshView)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = 567001
	end

	local activityCfg = PeakTowerConfig.instance:getActivityCfg(self._activityId)

	self._weekId = PeakTowerController.instance:getCurWeekId(self._activityId)
	self._txtTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)

	PeakTowerAgent.instance:sendPM_PeakTowerInfoReq(self._activityId)
	RedPointController.instance:regRedPoint(self._prizeRedpoint, checknumber(activityCfg.redPointId))
end

function PeakTowerMainView:_refreshView()
	local activityCfg = PeakTowerConfig.instance:getActivityCfg(self._activityId)

	MaterialMgr.setCellByCfg(activityCfg.basicPrizeItem, self._basicPrizeCon)
	MaterialMgr.setCellByCfg(activityCfg.legendPrizeItem, self._legendPrizeCon)

	local totalBasicScore = PeakTowerController.instance:getAllBasicScore(self._activityId)

	self._txtBasicScore.text = langPara("当前最高分：%d", totalBasicScore)

	if totalBasicScore >= checknumber(activityCfg.legendOpenScore) then
		local totalLegendScore = PeakTowerController.instance:getAllLegendScore(self._activityId)

		self._txtLegendScore.text = langPara("当前最高分：%d", totalLegendScore)
	else
		self._txtLegendScore.text = langPara("分数达到%d解锁", activityCfg.legendOpenScore)
	end
end

function PeakTowerMainView:_onClickTip()
	TipsFacade.instance:openRulesView("peak_tower_rule")
end

function PeakTowerMainView:_onClickBasic()
	if PeakTowerController.instance:checkCanEnterBattle(self._activityId) == false then
		-- block empty
	else
		UIStateManager.instance:push(ViewName.PeakTowerBasicView, self._activityId)
	end
end

function PeakTowerMainView:_onClickLegend()
	local totalBasicScore = PeakTowerController.instance:getAllBasicScore(self._activityId)
	local activityCfg = PeakTowerConfig.instance:getActivityCfg(self._activityId)
	local basicFloorCfgs = PeakTowerConfig.instance:getBasicFloorCfgs(self._activityId, self._weekId)
	local maxPassBasic = PeakTowerModel.instance:getBasicMaxPassFloor(self._activityId)

	if maxPassBasic < #basicFloorCfgs then
		FloatWordMgr.instance:show(langPara("请通关入门挑战"))
	elseif totalBasicScore < checknumber(activityCfg.legendOpenScore) then
		FloatWordMgr.instance:show(langPara("分数达到%d解锁", activityCfg.legendOpenScore))
	elseif PeakTowerController.instance:checkCanEnterBattle(self._activityId) == false then
		-- block empty
	else
		UIStateManager.instance:push(ViewName.PeakTowerLegendView, self._activityId)
	end
end

function PeakTowerMainView:_onClickBuff()
	UIStateManager.instance:push(ViewName.PeakTowerVerifyView, self._activityId)
end

function PeakTowerMainView:_onClickPrize()
	UIStateManager.instance:push(ViewName.PeakTowerPrizeView, self._activityId)
end

function PeakTowerMainView:_onClickRank()
	UIStateManager.instance:push(ViewName.PeakTowerRankView, self._activityId)
end

function PeakTowerMainView:_onClickTips()
	TipsFacade.instance:openRulesView("peak_tower_rule")
end

return PeakTowerMainView
