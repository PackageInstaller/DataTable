-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/eliminator/tab/TabPTEliVotePlateMainView.lua

module("logic.extensions.peaktournament.view.eliminator.tab.TabPTEliVotePlateMainView", package.seeall)

local TabPTEliVotePlateMainView = class("TabPTEliVotePlateMainView", ViewComponent)

function TabPTEliVotePlateMainView:buildUI()
	TabPTEliVotePlateMainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._txtRemainTime = goutil.findChildTextComponent(self.mainGO, "txtRemainTime/txt")
	self._txtTips = goutil.findChildTextComponent(self.mainGO, "txtTips/txt")
	self._txtLimit = goutil.findChildTextComponent(self.mainGO, "txtLimit")
	self._limitIcon = goutil.findChild(self.mainGO, "txtLimit/icon")
	self._btnVoteGain = goutil.findChild(self.mainGO, "btnCol/btnVoteGain")
	self._btnVoteGainRed = goutil.findChild(self.mainGO, "btnCol/btnVoteGain/redPoint")
	self._btnExchange = goutil.findChild(self.mainGO, "btnCol/btnExchange")
	self._btnRecord = goutil.findChild(self.mainGO, "btnCol/btnRecord")
	self._voteScrollerview = goutil.findChild(self.mainGO, "voteCol/voteScrollerview")
	self._voteScrollercell = goutil.findChild(self.mainGO, "voteCol/voteScrollercell")
	self._imgEmpty = goutil.findChild(self.mainGO, "voteCol/imgEmpty")
	self._voteScrollList = ScrollerList.create(self._voteScrollerview, self._voteScrollercell, GameUtil.handler(self._updateVoteCell, self), GameUtil.handler(self._clearVoteCell, self))
end

function TabPTEliVotePlateMainView:bindEvents()
	TabPTEliVotePlateMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnVoteGain, self._onClickBtnVoteGain, self)
	GameUtil.addClickHandler(self._btnExchange, self._onClickBtnExchange, self)
	GameUtil.addClickHandler(self._btnRecord, self._onClickBtnRecord, self)
end

function TabPTEliVotePlateMainView:unbindEvents()
	TabPTEliVotePlateMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnVoteGain)
	GameUtil.rmClickHandler(self._btnExchange)
	GameUtil.rmClickHandler(self._btnRecord)
end

function TabPTEliVotePlateMainView:onEnter()
	TabPTEliVotePlateMainView.super.onEnter(self)

	self._activityId = PeakTournamentController.instance:getCurActivityId()

	if self._activityId == 0 then
		FloatWordMgr.instance:show("缺失活动id")

		return
	end

	self._eliminatorMgr = PeakTournamentController.instance:getEliminatorMgr()

	if self._eliminatorMgr == nil then
		printError("缺失[ EliminatorMgr模块 ],无法运行")

		return
	end

	self._eliRoundCfg = PeakTournamentConfig.instance:getPtEliRoundCfgById(self._activityId)

	self:_onUpdateEliRoundInfo()
	GlobalDispatcher:addListener(GlobalNotify.PeakTournamentKnockoutGetGuessInfoRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.EliminatorMgrNotifyChangeNewPeriod, self._handleNotifyChangeNewPeriod, self)
	GlobalDispatcher:addListener(GlobalNotify.PeakTournamentKnockoutGuessRes, self._sendInfoReq, self)
	GlobalDispatcher:addListener(GlobalNotify.PeakTournamentKnockoutGainGuessCoinRes, self._sendInfoReq, self)
	self:_sendInfoReq()
	settimer(0.1, self._onTicking, self)

	local key = PeakTournamentConfig.instance:getPtCommonValue("LKEY_TABPTELIVOTEPLATEMAINVIEW_1")
	local ratio1 = checknumber(PeakTournamentConfig.instance:getPtCommonValue("VOTE_WIN_RATIO"))
	local ratio2 = checknumber(PeakTournamentConfig.instance:getPtCommonValue("VOTE_LOSE_RATIO"))

	ratio2 = string.format("%d%%", ratio2 * 100)
	self._txtTips.text = langPara(key, ratio1, ratio2)

	local matStr = PeakTournamentConfig.instance:getVoteMate()
	local matType, matId, matNum = MaterialMgr.getMatParams(matStr)

	MaterialMgr.setIcon(self._limitIcon, matType, matId, nil, nil)
	RedPointController.instance:regRedPoint(self._btnVoteGainRed, PeakTournamentConfig.instance:getPtCommonValue("PT_RED_VOTE_GAIN"))
end

function TabPTEliVotePlateMainView:onExit()
	TabPTEliVotePlateMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PeakTournamentKnockoutGetGuessInfoRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.EliminatorMgrNotifyChangeNewPeriod, self._handleNotifyChangeNewPeriod, self)
	GlobalDispatcher:removeListener(GlobalNotify.PeakTournamentKnockoutGuessRes, self._sendInfoReq, self)
	GlobalDispatcher:removeListener(GlobalNotify.PeakTournamentKnockoutGainGuessCoinRes, self._sendInfoReq, self)
	removetimer(self._onTicking, self)
	self._voteScrollList:dispose()

	self._eliminatorMgr = nil

	MaterialMgr.clearIcon(self._limitIcon)
	RedPointController.instance:unregRedPoint(self._btnVoteGainRed)
end

function TabPTEliVotePlateMainView:_handleNotifyChangeNewPeriod()
	PeakTournamentController.instance:sendPM_PeakTournamentKnockoutGetParticipationInfoReq(self._activityId)
	self:_sendInfoReq()
end

function TabPTEliVotePlateMainView:_sendInfoReq()
	PeakTournamentController.instance:sendPM_PeakTournamentKnockoutGetGuessInfoReq(self._activityId)
end

function TabPTEliVotePlateMainView:_onUpdate()
	self:_onUpdateEliRoundInfo()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function TabPTEliVotePlateMainView:_onUpdateData()
	return
end

function TabPTEliVotePlateMainView:_onUpdateUI()
	self:_onUpdateVoteColUI()
end

function TabPTEliVotePlateMainView:_onTicking()
	self:_onUpdateRemainTimeUI()
end

function TabPTEliVotePlateMainView:_onUpdateEliRoundInfo()
	self._curEliRoundId = self._eliminatorMgr:getNewestEliRoundId()
	self._curPeriodId = self._eliminatorMgr:getCurPeriodId(self._curEliRoundId)
end

function TabPTEliVotePlateMainView:_onUpdateRemainTimeUI()
	self._txtRemainTime.text = self._eliminatorMgr:getRemainTimeTipsStr(self._curEliRoundId)
end

function TabPTEliVotePlateMainView:_onUpdateVoteColUI()
	local hasVoteCount = PeakTournamentController.instance:getHasVoteCount()
	local maxNumLimit = PeakTournamentController.instance:getMaxVoteScoreLimit(self._activityId, self._curEliRoundId)

	self._txtLimit.text = string.format("%s/%s", hasVoteCount, maxNumLimit)

	local guessInfoList = PeakTournamentModel.instance:getGuessInfoList()

	self._voteScrollList:reloadData(guessInfoList)
	GameUtil.SetActive(self._imgEmpty, #guessInfoList == 0)
end

function TabPTEliVotePlateMainView:_updateVoteCell(view, cell, guessInfo, tag)
	local stageIndex = cell.index + 1
	local mainGo = cell.gameObject
	local btnReview = goutil.findChild(mainGo, "btnReview")
	local leftHead = goutil.findChild(mainGo, "leftHead")
	local rightHead = goutil.findChild(mainGo, "rightHead")
	local myGuessTargetId = guessInfo.myGuessTargetId

	if not guessInfo.myGuessNum then
		local myGuessNum = 0
		local resultInfoMo = PeakTournamentModel.instance:getResultInfoMoAsGuess(stageIndex)

		if self._curEliRoundId == self._eliminatorMgr:getNewestEliRoundId() and self._curPeriodId == EliminatorMgr.PeriodId.Performance then
			GameUtil.SetActive(btnReview, true)
		else
			GameUtil.SetActive(btnReview, false)
		end

		GameUtil.addClickHandler(btnReview, GameUtil.handler(self._onClickVoteCellBtnReview, self, guessInfo.battleInfo.recordForm))

		for idx, headGo in ipairs({
			leftHead,
			rightHead
		}) do
			local btnForm = goutil.findChild(headGo, "btnForm")
			local btnVote = goutil.findChild(headGo, "btnVote")
			local headIcon = goutil.findChild(headGo, "headIcon")
			local btnHead = goutil.findChild(headGo, "btnHead")
			local txtPower = goutil.findChildTextComponent(headGo, "txtPower")
			local txtName = goutil.findChildTextComponent(headGo, "txtName")
			local txtTotalVoteNum = goutil.findChildTextComponent(headGo, "txtTotalVoteNum/txt")
			local txtMyVoteNum = goutil.findChildTextComponent(headGo, "txtMyVoteNum")
			local isMe = idx == 1
			local userId = resultInfoMo:getUserId(isMe)

			if myGuessTargetId == userId then
				txtMyVoteNum.text = string.format("+%s", myGuessNum)

				GameUtil.SetActive(txtMyVoteNum.gameObject, myGuessNum > 0)
			else
				GameUtil.SetActive(txtMyVoteNum.gameObject, false)
			end

			txtTotalVoteNum.text = resultInfoMo:getGuessNums(isMe)

			local headInfo = resultInfoMo:getHeadInfo(isMe)

			if headInfo then
				HeadItemController.instance:setHeadCellByInfo(headIcon, headInfo)
			else
				HeadItemController.instance:resetHeadCell(headIcon)
			end

			txtName.text = resultInfoMo:getUserNameAddAreaId(isMe)
			txtPower.text = resultInfoMo:getEverMaxZdl(isMe)

			GameUtil.SetGray(btnVote, not PeakTournamentController.instance:isCanVoteTheUser(stageIndex, userId))
			GameUtil.addClickHandler(btnHead, GameUtil.handler(self._onClickVoteCellBtnHead, self, userId, btnHead))
			GameUtil.addClickHandler(btnForm, GameUtil.handler(self._onClickVoteCellBtnForm, self, stageIndex, isMe))
			GameUtil.addClickHandler(btnVote, GameUtil.handler(self._onClickVoteCellBtnVote, self, stageIndex, isMe))
		end
	end
end

function TabPTEliVotePlateMainView:_clearVoteCell(cell)
	local mainGo = cell.gameObject
	local btnReview = goutil.findChild(mainGo, "btnReview")
	local leftHead = goutil.findChild(mainGo, "leftHead")
	local rightHead = goutil.findChild(mainGo, "rightHead")

	GameUtil.rmClickHandler(btnReview)

	for _, headGo in ipairs({
		leftHead,
		rightHead
	}) do
		local btnForm = goutil.findChild(headGo, "btnForm")
		local btnVote = goutil.findChild(headGo, "btnVote")
		local btnAid = goutil.findChild(headGo, "btnAid")
		local headIcon = goutil.findChild(headGo, "headIcon")
		local btnHead = goutil.findChild(headGo, "btnHead")

		HeadItemController.instance:resetHeadCell(headIcon)
		GameUtil.rmClickHandler(btnForm)
		GameUtil.rmClickHandler(btnVote)
		GameUtil.rmClickHandler(btnAid)
		GameUtil.rmClickHandler(btnHead)
	end
end

function TabPTEliVotePlateMainView:_onClickVoteCellBtnForm(stageIndex, isMe)
	local resultInfoMo = PeakTournamentModel.instance:getResultInfoMoAsGuess(stageIndex)

	if resultInfoMo then
		UIStateManager.instance:push(ViewName.PTLookOverFmtInVotePlateView, resultInfoMo, isMe)
	end
end

function TabPTEliVotePlateMainView:_onClickVoteCellBtnVote(stageIndex, isMe)
	if self._curPeriodId > EliminatorMgr.PeriodId.WaitOpen and self._curPeriodId < EliminatorMgr.PeriodId.Preparation then
		FloatWordMgr.instance:show("当前阶段无法进行应援")

		return
	end

	local resultInfoMo = PeakTournamentModel.instance:getResultInfoMoAsGuess(stageIndex)
	local isCan = PeakTournamentController.instance:isCanVoteTheUser(stageIndex, resultInfoMo:getUserId(isMe))

	if not isCan then
		FloatWordMgr.instance:show("一场比赛只能对一方玩家进行应援")

		return
	end

	if PeakTournamentController.instance:isExceedVoteCountLimit(self._activityId, self._curEliRoundId) then
		FloatWordMgr.instance:show("本轮已达到应援上限")

		return
	end

	local headInfo = resultInfoMo:getHeadInfo(isMe)
	local everMaxZdl = resultInfoMo:getEverMaxZdl(isMe)

	UIStateManager.instance:push(ViewName.PTEliVotePlateBagView, self._activityId, self._curEliRoundId, resultInfoMo, isMe)
end

function TabPTEliVotePlateMainView:_onClickVoteCellBtnHead(userId, parentGo)
	FriendController.instance:showInfoView(userId, parentGo)
end

function TabPTEliVotePlateMainView:_onClickVoteCellBtnReview(recordFormList)
	if self._curEliRoundId ~= self._eliminatorMgr:getNewestEliRoundId() then
		tipsStr = "未到该比赛进程"
	end

	if self._curPeriodId ~= EliminatorMgr.PeriodId.Performance then
		FloatWordMgr.instance:show("不在战斗阶段无法观看")

		return
	end

	local battleIdList = {}
	local teamIdList = {}

	if recordFormList then
		for _, recordForm in ipairs(recordFormList) do
			local battleId = checknumber(recordForm.battleId)

			if battleId > 0 then
				table.insert(battleIdList, battleId)
				table.insert(teamIdList, recordForm.teamId)
			end
		end
	end

	if #battleIdList > 0 then
		UIJumper.instance:saveCurStack()

		local fightType = PeakTournamentController.FightType.FightVieo

		PeakTournamentController.instance:sendPM_PeakTournamentKnockoutGetBattleVideoReq(battleIdList, teamIdList, fightType)
	end
end

function TabPTEliVotePlateMainView:_onClickBtnVoteGain()
	if not PeakTournamentModel.instance:isHaveCanGainGuessCoinAsPT() then
		FloatWordMgr.instance:show("没有可领取的应援币")

		return
	end

	UIStateManager.instance:push(ViewName.PTEliVoteGoldGainPopView, self._activityId)
end

function TabPTEliVotePlateMainView:_onClickBtnExchange()
	local jumpToStr = PeakTournamentConfig.instance:getPtCommonValue("PT_JUMP_SHOP_KEY")

	if not string.nilorempty(jumpToStr) then
		GotoMgr.gotoByString(jumpToStr)
	end
end

function TabPTEliVotePlateMainView:_onClickBtnRecord()
	UIStateManager.instance:push(ViewName.PTEliVotePlateRecordView)
end

return TabPTEliVotePlateMainView
