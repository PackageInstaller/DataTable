-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chopking/view/ChopKingMainView.lua

module("logic.extensions.chopking.view.ChopKingMainView", package.seeall)

local ChopKingMainView = class("ChopKingMainView", ViewComponent)

function ChopKingMainView:ctor()
	ChopKingMainView.super.ctor(self)
end

function ChopKingMainView:unbindEvents()
	ChopKingMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnRogue)
	GameUtil.rmClickHandler(self._btnBuff)
	GameUtil.rmClickHandler(self._btnCircleClg)
	GameUtil.rmClickHandler(self._btnAgainstTwo)
	GameUtil.rmClickHandler(self._btnLoopClg)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnTask)
	GameUtil.rmClickHandler(self._btnJump)
end

function ChopKingMainView:bindEvents()
	ChopKingMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnRogue, self._onClickRogue, self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBuff, self)
	GameUtil.addClickHandler(self._btnCircleClg, self._onClickCircleClg, self)
	GameUtil.addClickHandler(self._btnAgainstTwo, self._onClickAgainstTwo, self)
	GameUtil.addClickHandler(self._btnLoopClg, self._onClickLoopClg, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnTask, self._onClickTask, self)
	GameUtil.addClickHandler(self._btnJump, self._onClickJump, self)
end

function ChopKingMainView:buildUI()
	ChopKingMainView.super.buildUI(self)

	self._btnBuff = self:getGo("cells/cell4/btnBuff")
	self._btnRogue = self:getGo("cells/cell4/btnArea")
	self._firstTag = self:getGo("cells/cell4/tag")
	self._txtFirst = self:getTxt("cells/cell4/lockGo/txtLock")
	self._firstTipsGo = self:getGo("cells/cell4/lockGo")
	self._circleClgLockGo = self:getGo("cells/cellCircleClg/lockGo")
	self._txtCircleLock = self:getTxt("cells/cellCircleClg/lockGo/txtLock")
	self._circleClgScoreGo = self:getGo("cells/cellCircleClg/score")
	self._txtCircleClgScore = self:getTxt("cells/cellCircleClg/score/txtScore")
	self._btnCircleClg = self:getGo("cells/cellCircleClg/btnArea")
	self._loopClgLockGo = self:getGo("cells/cellLoopClg/lockGo")
	self._txtLoopLock = self:getTxt("cells/cellLoopClg/lockGo/txtLock")
	self._loopClgScoreGo = self:getGo("cells/cellLoopClg/score")
	self._txtLoopClgScore = self:getTxt("cells/cellLoopClg/score/txtScore")
	self._btnLoopClg = self:getGo("cells/cellLoopClg/btnArea")
	self._loopClgTagGo = self:getGo("cells/cellLoopClg/tag")
	self._againstTwoLockGo = self:getGo("cells/cellAgainstTwo/lockGo")
	self._txtAgainstTwoLock = self:getTxt("cells/cellAgainstTwo/lockGo/txtLock")
	self._againstTwoScoreGo = self:getGo("cells/cellAgainstTwo/score")
	self._txtAgainstTwoScore = self:getTxt("cells/cellAgainstTwo/score/txtScore")
	self._btnAgainstTwo = self:getGo("cells/cellAgainstTwo/btnArea")
	self._btnTip = self:getGo("btnTip")
	self._btnClose = self:getGo("btnClose")
	self._txtTime = self:getTxt("time/txtTime")
	self._btnJump = self:getGo("btns/btnJump")
	self._btnTask = self:getGo("btns/btnTask")
	self._redPointTask = self:getGo("btns/btnTask/redPoint")
	self._btnRank = self:getGo("btns/btnRank")
	self._txtTotalScore = self:getTxt("totalScore/txtTotalScore")
	self._goldBarCon = self:getGo("goldBar")
end

function ChopKingMainView:onExit()
	ChopKingMainView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._redPointTask)
end

function ChopKingMainView:onEnter()
	ChopKingMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_ChopKingFirstClgInfoRes, self._PM_ChopKingFirstClgInfoRes, self)
	self.addGEvent(self, GlobalNotify.PM_NotifyChopKingFirstClgFightResultRes, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.PM_ChopKingCircleClgInfoRes, self._refreshCircleClgInfo, self)
	self.addGEvent(self, GlobalNotify.PM_ChopKingAgainstTwoClgInfoRes, self._refreshAgainstTwoClgInfo, self)
	self.addGEvent(self, GlobalNotify.PM_ChopKingLoopClgInfoRes, self._refreshLoopClgInfo, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = 470001
	end

	self._activityCfg = ChopKingConfig.instance:getActivityCfg(self._activityId)

	ChopKingAgent.instance:sendPM_ChopKingFirstClgInfoReq(self._activityId)

	self._txtTime.text = GameUtil.getActTimeDesc(ActivityDefineController.instance:getActTypeByActId(self._activityId), self._activityId)

	local taskCfg = EventTaskSummaryConfig.instance:getPlanCfg(self._activityId)

	if taskCfg and checknumber(taskCfg.redPointId) ~= 0 then
		RedPointController.instance:regRedPoint(self._redPointTask, taskCfg.redPointId)
	end

	self:_setTopGoldBar()
end

function ChopKingMainView:_refreshView()
	self:_refreshRogueView()
	self:_refreshCircleClgInfo()
	self:_refreshLoopClgInfo()
	self:_refreshAgainstTwoClgInfo()

	self._txtTotalScore.text = langPara("总积分：%d", ChopKingController.instance:getTotalScore(self._activityId))
end

function ChopKingMainView:_refreshRogueView()
	if ChopKingModel.instance:isNeedSelectBuff(self._activityId) == true then
		UIStateManager.instance:push(ViewName.ChopKingRogueSelectBuffView, self._activityId)
	end

	local isPassFirst = ChopKingController.instance:isPassFirstClg(self._activityId)

	GameUtil.SetActive(self._firstTag, not isPassFirst)
	GameUtil.SetActive(self._firstTipsGo, ChopKingModel.instance:getRoguePassNum(self._activityId) > 0)

	local passStage = ChopKingModel.instance:getRoguePassNum(self._activityId)

	self._txtFirst.text = isPassFirst == true and langPara("%d", passStage) or langPara("%d", passStage + 1)

	local loopStartTime = GameUtil.string2time(self._activityCfg.loopOpenDateTime)

	if loopStartTime > ServerTime.now() then
		local date = GameUtil.time2date(loopStartTime)

		self._txtLoopLock.text = langPara("%d月%d日 %d:%02d 开放", date.month, date.day, date.hour, date.min)
	elseif not isPassFirst then
		self._txtLoopLock.text = lang("通关小试牛刀后解锁")
	end

	GameUtil.SetActive(self._loopClgLockGo, not isPassFirst or loopStartTime > ServerTime.now())

	local circleStartTime = GameUtil.string2time(self._activityCfg.circleOpenDateTime)

	if circleStartTime > ServerTime.now() then
		local date = GameUtil.time2date(circleStartTime)

		self._txtCircleLock.text = langPara("%d月%d日 %d:%02d 开放", date.month, date.day, date.hour, date.min)
	elseif not isPassFirst then
		self._txtCircleLock.text = lang("通关小试牛刀后解锁")
	end

	GameUtil.SetActive(self._circleClgLockGo, not isPassFirst or circleStartTime > ServerTime.now())

	local againstTwoStartTime = GameUtil.string2time(self._activityCfg.tenOpenDateTime)

	if againstTwoStartTime > ServerTime.now() then
		local date = GameUtil.time2date(againstTwoStartTime)

		self._txtAgainstTwoLock.text = langPara("%d月%d日 %d:%02d 开放", date.month, date.day, date.hour, date.min)
	elseif not isPassFirst then
		self._txtAgainstTwoLock.text = lang("通关小试牛刀后解锁")
	end

	GameUtil.SetActive(self._againstTwoLockGo, not isPassFirst or againstTwoStartTime > ServerTime.now())
end

function ChopKingMainView:_refreshCircleClgInfo()
	local score = ChopKingController.instance:getCircleClgScore(self._activityId)

	GameUtil.SetActive(self._circleClgScoreGo, score > 0)

	self._txtCircleClgScore.text = langPara("积分：%d", score)
	self._txtTotalScore.text = langPara("总积分：%d", ChopKingController.instance:getTotalScore(self._activityId))
end

function ChopKingMainView:_refreshLoopClgInfo()
	local score = ChopKingController.instance:getLoopClgScore(self._activityId)

	GameUtil.SetActive(self._loopClgScoreGo, score > 0)

	self._txtLoopClgScore.text = langPara("积分：%d", score)

	GameUtil.SetActive(self._loopClgTagGo, false)

	local maxLoopId, maxStage = ChopKingModel.instance:getLoopClgMaxStage(self._activityId)
	local loopCfg = ChopKingConfig.instance:getLoopClgLoopCfg(self._activityId, maxLoopId)

	GameUtil.SetActive(self._loopClgTagGo, loopCfg and loopCfg.rank)

	self._txtTotalScore.text = langPara("总积分：%d", ChopKingController.instance:getTotalScore(self._activityId))
end

function ChopKingMainView:_refreshAgainstTwoClgInfo()
	local score = ChopKingController.instance:getAgainstTwoScore(self._activityId)

	GameUtil.SetActive(self._againstTwoScoreGo, score > 0)

	self._txtAgainstTwoScore.text = langPara("积分：%d", score)
	self._txtTotalScore.text = langPara("总积分：%d", ChopKingController.instance:getTotalScore(self._activityId))
end

function ChopKingMainView:_setTopGoldBar()
	local btn_list = {}

	table.insert(btn_list, {
		showAdd = false,
		id = self._activityCfg.showBar
	})
	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btn_list, false)
end

function ChopKingMainView:_onClickRogue()
	if ChopKingController.instance:isPassFirstClg(self._activityId) == true then
		FloatWordMgr.instance:show(lang("已通关"))
	else
		ChopKingController.instance:openRogueMissionView(self._activityId)
	end
end

function ChopKingMainView:_onClickBuff()
	if ChopKingController.instance:isPassFirstClg(self._activityId) == true then
		FloatWordMgr.instance:show(lang("已通关"))
	else
		UIStateManager.instance:push(ViewName.ChopKingRogueBuffLookView, self._activityId)
	end
end

function ChopKingMainView:_onClickCircleClg()
	local circleStartTime = GameUtil.string2time(self._activityCfg.circleOpenDateTime)

	if not ChopKingController.instance:isPassFirstClg(self._activityId) == true then
		FloatWordMgr.instance:show(lang("小试牛刀未通关"))
	elseif circleStartTime > ServerTime.now() then
		FloatWordMgr.instance:show(lang("未到开启时间"))
	else
		UIStateManager.instance:push(ViewName.ChopKingCircleView, self._activityId)
	end
end

function ChopKingMainView:_onClickAgainstTwo()
	local againstTwoStartTime = GameUtil.string2time(self._activityCfg.tenOpenDateTime)

	if not ChopKingController.instance:isPassFirstClg(self._activityId) == true then
		FloatWordMgr.instance:show(lang("小试牛刀未通关"))
	elseif againstTwoStartTime > ServerTime.now() then
		FloatWordMgr.instance:show(lang("未到开启时间"))
	else
		UIStateManager.instance:push(ViewName.ChopKingAgainstTwoView, self._activityId)
	end
end

function ChopKingMainView:_onClickLoopClg()
	local loopStartTime = GameUtil.string2time(self._activityCfg.loopOpenDateTime)

	if not ChopKingController.instance:isPassFirstClg(self._activityId) == true then
		FloatWordMgr.instance:show(lang("小试牛刀未通关"))
	elseif loopStartTime > ServerTime.now() then
		FloatWordMgr.instance:show(lang("未到开启时间"))
	else
		UIStateManager.instance:push(ViewName.ChopKingLoopView, self._activityId)
	end
end

function ChopKingMainView:_onClickTip()
	TipsFacade.instance:openRulesView("chop_king_rule")
end

function ChopKingMainView:_onClickRank()
	UIStateManager.instance:push(ViewName.ChopKingRankView, self._activityId)
end

function ChopKingMainView:_onClickTask()
	UIStateManager.instance:push(ViewName.CommonGroupTaskMainView, self._activityId)
end

function ChopKingMainView:_onClickJump()
	GotoMgr.gotoByString(self._activityCfg.jumpTo[1])
end

function ChopKingMainView:_PM_ChopKingFirstClgInfoRes()
	self:_refreshRogueView()
	ChopKingAgent.instance:sendPM_ChopKingCircleClgInfoReq(self._activityId)
	ChopKingAgent.instance:sendPM_ChopKingAgainstTwoClgInfoReq(self._activityId)
	ChopKingAgent.instance:sendPM_ChopKingLoopClgInfoReq(self._activityId)
end

return ChopKingMainView
