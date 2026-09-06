-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownEliminateView.lua

module("logic.extensions.showdown.view.ShowDownEliminateView", package.seeall)

local ShowDownEliminateView = class("ShowDownEliminateView", ViewComponent)

function ShowDownEliminateView:ctor()
	ShowDownEliminateView.super.ctor(self)
end

function ShowDownEliminateView:buildUI()
	ShowDownEliminateView.super.buildUI(self)

	self._remainTime = goutil.findChild(self.mainGO, "remainTime")
	self._txtRemainTimeName = goutil.findChildTextComponent(self.mainGO, "remainTime/txtRemainTimeName")
	self._txtRemainTime = goutil.findChildTextComponent(self.mainGO, "remainTime/txtRemainTime")
	self._btnChooseGroup = goutil.findChild(self.mainGO, "btnChooseGroup")
	self._txtBtnChooseGroup = goutil.findChildTextComponent(self.mainGO, "btnChooseGroup/txt")
	self._btnSearch = goutil.findChild(self.mainGO, "btnSearch")
	self._btnRecruitInfo = goutil.findChild(self.mainGO, "btnRecruitInfo")
	self._btnTask = goutil.findChild(self.mainGO, "btnTask")
	self._redBtnTask = goutil.findChild(self.mainGO, "btnTask/redPoint")
	self._btnShop = goutil.findChild(self.mainGO, "btnShop")
	self._voteBar = goutil.findChild(self.mainGO, "voteBar")
	self._btnVote = goutil.findChild(self.mainGO, "voteBar/btnVote")
	self._btnVoteRecord = goutil.findChild(self.mainGO, "voteBar/btnVoteRecord")
	self._voteTips = goutil.findChild(self.mainGO, "voteTips")
	self._voteTipsHeatIcon = goutil.findChild(self.mainGO, "voteTips/heatIcon")
	self._txtVoteTips = goutil.findChildTextComponent(self.mainGO, "voteTips/txt")
	self._teamView = goutil.findChild(self.mainGO, "teamCol/teamView")
	self._teamCell = goutil.findChild(self.mainGO, "teamCol/teamCell")
	self._groupCol = goutil.findChild(self.mainGO, "groupCol")
	self._groupScrView = goutil.findChild(self.mainGO, "groupCol/scrView")
	self._groupScrCell = goutil.findChild(self.mainGO, "groupCol/scrCell")
	self._groupScrollList = ScrollerList.create(self._groupScrView, self._groupScrCell, GameUtil.handler(self._updateGroupCell, self), GameUtil.handler(self._clearGroupCell, self))

	GameUtil.SetActive(self._groupScrView, false)

	self._customInputOfGroup = UICustomInput.Get(self._groupScrView)
end

function ShowDownEliminateView:bindEvents()
	ShowDownEliminateView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnChooseGroup, self._onClickBtnChooseGroup, self)
	GameUtil.addClickHandler(self._btnSearch, self._onClickBtnSearch, self)
	GameUtil.addClickHandler(self._btnRecruitInfo, self._onClickBtnRecruitInfo, self)
	GameUtil.addClickHandler(self._btnTask, self._onClickBtnTask, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickBtnShop, self)
	GameUtil.addClickHandler(self._btnVote, self._onClickBtnVote, self)
	GameUtil.addClickHandler(self._btnVoteRecord, self._onClickBtnVoteRecord, self)
	self._customInputOfGroup:AddListener(self._onCustomInputCallbackOfGroup, self)
end

function ShowDownEliminateView:unbindEvents()
	ShowDownEliminateView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnChooseGroup)
	GameUtil.rmClickHandler(self._btnSearch)
	GameUtil.rmClickHandler(self._btnRecruitInfo)
	GameUtil.rmClickHandler(self._btnTask)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnVote)
	GameUtil.rmClickHandler(self._btnVoteRecord)
	self._customInputOfGroup:RemoveListener()
end

function ShowDownEliminateView:onEnter()
	ShowDownEliminateView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._activityType = ShowDownController.instance:getActivityType()

	local isInTime = ShowDownController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._actData = ShowDownConfig.instance:getActData(self._activityId)

	self:_onUpdateDataOfStep()

	self._teamCountEachGroup = ShowDownController.instance:getTeamCountEachGroupInEliminate()
	self._mainRaceInfo = ShowDownController.instance:getMainRaceInfoMo(self._activityId, self._curStepId)
	self._curGroupId = -1
	self._showTeamId = 0
	self._joinTeamId = -1
	self._teamIdListInGroup = {}
	self._teamShowInfoDic = {}
	self._isVoteTime = false
	self._isNeedVoteInAct = ShowDownController.instance:isNeedGuessInAct(self._activityId)

	GameUtil.SetActive(self._remainTime, false)

	local taskRedId = EventTaskSummaryController.instance:getCurRedIdByActivityId(self._activityId)

	if taskRedId > 0 then
		RedPointController.instance:regRedPoint(self._redBtnTask, taskRedId)
	end

	GameUtil.SetActive(self._voteBar, self._isNeedVoteInAct)
	self.addGEvent(self, GlobalNotify.ShowDownStepChange, self._handleShowDownStepChange, self)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDown_GetTeamMainInfoRes, self._onUpdateByGroup, self)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDown_GetMainInfoRes, self._onUpdateByGroup, self)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDown_GetScheduleInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDownTeam_JoinRes, self._handlePM_ShowDownTeam_JoinRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDown_NotifyJoinTeamRes, self._handlePM_ShowDown_NotifyJoinTeamRes, self)
	self.addGEvent(self, GlobalNotify.ShowDownEliminateJumpGroup, self._showDownEliminateJumpGroup, self)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDown_GetGuessRecordRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDown_GuessRes, self._handlePM_ShowDownGuessRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDown_GainDailyGuessItemRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDownTeam_SetMyTeamInfoRes, self._handlePM_ShowDownTeam_SetMyTeamInfoRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDown_NotifyMyTeamDataChange, self._handlePM_ShowDown_NotifyMyTeamDataChangeRes, self)
	ShowDownController.instance:sendPM_ShowDown_GetGuessRecordReq(self._activityId)
	self:_sendMainInfoReq(self._curGroupId)
	self:_onTicking()
	settimer(1, self._onTicking, self)
end

function ShowDownEliminateView:onExit()
	ShowDownEliminateView.super.onExit(self)
	removetimer(self._onTicking, self)
	self:_onClearTeamColUI()
	self:_onClearGroupColUI()
	self:_clearAllFlashEff()
	uGuiUtil.clearImage(self._voteTipsHeatIcon)
	RedPointController.instance:unregRedPoint(self._redBtnTask)
end

function ShowDownEliminateView:_sendMainInfoReq(groupId)
	local curStepId = ShowDownController.instance:getCurStepId(self._activityId)
	local curRoundId = ShowDownController.instance:getRoundIdByStep(self._activityId, curStepId)
	local racePeriod = ShowDownController.instance:getRacePeriodByStep(self._activityId, curRoundId)

	if racePeriod == ShowDownEnum.RacePeriod_Eliminate then
		if self._curRoundId == ShowDownEnum.Round_Eliminate_Group then
			ShowDownController.instance:sendPM_ShowDown_GetTeamMainInfoReq(self._activityId, groupId)
		else
			ShowDownController.instance:sendPM_ShowDown_GetMainInfoReq(self._activityId, groupId)
		end
	end
end

function ShowDownEliminateView:_handleShowDownStepChange()
	local curStepId = ShowDownController.instance:getCurStepId(self._activityId)
	local oldStepId = self._curStepId

	if curStepId ~= oldStepId then
		self:_sendMainInfoReq(self._curGroupId)
	end
end

function ShowDownEliminateView:_handlePM_ShowDownTeam_JoinRes(status, msg)
	if status == 0 then
		FloatWordMgr.instance:show("发送申请成功")
	end
end

function ShowDownEliminateView:_handlePM_ShowDown_NotifyJoinTeamRes(msg)
	if msg then
		self._joinTeamId = msg.teamId or -1
	end

	self:_sendMainInfoReq(-1)
end

function ShowDownEliminateView:_handlePM_ShowDownTeam_SetMyTeamInfoRes()
	self:_sendMainInfoReq(self._curGroupId)
end

function ShowDownEliminateView:_handlePM_ShowDownGuessRes()
	self:_sendMainInfoReq(self._curGroupId)
	ShowDownController.instance:sendPM_ShowDown_GetGuessRecordReq(self._activityId)
end

function ShowDownEliminateView:_handlePM_ShowDown_NotifyMyTeamDataChangeRes()
	self:_sendMainInfoReq(-1)
end

function ShowDownEliminateView:_showDownEliminateJumpGroup(groupId)
	groupId = checknumber(groupId)
	groupId = Mathf.Clamp(groupId, 1, self._groupCount)

	self:_sendMainInfoReq(groupId)
end

function ShowDownEliminateView:_onUpdateByGroup(groupId)
	groupId = checknumber(groupId)
	self._curGroupId = Mathf.Clamp(groupId, 1, self._groupCount)

	self:_onUpdate()
end

function ShowDownEliminateView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function ShowDownEliminateView:_onUpdateData()
	self:_onUpdateDataOfStep()

	self._teamIdListInGroup = self._mainRaceInfo:getTeamIdListInGroup(self._curGroupId)
	self._teamShowInfoDic = {}

	local teamSimpleViewMoList = self._mainRaceInfo:getTeamSimpleViewMoList(self._curGroupId)

	for teamIndex, teamSimpleViewMo in ipairs(teamSimpleViewMoList) do
		local teamInfoViewMo = teamSimpleViewMo:getTeamInfoViewMo()
		local info = {}

		info.teamInfoViewMo = teamInfoViewMo
		info.teamSimpleViewMo = teamSimpleViewMo
		info.teamIconId = teamInfoViewMo:getTeamLogo()
		info.teamId = teamInfoViewMo:getTeamId()
		info.teamName = teamInfoViewMo:getTeamName()
		info.heatValue = teamSimpleViewMo:getHeatValue()
		info.curMemberCount = teamSimpleViewMo:getMemberCount()
		info.leaderHeadInfo = teamSimpleViewMo:getLeaderHeadInfo()
		info.isWinTeam = self._mainRaceInfo:isWinTeam(self._curGroupId, teamInfoViewMo:getTeamId())
		info.maxMemberCount = ShowDownController.instance:getTeamMemberCount(self._activityId)
		info.isMyTeam = info.teamId == self._myTeamId
		info.isFull = info.curMemberCount >= info.maxMemberCount
		self._teamShowInfoDic[info.teamId] = info
	end
end

function ShowDownEliminateView:_onUpdateDataOfStep()
	self._curStepId = ShowDownController.instance:getCurStepId(self._activityId)
	self._curRoundId = ShowDownController.instance:getRoundIdByStep(self._activityId, self._curStepId)
	self._groupCount = ShowDownController.instance:getGroupCountInShowDown(self._curRoundId)
	self._mainRaceInfo = ShowDownController.instance:getMainRaceInfoMo(self._activityId, self._curStepId)
	self._myTeamId = ShowDownController.instance:getMyTeamId(self._activityId, self._curRoundId)
	self._myGourpId = self._mainRaceInfo:getMyGroupId()
end

function ShowDownEliminateView:_onUpdateUI()
	local isLeader = self._mainRaceInfo:isLeader()
	local isInGroupRound = self._curRoundId == ShowDownEnum.Round_Eliminate_Group
	local isFighter = ShowDownController.instance:isFighter(self._activityId, self._curRoundId)
	local isCanGuess = ShowDownController.instance:isCanGuessInStep(self._activityId, self._curStepId)
	local isHasApply = self._mainRaceInfo:isHasApply()
	local myTeamId = ShowDownController.instance:getMyTeamId(self._activityId, self._curRoundId)

	GameUtil.SetActive(self._btnRecruitInfo, false)

	if isInGroupRound then
		if isLeader then
			GameUtil.SetActive(self._btnRecruitInfo, isHasApply)
		elseif isFighter and myTeamId <= 0 then
			GameUtil.SetActive(self._btnRecruitInfo, true)
		end
	end

	if isInGroupRound and isLeader then
		local key = string.format("Show_Down_Need_Open_Create_Team_%s", self._activityId)

		local function firstCallback()
			local myTeamId = ShowDownController.instance:getMyTeamId(self._activityId, self._curRoundId)

			UIStateManager.instance:push(ViewName.ShowDownEliminateCreateView, self._activityId, myTeamId)
		end

		GameUtil.doCallbackWhenFirst(key, firstCallback, nil)
	end

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

	local isGainDailyGuessItem = ShowDownController.instance:isGainDailyGuessItem(self._activityId)
	local roundData = ShowDownConfig.instance:getRoundData(self._activityId, self._curRoundId)

	if roundData then
		if not roundData.dailyGuessItemCount then
			local dailyGuessItemCount = 0

			GameUtil.SetActive(self._btnVote, not isGainDailyGuessItem and dailyGuessItemCount > 0)

			if self._isNeedVoteInAct then
				local heatIconPath = ShowDownConfig.instance:getCommonValue(self._activityId, "heatIconPath")
				local spriteName = string.format("%s.png", heatIconPath)

				uGuiUtil.setSpriteToImage(self._voteTipsHeatIcon, uGuiUtil.SpriteType.BigBg, spriteName)

				local curTeam = ShowDownController.instance:getShowDownMo(self._activityId):getGuessCountByGroupId(self._curRoundId, self._curGroupId)
				local maxTeam = ShowDownConfig.instance:getSameGroupLimitInGuess(self._activityId, self._curRoundId)
				local leftTeam = Mathf.Max(maxTeam - curTeam, 0)

				self._txtVoteTips.text = leftTeam > 0 and string.format("该组可应援战队数量：<color=#60EE85FF>%s</color>/%s", leftTeam, maxTeam) or string.format("该组可应援战队数量：%s/%s", leftTeam, maxTeam)
			else
				uGuiUtil.clearImage(self._voteTipsHeatIcon)

				self._txtVoteTips.text = ""
			end

			GameUtil.SetActive(self._voteTips, self._isNeedVoteInAct)
			self:_onUpdateGroupColUI()
			self:_onUpdateTeamColUI()
		end
	end
end

function ShowDownEliminateView:_onTicking()
	self._txtRemainTime.text = GameUtil.FormatTimeSymbol(self._isVoteTime and ShowDownController.instance:getLeftTimeStampToNextInVote(self._activityId, self._curStepId) or ShowDownController.instance:getLeftTimeStampToNext(self._activityId, self._curStepId))
end

function ShowDownEliminateView:_onUpdateTeamColUI()
	GameUtil.updateCellsList(self._teamView, self._teamCell, self._teamIdListInGroup, self._updateTeamCell, self)
	self._teamView:GetComponent(ComponentType.TestRecordPos):LoadPlan(0)
end

function ShowDownEliminateView:_onClearTeamColUI()
	GameUtil.clearCells(self._teamView, self._clearTeamCell, self)
end

function ShowDownEliminateView:_updateTeamCell(mainGo, teamId, teamIndex)
	local showDownMo = ShowDownController.instance:getShowDownMo(self._activityId)
	local teamShowInfo = self._teamShowInfoDic[teamId]
	local teamIconId = teamShowInfo.teamIconId
	local teamId = teamShowInfo.teamId
	local teamName = teamShowInfo.teamName
	local heatValue = teamShowInfo.heatValue
	local curMemberCount = teamShowInfo.curMemberCount
	local leaderHeadInfo = teamShowInfo.leaderHeadInfo
	local maxMemberCount = teamShowInfo.maxMemberCount
	local isWinTeam = teamShowInfo.isWinTeam
	local isMyTeam = teamShowInfo.isMyTeam
	local isFull = teamShowInfo.isFull
	local guessValue = showDownMo:getGuessValue(self._curRoundId, teamId)
	local isShowResult = ShowDownController.instance:isShowResultInStep(self._activityId, self._curStepId)
	local headRoot = goutil.findChild(mainGo, "headRoot")
	local teamIcon = goutil.findChild(mainGo, "teamIcon")
	local tagOfFull = goutil.findChild(mainGo, "tagOfFull")
	local tagOfWin = goutil.findChild(mainGo, "tagOfWin")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local heat = goutil.findChild(mainGo, "heat")
	local txtHeat = goutil.findChildTextComponent(mainGo, "heat/txtHeat")
	local heatIcon = goutil.findChild(mainGo, "heat/heatIcon")
	local txtCount = goutil.findChildTextComponent(mainGo, "txtCount")
	local changeKudo = goutil.findChildComponent(mainGo, "btnKudo", "UIChangeGroup")
	local effRoot = goutil.findChild(mainGo, "effRoot")
	local kudo = goutil.findChild(mainGo, "kudo")
	local btnDarkKudo = goutil.findChild(mainGo, "kudo/btnDark")
	local btnLightKudo = goutil.findChild(mainGo, "kudo/btnLight")
	local txtNumKudo = goutil.findChildTextComponent(mainGo, "kudo/txtNum")

	GameUtil.setUIGroupIdx(mainGo, isMyTeam and 1 or 0)

	txtName.text = teamName
	txtCount.text = string.format("%s/%s", curMemberCount, maxMemberCount)

	GameUtil.SetActive(tagOfFull, isFull and self._curRoundId == ShowDownEnum.Round_Eliminate_Group)
	GameUtil.SetActive(tagOfWin, isShowResult and isWinTeam)

	if self._isNeedVoteInAct then
		GameUtil.SetActive(heat, true)
		GameUtil.SetActive(kudo, true)
		GameUtil.SetActive(btnDarkKudo, guessValue <= 0)
		GameUtil.SetActive(btnLightKudo, not GameUtil.GetActive(btnDarkKudo))
		GameUtil.addClickHandler(btnDarkKudo, function()
			self:_onClickVoteToTeam(teamShowInfo.teamSimpleViewMo)
		end)
		GameUtil.addClickHandler(btnLightKudo, function()
			self:_onClickVoteToTeam(teamShowInfo.teamSimpleViewMo)
		end)
		GameUtil.SetActive(txtNumKudo.gameObject, guessValue > 0)

		txtNumKudo.text = string.format("+%s", guessValue)
		txtHeat.text = heatValue

		local heatIconPath = ShowDownConfig.instance:getCommonValue(self._activityId, "heatIconPath")
		local spriteName = string.format("%s.png", heatIconPath)

		uGuiUtil.setSpriteToImage(heatIcon, uGuiUtil.SpriteType.BigBg, spriteName)
	else
		GameUtil.SetActive(heat, false)
		GameUtil.SetActive(kudo, false)
		GameUtil.rmClickHandler(btnDarkKudo)
		GameUtil.rmClickHandler(btnLightKudo)
		uGuiUtil.clearImage(heatIcon)
	end

	local function clickFunc()
		ShowDownController.instance:opTeamDetailView(self._activityId, self._curRoundId, teamId, teamName)
	end

	GameUtil.addClickHandler(mainGo, clickFunc)
	ShowDownController.instance:setTeamHeadCellRoot(teamIcon, leaderHeadInfo, self._activityId, teamIconId, clickFunc)

	if self._joinTeamId == teamId then
		self._joinTeamId = -1

		self:_playFlashEff(effRoot)
	end
end

function ShowDownEliminateView:_clearTeamCell(cell)
	local mainGo = cell.gameObject
	local teamIcon = goutil.findChild(mainGo, "teamIcon")
	local btnDarkKudo = goutil.findChild(mainGo, "kudo/btnDark")
	local btnLightKudo = goutil.findChild(mainGo, "kudo/btnLight")
	local heatIcon = goutil.findChild(mainGo, "heat/heatIcon")
	local effRoot = goutil.findChild(mainGo, "effRoot")

	GameUtil.rmClickHandler(mainGo)
	GameUtil.rmClickHandler(btnDarkKudo)
	GameUtil.rmClickHandler(btnLightKudo)
	uGuiUtil.clearImage(heatIcon)
	ShowDownController.instance:clearTeamHeadCellRoot(teamIcon)
	self:_stopFlashEff(effRoot)
end

function ShowDownEliminateView:_onUpdateGroupColUI()
	local groupIdList = {}

	for groupId = 1, self._groupCount do
		table.insert(groupIdList, groupId)
	end

	self._groupScrollList:reloadData(groupIdList)

	if self._curGroupId > 0 then
		local idx = self._curGroupId - 1

		self._groupScrollList:MoveCellInView(idx, true)
	end

	self._txtBtnChooseGroup.text = string.format("第%s组", self._curGroupId)
end

function ShowDownEliminateView:_onClearGroupColUI()
	self._groupScrollList:dispose()
end

function ShowDownEliminateView:_updateGroupCell(view, cell, groupId, tag)
	local isSelected = self._curGroupId == groupId
	local isMyGroupId = self._myGourpId == groupId
	local showDownMo = ShowDownController.instance:getShowDownMo(self._activityId)
	local guessCount = showDownMo:getGuessCountByGroupId(self._curRoundId, groupId)
	local isHaveVote = guessCount > 0
	local mainGo = cell.gameObject
	local changeGroup = mainGo:GetComponent(ComponentType.UIChangeGroup)
	local redPoint = goutil.findChild(mainGo, "redPoint")
	local lock = goutil.findChild(mainGo, "lock")
	local mark = goutil.findChild(mainGo, "mark")
	local markVote = goutil.findChild(mainGo, "markVote")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")

	GameUtil.SetActive(redPoint, false)
	GameUtil.SetActive(lock, false)
	GameUtil.SetActive(mark, isMyGroupId)
	GameUtil.SetActive(markVote, not GameUtil.GetActive(mark) and isHaveVote)
	GameUtil.setUIGroupIdx(mainGo, isSelected and 1 or 0)

	txtName.text = string.format("第%s组", groupId)

	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._clickGroupCell, self, groupId))
end

function ShowDownEliminateView:_clearGroupCell(cell)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)
end

function ShowDownEliminateView:_clickGroupCell(groupId)
	if self._curGroupId == groupId then
		return
	end

	self:_showDownEliminateJumpGroup(groupId)
end

function ShowDownEliminateView:_onCustomInputCallbackOfGroup(hover)
	if not hover then
		GameUtil.SetActive(self._groupScrView, not GameUtil.GetActive(self._groupScrView))
	end
end

function ShowDownEliminateView:_onClickVoteToTeam(teamInfoMo)
	local stepData = ShowDownConfig.instance:getStepData(self._activityId, self._curStepId)

	if not stepData.canGuess then
		FloatWordMgr.instance:show(lang("当前不可应援。"))

		return
	end

	local showDownMo = ShowDownController.instance:getShowDownMo(self._activityId)
	local voteNumCurRound = 0

	for i, v in ipairs(showDownMo:getGuessInfoByRound(self._curRoundId)) do
		voteNumCurRound = voteNumCurRound + checkint(v.guessValue)
	end

	local roundLimit = ShowDownConfig.instance:getGuessRoundLimitInGuess(self._activityId, self._curRoundId)

	if roundLimit <= voteNumCurRound then
		FloatWordMgr.instance:show(lang("本轮已达到应援上限。"))

		return
	end

	local teamId = teamInfoMo:getTeamId()
	local isHasGuess = showDownMo:getGuessInfoByTeamId(self._curRoundId, teamId) ~= nil

	if not isHasGuess then
		local countLimit = ShowDownConfig.instance:getSameGroupLimitInGuess(self._activityId, self._curRoundId)

		if countLimit <= showDownMo:getGuessCountByGroupId(self._curRoundId, teamInfoMo:getGroupId()) then
			FloatWordMgr.instance:show(string.format("每个小组只能应援%s个战队。", countLimit))

			return
		end
	end

	UIStateManager.instance:push(ViewName.ShowdownEliminateVoteView, self._activityId, teamInfoMo)
end

function ShowDownEliminateView:_playFlashEff(effParent)
	self:_stopFlashEff(effParent)

	local pathName = "20240430/leitaisai/fx_ui_leitasai_fangkuang"

	if not goutil.isNil(effParent) and not string.nilorempty(pathName) then
		local path = pathName .. ".prefab"

		local function finishHandler(handlerTarget, eff)
			return
		end

		local function loadedHandler(handlerTarget, eff)
			eff:setParent(effParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true
		end

		local handlerTarget

		if self._flashEffPool == nil then
			self._flashEffPool = {}
		end

		self._flashEffPool[effParent] = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, false, false, finishHandler, loadedHandler, handlerTarget)
	end
end

function ShowDownEliminateView:_stopFlashEff(effParent)
	if self._flashEffPool then
		UIEffectManager.instance:stopEffect(self._flashEffPool[effParent])

		self._flashEffPool[effParent] = nil
	end
end

function ShowDownEliminateView:_clearAllFlashEff()
	if self._flashEffPool then
		for key, eff in pairs(self._flashEffPool) do
			UIEffectManager.instance:stopEffect(eff)

			self._flashEffPool[key] = nil
		end
	end
end

function ShowDownEliminateView:_onClickBtnChooseGroup()
	self:_onCustomInputCallbackOfGroup(false)
end

function ShowDownEliminateView:_onClickBtnSearch()
	UIStateManager.instance:push(ViewName.ShowDownEliminateTeamSearchView, self._activityId)
end

function ShowDownEliminateView:_onClickBtnRecruitInfo()
	local isLeader = self._mainRaceInfo:isLeader()

	if isLeader then
		UIStateManager.instance:push(ViewName.ShowDownEliminateInviteInfoView, self._activityId)
	else
		UIStateManager.instance:push(ViewName.ShowdownbeinviteView, self._activityId)
	end
end

function ShowDownEliminateView:_onClickBtnTask()
	ShowDownController.instance:opTaskView(self._activityId)
end

function ShowDownEliminateView:_onClickBtnShop()
	local value = ShowDownConfig.instance:getCommonValue(self._activityId, "jumpStrShop")

	GotoMgr.gotoByString(value)
end

function ShowDownEliminateView:_onClickBtnVote()
	UIStateManager.instance:push(ViewName.ShowDownEliminateVoteGoldGainPopView, self._activityId, self._curRoundId)
end

function ShowDownEliminateView:_onClickBtnVoteRecord()
	UIStateManager.instance:push(ViewName.ShowDownEliminateVoteRecordView, self._activityId)
end

return ShowDownEliminateView
