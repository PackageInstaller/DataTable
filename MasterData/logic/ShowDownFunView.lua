-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownFunView.lua

module("logic.extensions.showdown.view.ShowDownFunView", package.seeall)

local ShowDownFunView = class("ShowDownFunView", ViewComponent)

function ShowDownFunView:ctor()
	ShowDownFunView.super.ctor(self)
end

function ShowDownFunView:buildUI()
	ShowDownFunView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._btnRank = goutil.findChild(self.mainGO, "btnRank")
	self._btnTask = goutil.findChild(self.mainGO, "btnTask")
	self._redBtnTask = goutil.findChild(self.mainGO, "btnTask/redPoint")
	self._btnShop = goutil.findChild(self.mainGO, "btnShop")
	self._btnFmt = goutil.findChild(self.mainGO, "btnFmt")
	self._btnMatch = goutil.findChild(self.mainGO, "btnMatch")
	self._txtLeftTimes = goutil.findChildTextComponent(self.mainGO, "leftTimes/txt")
	self._qualifyTime = goutil.findChild(self.mainGO, "qualifyTime")
	self._txtQualifyTime = goutil.findChildTextComponent(self.mainGO, "qualifyTime/txt")
	self._txtScoreInRank = goutil.findChildTextComponent(self.mainGO, "rankCol/txtScore")
	self._txtRankInRank = goutil.findChildTextComponent(self.mainGO, "rankCol/txtRank")
	self._btnRecord = goutil.findChild(self.mainGO, "rankCol/btnRecord")
end

function ShowDownFunView:bindEvents()
	ShowDownFunView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnRank, self._onClickBtnRank, self)
	GameUtil.addClickHandler(self._btnTask, self._onClickBtnTask, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickBtnShop, self)
	GameUtil.addClickHandler(self._btnFmt, self._onClickBtnFmt, self)
	GameUtil.addClickHandler(self._btnMatch, self._onClickBtnMatch, self)
	GameUtil.addClickHandler(self._btnRecord, self._onClickBtnRecord, self)
end

function ShowDownFunView:unbindEvents()
	ShowDownFunView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnTask)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnFmt)
	GameUtil.rmClickHandler(self._btnMatch)
	GameUtil.rmClickHandler(self._btnRecord)
end

function ShowDownFunView:onEnter()
	ShowDownFunView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._activityType = ShowDownController.instance:getActivityType()

	local isInTime = ShowDownController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._qualType = ShowDownEnum.QualType_Fun
	self._actData = ShowDownConfig.instance:getActData(self._activityId)
	self._curRoundId = ShowDownEnum.Round_Func
	self._showDownMo = ShowDownController.instance:getShowDownMo(self._activityId)

	self:_onSetUI()
	self.addGEvent(self, GlobalNotify.ShowDownStepChange, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDownQualify_StartMatchingRes, self._handlePM_ShowDownQualify_StartMatchingRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDown_GetJoyModeInfoRes, self._onUpdate, self)
	ShowDownAgent.instance:sendPM_ShowDown_GetJoyModeInfoReq(self._activityId)
end

function ShowDownFunView:onExit()
	ShowDownFunView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._redBtnTask)
end

function ShowDownFunView:_handlePM_ShowDownQualify_StartMatchingRes(status)
	if status == 0 then
		UIStateManager.instance:push(ViewName.ShowDownQualifyMatchView, self._activityId, self._qualType)
	else
		FloatWordMgr.instance:show("无法进行匹配")
	end
end

function ShowDownFunView:_onSetUI()
	if self._txtQualifyTime then
		local startTime, endTime = ShowDownController.instance:getMatchTimeInQualify(self._activityId, self._qualType)

		if not string.nilorempty(startTime) and not string.nilorempty(endTime) then
			local startT, endT = GameUtil.string2date(startTime), GameUtil.string2date(endTime)

			self._txtQualifyTime.text = string.format("可匹配时间：<color=#ffd89d>%02d时%02d分-%02d时%02d分</color>", startT.hour, startT.min, endT.hour, endT.min)

			GameUtil.SetActive(self._qualifyTime, true)
		else
			GameUtil.SetActive(self._qualifyTime, false)
		end
	end

	local taskRedId = EventTaskSummaryController.instance:getCurRedIdByActivityId(self._activityId)

	if taskRedId > 0 then
		RedPointController.instance:regRedPoint(self._redBtnTask, taskRedId)
	end
end

function ShowDownFunView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function ShowDownFunView:_onUpdateData()
	return
end

function ShowDownFunView:_onUpdateUI()
	local left = ShowDownController.instance:getLeftChallengeTimesInQualify(self._activityId, self._qualType)
	local max = ShowDownController.instance:getMaxChallengeTimesInQualify(self._activityId, self._qualType)

	self._txtLeftTimes.text = left <= 0 and string.format("<color=#ffa251>%s</color>/%s", left, max) or string.format("%s/%s", left, max)

	local score = self._showDownMo:getMyScoreInFunc()
	local rank = self._showDownMo:getMyRankInFunc()

	self._txtScoreInRank.text = Mathf.Max(score, 0)
	self._txtRankInRank.text = rank <= 0 and "暂无" or rank

	local stepId = ShowDownController.instance:getCurStepId(self._activityId)
	local roundId = ShowDownController.instance:getRoundIdByStep(self._activityId, stepId)
	local cond1 = roundId ~= ShowDownEnum.Round_Qualify
	local cond2 = ShowDownController.instance:isMatchTimeInQualify(self._activityId, self._qualType)

	GameUtil.SetGray(self._btnMatch, not cond1 or not cond2)
end

function ShowDownFunView:_onClickBtnRank()
	ShowDownController.instance:opShowDownRank(self._activityId, self._qualType)
end

function ShowDownFunView:_onClickBtnShop()
	local value = ShowDownConfig.instance:getCommonValue(self._activityId, "jumpStrShop")

	GotoMgr.gotoByString(value)
end

function ShowDownFunView:_onClickBtnTask()
	ShowDownController.instance:opTaskView(self._activityId)
end

function ShowDownFunView:_onClickBtnFmt()
	local stepId = ShowDownController.instance:getCurStepId(self._activityId)
	local roundId = ShowDownController.instance:getRoundIdByStep(self._activityId, stepId)

	if roundId == ShowDownEnum.Round_Qualify then
		FloatWordMgr.instance:show("预选赛期间娱乐赛不开放")

		return
	end

	if not ShowDownController.instance:isMatchTimeInQualify(self._activityId, self._qualType) then
		local startTime, endTime = ShowDownController.instance:getMatchTimeInQualify(self._activityId, self._qualType)

		if not string.nilorempty(startTime) and not string.nilorempty(endTime) then
			local startT, endT = GameUtil.string2date(startTime), GameUtil.string2date(endTime)

			FloatWordMgr.instance:show(string.format("娱乐赛每日匹配时间段为%02d时%02d分-%02d时%02d分", startT.hour, startT.min, endT.hour, endT.min))
		end

		return
	end

	ShowDownController.instance:enterShowDownPetShopAndFmt(self._activityId, self._curRoundId, 0)
end

function ShowDownFunView:_onClickBtnMatch()
	local stepId = ShowDownController.instance:getCurStepId(self._activityId)
	local roundId = ShowDownController.instance:getRoundIdByStep(self._activityId, stepId)

	if roundId == ShowDownEnum.Round_Qualify then
		FloatWordMgr.instance:show("预选赛期间娱乐赛不开放")

		return
	end

	if not ShowDownController.instance:isMatchTimeInQualify(self._activityId, self._qualType) then
		local startTime, endTime = ShowDownController.instance:getMatchTimeInQualify(self._activityId, self._qualType)

		if not string.nilorempty(startTime) and not string.nilorempty(endTime) then
			local startT, endT = GameUtil.string2date(startTime), GameUtil.string2date(endTime)

			FloatWordMgr.instance:show(string.format("娱乐赛每日匹配时间段为%02d时%02d分-%02d时%02d分", startT.hour, startT.min, endT.hour, endT.min))
		end

		return
	end

	local isHasConfirm = ShowDownController.instance:isHasConfirmInPetShop(self._activityId, self._curRoundId)

	if not isHasConfirm then
		FloatWordMgr.instance:show("请确认上阵精灵")
		ShowDownController.instance:enterShowDownPetShopAndFmt(self._activityId, self._curRoundId, 0)

		return
	end

	local isEmptyForm = ShowDownController.instance:isEmptyFormInPetShop(self._activityId, self._curRoundId, 0)

	if isEmptyForm then
		FloatWordMgr.instance:show("请调整空阵")
		ShowDownController.instance:enterShowDownPetShopAndFmt(self._activityId, self._curRoundId, 0)

		return
	end

	if isEmptyForm then
		FloatWordMgr.instance:show("无法使用空阵进行挑战")

		return
	end

	ShowDownController.instance:sendPM_ShowDownQualify_StartMatchingReq(self._activityId, self._qualType)
end

function ShowDownFunView:_onClickBtnRecord()
	UIStateManager.instance:push(ViewName.ShowDownFuncBattleResultView, self._activityId)
end

return ShowDownFunView
