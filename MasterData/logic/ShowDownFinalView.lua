-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownFinalView.lua

module("logic.extensions.showdown.view.ShowDownFinalView", package.seeall)

local ShowDownFinalView = class("ShowDownFinalView", ViewComponent)

function ShowDownFinalView:ctor()
	ShowDownFinalView.super.ctor(self)
end

function ShowDownFinalView:buildUI()
	ShowDownFinalView.super.buildUI(self)

	self._btnTask = goutil.findChild(self.mainGO, "btnTask")
	self._redBtnTask = goutil.findChild(self.mainGO, "btnTask/redPoint")
	self._btnShop = goutil.findChild(self.mainGO, "btnShop")
	self._voteBar = goutil.findChild(self.mainGO, "voteBar")
	self._btnVote = goutil.findChild(self.mainGO, "voteBar/btnVote")
	self._btnGotoVote = goutil.findChild(self.mainGO, "voteBar/btnGotoVote")
	self._btnVoteRecord = goutil.findChild(self.mainGO, "voteBar/btnVoteRecord")
	self._btnLeft = goutil.findChild(self.mainGO, "btnLeft")
	self._btnRight = goutil.findChild(self.mainGO, "btnRight")
	self._btnShowPrize = goutil.findChild(self.mainGO, "btnShowPrize")
	self._remainTime = goutil.findChild(self.mainGO, "remainTime")
	self._txtRemainTimeName = goutil.findChildTextComponent(self.mainGO, "remainTime/txtRemainTimeName")
	self._txtRemainTime = goutil.findChildTextComponent(self.mainGO, "remainTime/txtRemainTime")
	self._groupView = goutil.findChild(self.mainGO, "groupCol/groupView")
	self._groupCell = goutil.findChild(self.mainGO, "groupCol/groupCell")
	self._tabScrview = goutil.findChild(self.mainGO, "tabScrview")
	self._tabScrCell = goutil.findChild(self.mainGO, "tabScrCell")
	self._tabScrollList = ScrollerList.create(self._tabScrview, self._tabScrCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))

	self._tabScrollList:setCenterMode(true)
end

function ShowDownFinalView:bindEvents()
	ShowDownFinalView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnTask, self._onClickBtnTask, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickBtnShop, self)
	GameUtil.addClickHandler(self._btnVote, self._onClickBtnVote, self)
	GameUtil.addClickHandler(self._btnGotoVote, self._onClickBtnGotoVote, self)
	GameUtil.addClickHandler(self._btnVoteRecord, self._onClickBtnVoteRecord, self)
	GameUtil.addClickHandler(self._btnShowPrize, self._onClickBtnShowPrize, self)
	GameUtil.addClickHandler(self._btnLeft, GameUtil.handler(self._onClickBtnChangeTab, self, -1), self)
	GameUtil.addClickHandler(self._btnRight, GameUtil.handler(self._onClickBtnChangeTab, self, 1), self)
end

function ShowDownFinalView:unbindEvents()
	ShowDownFinalView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnTask)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnVote)
	GameUtil.rmClickHandler(self._btnGotoVote)
	GameUtil.rmClickHandler(self._btnVoteRecord)
	GameUtil.rmClickHandler(self._btnShowPrize)
	GameUtil.rmClickHandler(self._btnLeft)
	GameUtil.rmClickHandler(self._btnRight)
end

function ShowDownFinalView:onEnter()
	ShowDownFinalView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._activityType = ShowDownController.instance:getActivityType()

	local isInTime = ShowDownController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._actData = ShowDownConfig.instance:getActData(self._activityId)
	self._isNeedVoteInAct = ShowDownController.instance:isNeedGuessInAct(self._activityId)

	self:_onUpdateDataByStep()

	self._tabCount = #ShowDownEnum.FinalRoundIdList
	self._curTabIdx = self._curTabIdx or 1
	self._curGroupId = 1
	self._curTabRoundId = 0
	self._isVoteTime = false

	GameUtil.SetActive(self._remainTime, false)

	local taskRedId = EventTaskSummaryController.instance:getCurRedIdByActivityId(self._activityId)

	if taskRedId > 0 then
		RedPointController.instance:regRedPoint(self._redBtnTask, taskRedId)
	end

	GameUtil.SetActive(self._voteBar, self._isNeedVoteInAct)
	self.addGEvent(self, GlobalNotify.ShowDownStepChange, self._handleShowDownStepChange, self)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDown_GetMainInfoRes, self._onUpdateByGroup, self)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDown_GuessRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDown_GainDailyGuessItemRes, self._onUpdate, self)
	self:_sendMainInfoReq()
	self:_onTicking()
	settimer(1, self._onTicking, self, true)
end

function ShowDownFinalView:onExit()
	ShowDownFinalView.super.onExit(self)
	removetimer(self._onTicking, self)
	self:_onClearTabColUI()
	self:_onClearGroupColUI()
	RedPointController.instance:unregRedPoint(self._redBtnTask)
end

function ShowDownFinalView:_handleShowDownStepChange()
	local curStepId = ShowDownController.instance:getCurStepId(self._activityId)
	local oldStepId = self._curStepId

	if curStepId ~= oldStepId then
		self:_sendMainInfoReq()
	end
end

function ShowDownFinalView:_sendMainInfoReq()
	local curStepId = ShowDownController.instance:getCurStepId(self._activityId)
	local curRoundId = ShowDownController.instance:getRoundIdByStep(self._activityId, curStepId)

	if curRoundId >= ShowDownEnum.Round_Final_01 and curRoundId < ShowDownEnum.Round_Final_Result then
		ShowDownController.instance:sendPM_ShowDown_GetMainInfoReq(self._activityId, -1)
	end
end

function ShowDownFinalView:_onUpdateByGroup(groupId)
	self._curTabIdx = checknumber(groupId)

	self:_onUpdate()
end

function ShowDownFinalView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function ShowDownFinalView:_onUpdateData()
	self:_onUpdateDataByStep()

	self._curTabIdx = self._curTabIdx or 1

	for tabIdx, roundId in ipairs(ShowDownEnum.FinalRoundIdList) do
		if self._curRoundId == roundId then
			self._curTabIdx = tabIdx

			break
		end
	end

	local scheduleInfo = ShowDownController.instance:getScheduleInfoInFinal(self._activityId)

	self._myTeamId = scheduleInfo:getMyTeamOfTeamId()

	self:_updateCurTabIdx(self._curTabIdx)
end

function ShowDownFinalView:_onUpdateUI()
	local isFighter = ShowDownController.instance:isFighter(self._activityId, self._curRoundId)
	local isCanGuess = ShowDownController.instance:isCanGuessInStep(self._activityId, self._curStepId)

	if self._curRoundId == ShowDownEnum.Round_Final_Result then
		GameUtil.SetActive(self._remainTime, false)
		removetimer(self._onTicking, self)
	else
		GameUtil.SetActive(self._remainTime, true)

		if not isFighter and isCanGuess then
			self._txtRemainTimeName.text = "剩余应援时间："
			self._isVoteTime = true
		else
			local tipsStr = ShowDownController.instance:getShowTipsInStep(self._activityId, self._curStepId)

			self._txtRemainTimeName.text = tipsStr .. "："
			self._isVoteTime = false
		end

		self:_onTicking()
		settimer(1, self._onTicking, self, true)
	end

	GameUtil.SetActive(self._btnLeft, self._curTabIdx > 1)
	GameUtil.SetActive(self._btnRight, self._curTabIdx < self._tabCount)

	local isGainDailyGuessItem = ShowDownController.instance:isGainDailyGuessItem(self._activityId)
	local roundData = ShowDownConfig.instance:getRoundData(self._activityId, self._curRoundId)

	if roundData then
		if not roundData.dailyGuessItemCount then
			local dailyGuessItemCount = 0

			GameUtil.SetActive(self._btnVote, not isGainDailyGuessItem and dailyGuessItemCount > 0)
			self:_onUpdateTabColUI()
			self:_onUpdateGroupColUI()
		end
	end
end

function ShowDownFinalView:_onUpdateDataByStep()
	self._curStepId = ShowDownController.instance:getCurStepId(self._activityId)
	self._curRoundId = ShowDownController.instance:getRoundIdByStep(self._activityId, self._curStepId)
end

function ShowDownFinalView:_onTicking()
	self._txtRemainTime.text = GameUtil.FormatTimeSymbol(self._isVoteTime and ShowDownController.instance:getLeftTimeStampToNextInVote(self._activityId, self._curStepId) or ShowDownController.instance:getLeftTimeStampToNext(self._activityId, self._curStepId))
end

function ShowDownFinalView:_onUpdateTabColUI()
	self._tabScrollList:reloadData(ShowDownEnum.FinalRoundIdList)

	if self._curTabIdx > 0 then
		local idx = self._curTabIdx - 1

		self._tabScrollList:MoveCellInView(idx, true)
	end
end

function ShowDownFinalView:_onClearTabColUI()
	self._tabScrollList:dispose()
end

function ShowDownFinalView:_updateTabCell(view, cell, roundId, tag)
	local tabIdx = cell.data
	local isSelected = self._curTabIdx == tabIdx
	local mainGo = cell.gameObject
	local imgSelected = goutil.findChild(mainGo, "imgSelected")

	GameUtil.SetActive(imgSelected, isSelected)
	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._clickTabCell, self, tabIdx))
end

function ShowDownFinalView:_clearTabCell(cell)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)
end

function ShowDownFinalView:_clickTabCell(tabIdx)
	if self._curTabIdx == tabIdx then
		return
	else
		self:_updateCurTabIdx(tabIdx)
	end

	self:_onUpdateUI()
end

function ShowDownFinalView:_updateCurTabIdx(tabIdx)
	self._curTabIdx = tabIdx
	self._curTabRoundId = checknumber(ShowDownEnum.FinalRoundIdList[self._curTabIdx])
	self._curTabStepIdOfFmt = 0
	self._curTabStepIdOfShow = 0

	local stepIdList = {}
	local stepCfg = ShowDownConfig.instance:getStepCfg(self._activityId)

	for _, stepData in ipairs(stepCfg) do
		if stepData.roundId == self._curTabRoundId then
			table.insert(stepIdList, stepData.stepId)
		end
	end

	for i, stepId in ipairs(stepIdList) do
		local formPeriod = ShowDownController.instance:getFormPeriodInStep(self._activityId, stepId)

		if formPeriod ~= ShowDownEnum.FormPeriod_None then
			self._curTabStepIdOfFmt = stepId
		end

		if ShowDownController.instance:isShowResultInStep(self._activityId, stepId) then
			self._curTabStepIdOfShow = stepId
		end
	end
end

function ShowDownFinalView:_onUpdateGroupColUI()
	local mainRaceInfo = ShowDownController.instance:getMainRaceInfoMoInFinal(self._activityId, self._curTabRoundId)
	local list = mainRaceInfo:getPairTeamIdListInGroup(self._curGroupId)

	GameUtil.updateCellsList(self._groupView, self._groupCell, list, self._updateGroupCell, self)
	self._groupView:GetComponent(ComponentType.TestRecordPos):LoadPlan(0)
end

function ShowDownFinalView:_onClearGroupColUI()
	GameUtil.clearCells(self._groupView, self._clearGroupCell, self)
end

function ShowDownFinalView:_updateGroupCell(mainGo, pairTeamId, teamIndex)
	local teamIdLeft = pairTeamId[1]
	local teamIdRight = pairTeamId[2]
	local roundId = self._curTabRoundId
	local mainRaceInfo = ShowDownController.instance:getMainRaceInfoMoInFinal(self._activityId, roundId)
	local isShowResult = self._curStepId >= self._curTabStepIdOfShow
	local btnDetail = goutil.findChild(mainGo, "btnDetail")
	local leftTeam = goutil.findChild(mainGo, "leftTeam")
	local rightTeam = goutil.findChild(mainGo, "rightTeam")
	local teamGos = {
		leftTeam,
		rightTeam
	}

	GameUtil.SetActive(btnDetail, isShowResult)
	GameUtil.addClickHandler(btnDetail, function()
		if self._curTabStepIdOfFmt > 0 then
			UIStateManager.instance:push(ViewName.ShowDownBattleResutlView, self._activityId, self._curTabStepIdOfFmt, teamIdLeft, teamIdRight, true)
		end
	end)

	for idx, teamId in ipairs(pairTeamId) do
		local teamSimpleViewMo = mainRaceInfo:getTeamSimpleViewMo(self._curGroupId, teamId)
		local isWin = mainRaceInfo:isWin(self._curGroupId, teamId)
		local teamInfoViewMo = teamSimpleViewMo:getTeamInfoViewMo()
		local teamName = teamInfoViewMo:getTeamName()
		local teamIconId = teamInfoViewMo:getTeamLogo()
		local heatValue = teamSimpleViewMo:getHeatValue()
		local leaderHeadInfo = teamSimpleViewMo:getLeaderHeadInfo()
		local isMyTeam = self._myTeamId == teamId
		local go = teamGos[idx]
		local txtName = goutil.findChildTextComponent(go, "name/txt")
		local teamIcon = goutil.findChild(go, "teamIcon")
		local heat = goutil.findChild(go, "heat")
		local txtHeat = goutil.findChildTextComponent(go, "heat/txt")
		local heatIcon = goutil.findChild(go, "heat/icon")
		local imgWin = goutil.findChild(go, "imgWin")
		local imgFail = goutil.findChild(go, "imgFail")
		local tagOfMe = goutil.findChild(go, "tagOfMe")

		txtName.text = teamName
		txtHeat.text = heatValue

		GameUtil.SetActive(tagOfMe, isMyTeam)

		if not isShowResult then
			GameUtil.SetActive(imgWin, false)
			GameUtil.SetActive(imgFail, false)
		else
			GameUtil.SetActive(imgWin, isWin)
			GameUtil.SetActive(imgFail, not isWin)
		end

		ShowDownController.instance:setTeamHeadCellRoot(teamIcon, leaderHeadInfo, self._activityId, teamIconId, function()
			ShowDownController.instance:opTeamDetailView(self._activityId, roundId, teamId, teamName)
		end)

		if heatIcon then
			local heatIconPath = ShowDownConfig.instance:getCommonValue(self._activityId, "heatIconPath")
			local spriteName = string.format("%s.png", heatIconPath)

			uGuiUtil.setSpriteToImage(heatIcon, uGuiUtil.SpriteType.BigBg, spriteName)
		end

		GameUtil.SetActive(heat, self._isNeedVoteInAct)
	end
end

function ShowDownFinalView:_clearGroupCell(cell)
	local mainGo = cell.gameObject
	local btnDetail = goutil.findChild(mainGo, "btnDetail")
	local leftTeam = goutil.findChild(mainGo, "leftTeam")
	local rightTeam = goutil.findChild(mainGo, "rightTeam")
	local teamGos = {
		leftTeam,
		rightTeam
	}

	GameUtil.rmClickHandler(btnDetail)

	for k, go in pairs(teamGos) do
		local teamIcon = goutil.findChild(go, "teamIcon")
		local heatIcon = goutil.findChild(go, "heat/icon")

		ShowDownController.instance:clearTeamHeadCellRoot(teamIcon)
		uGuiUtil.clearImage(heatIcon)
	end
end

function ShowDownFinalView:_onClickBtnTask()
	ShowDownController.instance:opTaskView(self._activityId)
end

function ShowDownFinalView:_onClickBtnShop()
	local value = ShowDownConfig.instance:getCommonValue(self._activityId, "jumpStrShop")

	GotoMgr.gotoByString(value)
end

function ShowDownFinalView:_onClickBtnVote()
	UIStateManager.instance:push(ViewName.ShowDownEliminateVoteGoldGainPopView, self._activityId, self._curRoundId)
end

function ShowDownFinalView:_onClickBtnVoteRecord()
	UIStateManager.instance:push(ViewName.ShowDownEliminateVoteRecordView, self._activityId)
end

function ShowDownFinalView:_onClickBtnGotoVote()
	UIStateManager.instance:push(ViewName.ShowDownFinalGuessView, self._activityId)
end

function ShowDownFinalView:_onClickBtnShowPrize()
	UIStateManager.instance:push(ViewName.ShowDownRewardView, self._activityId)
end

function ShowDownFinalView:_onClickBtnChangeTab(delta)
	local tabIdx = Mathf.Clamp(self._curTabIdx + delta, 1, self._tabCount)

	self:_updateCurTabIdx(tabIdx)
	self:_onUpdateUI()
end

return ShowDownFinalView
