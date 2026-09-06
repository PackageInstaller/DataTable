-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/freescuffle/view/FreeScuffleMainView.lua

module("logic.extensions.freescuffle.view.FreeScuffleMainView", package.seeall)

local FreeScuffleMainView = class("FreeScuffleMainView", ViewComponent)

function FreeScuffleMainView:buildUI()
	FreeScuffleMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("openTime/txt")
	self._btnRank = self:getGo("btnCol/btnRank")
	self._btnShop = self:getGo("btnCol/btnShop")
	self._btnBook = self:getGo("btnCol/btnBook")
	self._redBtnBook = self:getGo("btnCol/btnBook/red")
	self._btnTask = self:getGo("btnCol/btnTask")
	self._redBtnTask = self:getGo("btnCol/btnTask/red")
	self._btnWork = self:getGo("btnWork/btn")
	self._txtBtnWork = self:getTxt("btnWork/desc/txt")
	self._redBtnWork = self:getGo("btnWork/btn/red")
	self._btnClg = self:getGo("btnClg/btn")
	self._txtScoreBtnClg = self:getTxt("btnClg/score/txt")
	self._txtDescBtnClg = self:getTxt("btnClg/desc/txt")
	self._redBtnClg = self:getGo("btnClg/btn/red")
	self._btnFormation = self:getGo("btnFormation")
	self._txtBuff = self:getTxt("buff/txt")
end

function FreeScuffleMainView:bindEvents()
	FreeScuffleMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTips, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickBtnRank, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickBtnShop, self)
	GameUtil.addClickHandler(self._btnBook, self._onClickBtnBook, self)
	GameUtil.addClickHandler(self._btnTask, self._onClickBtnTask, self)
	GameUtil.addClickHandler(self._btnWork, self._onClickBtnWork, self)
	GameUtil.addClickHandler(self._btnClg, self._onClickBtnClg, self)
	GameUtil.addClickHandler(self._btnFormation, self._onClickBtnFormation, self)
end

function FreeScuffleMainView:unbindEvents()
	FreeScuffleMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnBook)
	GameUtil.rmClickHandler(self._btnTask)
	GameUtil.rmClickHandler(self._btnWork)
	GameUtil.rmClickHandler(self._btnClg)
	GameUtil.rmClickHandler(self._btnFormation)
end

function FreeScuffleMainView:onEnter()
	FreeScuffleMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = FreeScuffleController.instance:getActivityId()
	end

	FreeScuffleController.instance:enterFreeScuffleRunning(self._activityId, true)

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._subMo = FreeScuffleController.instance:getSubMo(self._activityId)
	self._actData = FreeScuffleConfig.instance:getActData(self._activityId)

	self.addGEvent(self, GlobalNotify.HandlePM_FreeScuffleGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_FreeScuffleBattleInfoRes, self._onUpdate, self)
	self:_onSetUI()
	FreeScuffleController.instance:sendPM_FreeScuffleGetInfoReq(self._activityId)
	FreeScuffleController.instance:sendPM_FreeScuffleTaskInfoReq(self._activityId)
end

function FreeScuffleMainView:onExit()
	FreeScuffleMainView.super.onExit(self)
	FreeScuffleController.instance:enterFreeScuffleRunning(self._activityId, false)
	RedPointController.instance:unregRedPoint(self._redBtnTask)
	RedPointController.instance:unregRedPoint(self._redBtnBook)
	RedPointController.instance:unregRedPoint(self._redBtnWork)
end

function FreeScuffleMainView:_onSetUI()
	self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)

	local buffId = FreeScuffleController.instance:getCurBuffId(self._activityId)
	local buffData = FreeScuffleConfig.instance:getGlobalBuffData(self._activityId, buffId)

	if buffData then
		self._txtBuff.text = buffData.desc or "无"
	end

	local redIdTaskNor = FreeScuffleController.instance:getTaskGroupRedId(self._activityId, FreeScuffleEnum.TaskGroup_Normal)

	RedPointController.instance:regRedPoint(self._redBtnTask, redIdTaskNor)

	local redIdTaskBook = FreeScuffleController.instance:getTaskGroupRedId(self._activityId, FreeScuffleEnum.TaskGroup_Book)

	RedPointController.instance:regRedPoint(self._redBtnBook, redIdTaskBook)

	local redIdTaskDay = FreeScuffleController.instance:getTaskGroupRedId(self._activityId, FreeScuffleEnum.TaskGroup_Day)

	RedPointController.instance:regRedPoint(self._redBtnWork, redIdTaskDay, RedPointModel.ID_FreeScuffle_WorkEvent)
end

function FreeScuffleMainView:_onUpdate()
	self._txtScoreBtnClg.text = string.format("最高分：<color=#FFC75DFF>%s</color>", self._subMo:getScorePk())

	local cur = self._subMo:getTodayBattleTimes()
	local max = self._subMo:getMaxBattleTimes()
	local left = Mathf.Max(max - cur, 0)

	self._txtDescBtnClg.text = left > 0 and string.format("今日剩余次数：%s/%s", left, max) or string.format("今日剩余次数：<color=#20b376>%s</color>/%s", left, max)
end

function FreeScuffleMainView:_onClickBtnTips()
	local key = self._actData.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function FreeScuffleMainView:_onClickBtnRank()
	FreeScuffleController.instance:openCommonTabRankView(self._activityId)
end

function FreeScuffleMainView:_onClickBtnShop()
	local key = self._actData.jumpShop

	GotoMgr.gotoByString(key)
end

function FreeScuffleMainView:_onClickBtnBook()
	UIStateManager.instance:push(ViewName.FreeScuffleBookView, self._activityId)
end

function FreeScuffleMainView:_onClickBtnTask()
	UIStateManager.instance:push(ViewName.FreeScuffleTaskView, self._activityId, FreeScuffleEnum.TaskGroup_Normal)
end

function FreeScuffleMainView:_onClickBtnWork()
	UIStateManager.instance:push(ViewName.FreeScuffleWorkSceneView, self._activityId)
end

function FreeScuffleMainView:_onClickBtnClg()
	local cur = self._subMo:getTodayBattleTimes()
	local max = self._subMo:getMaxBattleTimes()
	local left = Mathf.Max(max - cur, 0)

	if max <= cur then
		FloatWordMgr.instance:show("剩余挑战次数不足")

		return
	end

	if self._subMo:getDefendForm() == nil then
		local tipsContent = "未进行防守阵容设置"

		local function okFunc()
			self:_onClickBtnFormation()
		end

		TipsFacade.instance:openTipWindowNoX("提示", tipsContent, okFunc, "确定", UnityEngine.TextAnchor.MiddleCenter)
	else
		local infos = self._subMo:getBattlePetIdDic()

		if TableUtil.isTableEmpty(infos) then
			FloatWordMgr.instance:show("还未拥有战斗精灵，无法进行匹配")

			return
		end

		local opponent = self._subMo:getOpponent()

		if opponent == nil then
			UIStateManager.instance:push(ViewName.FreeScufflePkMatchView, self._activityId)
		else
			FreeScuffleController.instance:enterPkBattle(self._activityId, opponent)
		end
	end
end

function FreeScuffleMainView:_onClickBtnFormation()
	FreeScuffleController.instance:enterFormation(self._activityId)
end

return FreeScuffleMainView
