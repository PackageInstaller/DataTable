-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/threeelimination/view/ThreeEliminationMainView.lua

module("logic.extensions.threeelimination.view.ThreeEliminationMainView", package.seeall)

local ThreeEliminationMainView = class("ThreeEliminationMainView", ViewComponent)

function ThreeEliminationMainView:ctor()
	ThreeEliminationMainView.super.ctor(self)
end

function ThreeEliminationMainView:unbindEvents()
	ThreeEliminationMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnTask)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnStart)
	GameUtil.rmClickHandler(self._btnRule)
end

function ThreeEliminationMainView:bindEvents()
	ThreeEliminationMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnTask, self._onClickTask, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickShop, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickStart, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
end

function ThreeEliminationMainView:buildUI()
	ThreeEliminationMainView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnRank = self:getGo("btnRank")
	self._btnTask = self:getGo("btnTask")
	self._redPointTask = self:getGo("btnTask/redpoint")
	self._btnShop = self:getGo("btnShop")
	self._btnStart = self:getGo("btnStart")
	self._redPointStart = self:getGo("btnStart/redpoint")
	self._btnRule = self:getGo("btnTip")
	self._progress = self:getGo("progress")
	self._txtProgress = self:getTxt("progress/txtProgress")
	self._txtTime = self:getTxt("time/txtTime")
	self._con = self:getGo("con")
end

function ThreeEliminationMainView:onExit()
	ThreeEliminationMainView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._redPointTask)
	RedPointController.instance:unregRedPoint(self._redPointStart)

	if not ViewMgr.instance:isOpen(ViewName.ThreeEliminationView) and not ViewMgr.instance:isOpen(ViewName.ThreeEliminationBattleView) then
		-- block empty
	end

	RoleObjectPool.instance:removeRole(self._role)
end

function ThreeEliminationMainView:onEnter()
	ThreeEliminationMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_ThreeEliminationGameOpenFuncRes, self._refreshView, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = ThreeEliminationOtherModel.instance:getCurrActId()
	end

	ThreeEliminationGameAgent.instance:sendPM_ThreeEliminationGameOpenFuncReq(self._activityId)

	self._txtTime.text = GameUtil.getActTimeDesc(GameEnum.ActivityType.ThreeElimination, self._activityId)
	self._activityCfg = ThreeEliminationConfig.instance:getActivityCfg(self._activityId)

	local taskPlanCfg = EventTaskSummaryConfig.instance:getPlanCfg(self._activityId)

	RedPointController.instance:regRedPoint(self._redPointTask, taskPlanCfg.redPointId)
	RedPointController.instance:regRedPoint(self._redPointStart, RedPointModel.ID_THREEELIMINATION_LEVEL, self._activityCfg.redPointId)
	self:_onSetUI()
end

function ThreeEliminationMainView:_onSetUI()
	local skinId = self._activityCfg.skinId

	if skinId > 0 then
		self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)
	end
end

function ThreeEliminationMainView:_refreshView()
	local bestGroup = ThreeEliminationOtherModel.instance:getBestBattleGroup()
	local bestStage = ThreeEliminationOtherModel.instance:getBestBattleStage()

	if self._txtProgress then
		if bestGroup > 0 then
			GameUtil.SetActive(self._progress, true)

			self._txtProgress.text = langPara("%d-%d", bestGroup, bestStage)
		else
			GameUtil.SetActive(self._progress, false)
		end
	end
end

function ThreeEliminationMainView:_onClickClose()
	self:close()
end

function ThreeEliminationMainView:_onClickRank()
	UIStateManager.instance:push(ViewName.ThreeEliminationRankView, self._activityId)
end

function ThreeEliminationMainView:_onClickTask()
	UIStateManager.instance:push(ViewName.ThreeEliminationTaskView, self._activityId)
end

function ThreeEliminationMainView:_onClickShop()
	GotoMgr.gotoByString(self._activityCfg.jumpTo[1])
end

function ThreeEliminationMainView:_onClickStart()
	UIStateManager.instance:push(ViewName.ThreeEliminationView, self._activityId)
end

function ThreeEliminationMainView:_onClickRule()
	TipsFacade.instance:openRulesView("three_elimination_rule")
end

return ThreeEliminationMainView
