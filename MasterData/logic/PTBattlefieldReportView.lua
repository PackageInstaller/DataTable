-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/common/battlereport/PTBattlefieldReportView.lua

module("logic.extensions.peaktournament.view.common.battlereport.PTBattlefieldReportView", package.seeall)

local PTBattlefieldReportView = class("PTBattlefieldReportView", ViewComponent)
local StackType_Record = 1
local StackType_Detail = 2

function PTBattlefieldReportView:buildUI()
	PTBattlefieldReportView.super.buildUI(self)

	self._btnBack = goutil.findChild(self.mainGO, "Btn_back")
	self._recordCol = goutil.findChild(self.mainGO, "recordCol")
	self._recordScrollerview = goutil.findChild(self.mainGO, "recordCol/recordScrollerview")
	self._recordScrollercell = goutil.findChild(self.mainGO, "recordCol/recordScrollercell")
	self._nodata = goutil.findChild(self.mainGO, "nodata")
	self._detailCol = goutil.findChild(self.mainGO, "detailCol")
	self._recordScrollList = ScrollerList.create(self._recordScrollerview, self._recordScrollercell, GameUtil.handler(self._updateRecordCell, self), GameUtil.handler(self._clearRecordCell, self))
end

function PTBattlefieldReportView:bindEvents()
	PTBattlefieldReportView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnBack, self._onClickBack, self)
end

function PTBattlefieldReportView:unbindEvents()
	PTBattlefieldReportView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnBack)
end

function PTBattlefieldReportView:onEnter()
	PTBattlefieldReportView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PeakTournamentKnockoutGetMyBattleRecordsRes, self._onUpdateUI, self)

	self._activityId = PeakTournamentController.instance:getCurActivityId()

	if self._activityId == 0 then
		FloatWordMgr.instance:show("缺失活动id")

		return
	end

	self._stack = StackType_Record

	PeakTournamentController.instance:sendPM_PeakTournamentKnockoutGetMyBattleRecordsReq(self._activityId)
end

function PTBattlefieldReportView:onExit()
	PTBattlefieldReportView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PeakTournamentKnockoutGetMyBattleRecordsRes, self._onUpdateUI, self)
	self._recordScrollList:dispose()
end

function PTBattlefieldReportView:_getResultInfoMoList()
	return {}
end

function PTBattlefieldReportView:_onUpdateUI()
	GameUtil.SetActive(self._recordCol, StackType_Record == self._stack)
	GameUtil.SetActive(self._detailCol, StackType_Detail == self._stack)

	if self._stack == StackType_Record then
		self:_onUpdateRecordColUI()
	elseif self._stack == StackType_Detail then
		self:_onUpdateDetailColUI()
		GameUtil.SetActive(self._nodata, false)
	end
end

function PTBattlefieldReportView:_onUpdateRecordColUI()
	local resultInfoMoList = self:_getResultInfoMoList()
	local moList = {}

	for i = #resultInfoMoList, 1, -1 do
		table.insert(moList, resultInfoMoList[i])
	end

	self._recordScrollList:reloadData(moList)
	GameUtil.SetActive(self._nodata, #moList == 0)
end

function PTBattlefieldReportView:_updateRecordCell(view, cell, resultInfoMo, tag)
	local mainGo = cell.gameObject
	local imgResult = goutil.findChild(mainGo, "imgResult")
	local imgResultChange = GameUtil.getUIImageSpriteChange(imgResult)
	local txtProgress = goutil.findChildTextComponent(mainGo, "txtProgress/txt")
	local leftHead = goutil.findChild(mainGo, "leftHead")
	local rightHead = goutil.findChild(mainGo, "rightHead")
	local btnDetail = goutil.findChild(mainGo, "btnDetail")
	local roundId = resultInfoMo:getRoundId()
	local roundData = PeakTournamentConfig.instance:getPtEliRoundDataById(self._activityId, roundId)

	txtProgress.text = roundData and roundData.processDesc or ""

	local isWin = resultInfoMo:isWin(true)

	imgResultChange:SetState(isWin and 0 or 1)

	for headIdx, headGo in ipairs({
		leftHead,
		rightHead
	}) do
		local headIcon = goutil.findChild(headGo, "headIcon")
		local txtName = goutil.findChildTextComponent(headGo, "txtName")
		local txtRank = goutil.findChildTextComponent(headGo, "txtRank")
		local isMe = headIdx == 1
		local headInfo = resultInfoMo:getHeadInfo(isMe)

		if headInfo then
			HeadItemController.instance:setHeadCellByInfo(headIcon, headInfo, true)
		else
			HeadItemController.instance:resetHeadCell(headIcon)
		end

		txtName.text = resultInfoMo:getUserNameAddAreaId(isMe)

		if roundData then
			GameUtil.SetActive(txtRank, false)
		else
			GameUtil.SetActive(txtRank, true)

			txtRank.text = langPara("积分：%s", resultInfoMo:getRankScore(isMe))
		end
	end

	GameUtil.addClickHandler(btnDetail, GameUtil.handler(self._onClickBtnDetail, self, resultInfoMo))
end

function PTBattlefieldReportView:_clearRecordCell(cell)
	local mainGo = cell.gameObject
	local leftHead = goutil.findChild(mainGo, "leftHead")
	local rightHead = goutil.findChild(mainGo, "rightHead")
	local btnDetail = goutil.findChild(mainGo, "btnDetail")

	for _, headGo in ipairs({
		leftHead,
		rightHead
	}) do
		local headIcon = goutil.findChild(headGo, "headIcon")

		HeadItemController.instance:resetHeadCell(headIcon)
	end

	GameUtil.rmClickHandler(btnDetail)
end

function PTBattlefieldReportView:_onClickBtnDetail(resultInfoMo)
	self._stack = self._stack + 1
	self._curResultInfoMo = resultInfoMo

	self:_onUpdateUI()
end

function PTBattlefieldReportView:_onUpdateDetailColUI()
	if not self._curResultInfoMo then
		local resultInfoMo = {}
		local mainGo = self._detailCol
		local txtProgress = goutil.findChildTextComponent(mainGo, "bgplayer/txtProgress")
		local stageCol = goutil.findChild(mainGo, "stageCol")
		local playerCell_1 = goutil.findChild(mainGo, "playerCol/playerCell_1")
		local playerCell_2 = goutil.findChild(mainGo, "playerCol/playerCell_2")
		local roundId = resultInfoMo:getRoundId()
		local roundData = PeakTournamentConfig.instance:getPtEliRoundDataById(self._activityId, roundId)

		txtProgress.text = roundData and roundData.processDesc or ""

		for formId = 1, stageCol.transform.childCount do
			local recordForm = resultInfoMo:getRecordForm(formId)
			local battleId = resultInfoMo:getBattleId(formId)
			local stageCell = stageCol.transform:GetChild(formId - 1)
			local isNeedStageCell = recordForm and checknumber(battleId) > 0

			GameUtil.SetActive(stageCell, isNeedStageCell)

			if isNeedStageCell then
				local leftForm = goutil.findChild(stageCell, "leftForm")
				local rightForm = goutil.findChild(stageCell, "rightForm")
				local btnVideo = goutil.findChild(stageCell, "btnVideo")

				for idx, formCell in ipairs({
					leftForm,
					rightForm
				}) do
					local isMe = idx == 1

					self:_setForm(formCell, resultInfoMo, formId, isMe)
				end

				GameUtil.addClickHandler(btnVideo, GameUtil.handler(self._onClickStageCellBtnVideo, self, resultInfoMo, formId))
			end
		end

		for playerIdx, playerCell in ipairs({
			playerCell_1,
			playerCell_2
		}) do
			local headIcon = goutil.findChild(playerCell, "headIcon")
			local txtName = goutil.findChildTextComponent(playerCell, "txtName")
			local isMe = playerIdx == 1
			local headInfo = resultInfoMo:getHeadInfo(isMe)

			if headInfo then
				HeadItemController.instance:setHeadCellByInfo(headIcon, headInfo, true)
			else
				HeadItemController.instance:resetHeadCell(headIcon)
			end

			txtName.text = resultInfoMo:getUserNameAddAreaId(isMe)
		end
	end
end

function PTBattlefieldReportView:_setForm(formCell, resultInfoMo, formId, isMe)
	local txtTotalForce = goutil.findChildTextComponent(formCell, "txtTotalForce")
	local txtTeam = goutil.findChildTextComponent(formCell, "txtTeam")
	local txtWin = goutil.findChild(formCell, "txtWin")
	local txtFail = goutil.findChild(formCell, "txtFail")
	local formations = goutil.findChild(formCell, "formations")

	txtTeam.text = string.format("队伍%s", formId)
	txtTotalForce.text = resultInfoMo:getPlayerZdl(formId, isMe)

	local isWin = resultInfoMo:isWinInForm(formId, isMe)

	GameUtil.SetActive(txtWin, isWin)
	GameUtil.SetActive(txtFail, not isWin)

	local formPetInfo = resultInfoMo:getPetInfoList(formId, isMe)

	for petCellIdx = 1, formations.transform.childCount do
		local petCell = formations.transform:GetChild(petCellIdx - 1)
		local pointPet = goutil.findChild(petCell, "pointPet")
		local petInfo = formPetInfo[petCellIdx]

		if petInfo then
			local raceId = petInfo.raceId
			local skinId = raceId
			local level = petInfo.level
			local awakenLv = petInfo.awakenLevel
			local proxy = MaterialMgr.setCell(MatType.Pet, skinId, pointPet)

			if proxy then
				local tmpMo = FightingPowerPetMo.createPetByLevel(raceId, level, awakenLv, skinId)

				function func()
					CommonTipsMgr.instance:showPetTips(tmpMo, true)
				end

				proxy.binder:setClickCallBack(func)
			end
		else
			MaterialMgr.resetAll(pointPet)
		end
	end
end

function PTBattlefieldReportView:_onClearDetailColUI()
	local mainGo = self._detailCol
	local stageCol = goutil.findChild(mainGo, "stageCol")
	local playerCell_1 = goutil.findChild(mainGo, "playerCol/playerCell_1")
	local playerCell_2 = goutil.findChild(mainGo, "playerCol/playerCell_2")

	for _, playerCell in ipairs({
		playerCell_1,
		playerCell_2
	}) do
		local headIcon = goutil.findChild(playerCell, "headIcon")

		HeadItemController.instance:resetHeadCell(headIcon)
	end

	for stageIdx = 1, stageCol.transform.childCount do
		local stageCell = stageCol.transform:GetChild(stageIdx - 1)
		local leftForm = goutil.findChild(stageCell, "leftForm")
		local rightForm = goutil.findChild(stageCell, "rightForm")
		local btnVideo = goutil.findChild(stageCell, "btnVideo")

		for _, formCell in ipairs({
			leftForm,
			rightForm
		}) do
			local formations = goutil.findChild(formCell, "formations")

			for _ = 1, formations.transform.childCount do
				local pointPet = goutil.findChild(petCell, "pointPet")

				MaterialMgr.resetAll(pointPet)
			end
		end

		GameUtil.rmClickHandler(btnVideo)
	end
end

function PTBattlefieldReportView:_onClickStageCellBtnVideo(resultInfoMo, formId)
	local battleId = resultInfoMo:getBattleId(formId)

	if checknumber(battleId) > 0 then
		UIJumper.instance:saveCurStack()
		self:close()

		local teamId = resultInfoMo:getTeamId(formId)
		local fightType = PeakTournamentController.FightType.FightVieo

		PeakTournamentController.instance:sendPM_PeakTournamentKnockoutGetBattleVideoReq({
			battleId
		}, {
			teamId
		}, fightType)
		self:_toDoReportBehavior()
	else
		FloatWordMgr.instance:show("没有可观看的战斗")
	end
end

function PTBattlefieldReportView:_onClickBack()
	self._stack = self._stack - 1

	if self._stack == 0 then
		self:close()
	end

	self:_onUpdateUI()
end

function PTBattlefieldReportView:_toDoReportBehavior()
	return
end

return PTBattlefieldReportView
