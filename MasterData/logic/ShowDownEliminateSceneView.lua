-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownEliminateSceneView.lua

module("logic.extensions.showdown.view.ShowDownEliminateSceneView", package.seeall)

local ShowDownEliminateSceneView = class("ShowDownEliminateSceneView", ViewComponent)

function ShowDownEliminateSceneView:ctor()
	ShowDownEliminateSceneView.super.ctor(self)
end

function ShowDownEliminateSceneView:buildUI()
	ShowDownEliminateSceneView.super.buildUI(self)

	self._captainHeadCell = goutil.findChild(self.mainGO, "leftCol/captainHeadCell")
	self._tagOfMeInLeader = goutil.findChild(self.mainGO, "leftCol/tagOfMeInLeader")
	self._txtCaptainName = goutil.findChildTextComponent(self.mainGO, "leftCol/txtCaptainName")

	local memberScrView = goutil.findChild(self.mainGO, "leftCol/memberCol/scrView")
	local memberScrCell = goutil.findChild(self.mainGO, "leftCol/memberCol/scrCell")

	self._memberScrollList = ScrollerList.create(memberScrView, memberScrCell, GameUtil.handler(self._updateMemberCell, self), GameUtil.handler(self._clearMemberCell, self))
	self._emptyGo = goutil.findChild(self.mainGO, "emptyGo")
	self._btnJumpInEmptyGo = goutil.findChild(self.mainGO, "emptyGo/btnJump")
	self._rightCol = goutil.findChild(self.mainGO, "rightCol")
	self._remainTime = goutil.findChild(self.mainGO, "rightCol/remainTime")
	self._txtRemainTimeName = goutil.findChildTextComponent(self.mainGO, "rightCol/remainTime/txtRemainTimeName")
	self._txtRemainTime = goutil.findChildTextComponent(self.mainGO, "rightCol/remainTime/txtRemainTime")
	self._txtTipsOut = goutil.findChildTextComponent(self.mainGO, "rightCol/txtTipsOut")
	self._teamIconInRight = goutil.findChild(self.mainGO, "rightCol/teamIcon")
	self._txtTeamName = goutil.findChildTextComponent(self.mainGO, "rightCol/teamName/txt")
	self._txtMyTeamScore = goutil.findChildTextComponent(self.mainGO, "rightCol/txtMyTeamScore")
	self._txtMyTeamWin = goutil.findChildTextComponent(self.mainGO, "rightCol/txtMyTeamWin")
	self._txtMyTeamHeat = goutil.findChildTextComponent(self.mainGO, "rightCol/txtMyTeamHeat")
	self._myTeamHeatIcon = goutil.findChild(self.mainGO, "rightCol/txtMyTeamHeat/icon")
	self._imgLightLine = goutil.findChild(self.mainGO, "rightCol/imgLightLine")

	local teamScrView = goutil.findChild(self.mainGO, "rightCol/teamCol/scrView")
	local teamScrCell = goutil.findChild(self.mainGO, "rightCol/teamCol/scrCell")

	self._teamScrollList = ScrollerList.create(teamScrView, teamScrCell, GameUtil.handler(self._updateTeamCell, self), GameUtil.handler(self._clearTeamCell, self))
	self._txtEnemyTeamScore = goutil.findChildTextComponent(self.mainGO, "rightCol/txtEnemyTeamScore")
	self._txtEnemyTeamWin = goutil.findChildTextComponent(self.mainGO, "rightCol/txtEnemyTeamWin")
	self._txtEnemyTeamHeat = goutil.findChildTextComponent(self.mainGO, "rightCol/txtEnemyTeamHeat")
	self._enemyTeamHeatIcon = goutil.findChild(self.mainGO, "rightCol/txtEnemyTeamHeat/icon")
	self._txtFightEmpty = goutil.findChildTextComponent(self.mainGO, "rightCol/txtFightEmpty")
	self._txtFighting = goutil.findChildTextComponent(self.mainGO, "rightCol/txtFighting")
	self._effRootZuozhan = goutil.findChild(self.mainGO, "rightCol/effRootZuozhan")
	self._resultInRight = goutil.findChild(self.mainGO, "rightCol/result")
	self._txtAddInResult = goutil.findChildTextComponent(self.mainGO, "rightCol/result/txtAdd")
	self._txtWinInResult = goutil.findChildTextComponent(self.mainGO, "rightCol/result/txtWin")
	self._imgWinInResult = goutil.findChild(self.mainGO, "rightCol/result/imgWin")
	self._imgFailInResult = goutil.findChild(self.mainGO, "rightCol/result/imgFail")
	self._btnSearchInResult = goutil.findChild(self.mainGO, "rightCol/result/btnSearch")
	self._btnFmtInRight = goutil.findChild(self.mainGO, "rightCol/btnFmt")
	self._pkEffView = goutil.findChild(self.mainGO, "rightCol/pkEffView")
	self._pkEffRoots = GameUtil.getChildren(self._pkEffView)

	local enemyScrview = goutil.findChild(self.mainGO, "rightCol/enemyScrview")
	local enemyScrCell = goutil.findChild(self.mainGO, "rightCol/enemyScrCell")

	self._enemyScrollList = ScrollerList.create(enemyScrview, enemyScrCell, GameUtil.handler(self._updateEnemyCell, self), GameUtil.handler(self._clearEnemyCell, self))
end

function ShowDownEliminateSceneView:bindEvents()
	ShowDownEliminateSceneView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnFmtInRight, GameUtil.handler(self._onClickBtnFmtInRight, self))
	GameUtil.addClickHandler(self._btnJumpInEmptyGo, self._onClickBtnJump, self)
	GameUtil.addClickHandler(self._btnSearchInResult, GameUtil.handler(self._onClickBtnSearchInResult, self))
end

function ShowDownEliminateSceneView:unbindEvents()
	ShowDownEliminateSceneView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnFmtInRight)
	GameUtil.rmClickHandler(self._btnSearchInResult)
	GameUtil.rmClickHandler(self._btnJumpInEmptyGo)
end

function ShowDownEliminateSceneView:onEnter()
	ShowDownEliminateSceneView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._activityType = ShowDownController.instance:getActivityType()

	local isInTime = ShowDownController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._curStepId = ShowDownController.instance:getCurStepId(self._activityId)
	self._curRoundId = ShowDownController.instance:getRoundIdByStep(self._activityId, self._curStepId)
	self._scheduleInfo = ShowDownController.instance:getScheduleInfoInElimate(self._activityId)
	self._isNeedVoteInAct = ShowDownController.instance:isNeedGuessInAct(self._activityId)
	self._isPetShopReady = false

	GameUtil.SetActive(self._remainTime, false)
	self.addGEvent(self, GlobalNotify.ShowDownStepChange, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDown_GetScheduleInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDown_GetMainInfoRes, self._handlePM_ShowDown_GetMainInfoRes, self)
	ShowDownController.instance:sendPM_ShowDown_GetScheduleInfoReq(self._activityId)

	local racePeriod = ShowDownController.instance:getRacePeriodByStep(self._activityId, self._curRoundId)

	if racePeriod == ShowDownEnum.RacePeriod_Eliminate and self._curRoundId > ShowDownEnum.Round_Eliminate_Group then
		ShowDownController.instance:sendPM_ShowDown_GetMainInfoReq(self._activityId, -1)
	end

	local key = string.format("ShowDownEliminateRule_%s", self._activityId)

	local function firstCallback()
		local list = {
			{
				desc = "",
				url = "ui/bigbg/views/showdown/board_ltszy_02.png"
			},
			{
				desc = "",
				url = "ui/bigbg/views/showdown/board_ltszy_01.png"
			}
		}

		TipsFacade.instance:openImageRuleView(list, "提示")
	end

	GameUtil.doCallbackWhenFirst(key, firstCallback, nil)
end

function ShowDownEliminateSceneView:onExit()
	ShowDownEliminateSceneView.super.onExit(self)
	removetimer(self._onTicking, self)
	self:_onClear()
end

function ShowDownEliminateSceneView:_handlePM_ShowDown_GetMainInfoRes()
	self._isPetShopReady = true

	self:_onUpdate()
end

function ShowDownEliminateSceneView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function ShowDownEliminateSceneView:_onUpdateData()
	self._curStepId = ShowDownController.instance:getCurStepId(self._activityId)
	self._curRoundId = ShowDownController.instance:getRoundIdByStep(self._activityId, self._curStepId)
	self._playerRoundId = ShowDownController.instance:getPlayerRoundId(self._activityId)
	self._stepMatchViewMoList = self._scheduleInfo:getStepMatchViewMoList()
	self._curSelectEnemyTeamIndex = self._curSelectEnemyTeamIndex or 1

	local teamIndex = 0

	for idx, stepMatchViewMo in ipairs(self._stepMatchViewMoList) do
		teamIndex = idx

		local result = stepMatchViewMo:getResult()

		if result == nil then
			break
		end
	end

	self._curSelectEnemyTeamIndex = Mathf.Clamp(teamIndex, 0, #self._stepMatchViewMoList)
	self._emptyStepMatchViewMo = ShowDownStepMatchViewMo.New()
end

function ShowDownEliminateSceneView:_onUpdateUI()
	local playerRoundId = ShowDownController.instance:getPlayerRoundId(self._activityId)
	local isOut = playerRoundId < self._curRoundId

	GameUtil.SetActive(self._txtTipsOut.gameObject, isOut)

	if isOut then
		self._txtTipsOut.text = playerRoundId <= ShowDownEnum.Round_Eliminate_512To64 and "您止步于512进64" or playerRoundId == ShowDownEnum.Round_Eliminate_64To8 and "您止步于64进8" or "您止步于小组赛"
	end

	if isOut then
		removetimer(self._onTicking, self)
	else
		local tipsStr = ShowDownController.instance:getShowTipsInStep(self._activityId, self._curStepId)

		self._txtRemainTimeName.text = tipsStr .. "："

		self:_onTicking()
		settimer(1, self._onTicking, self, true)
	end

	GameUtil.SetActive(self._remainTime, not isOut)
	self:_onUpdateMemberColUI()
	self:_onUpdateMyTeamUI()
	self:_onUpdateEnemyTeamsUI()

	if self._curRoundId == ShowDownEnum.Round_Eliminate_Group then
		GameUtil.SetActive(self._emptyGo, true)
		GameUtil.SetActive(self._rightCol, false)
	else
		GameUtil.SetActive(self._emptyGo, false)
		GameUtil.SetActive(self._rightCol, true)
	end
end

function ShowDownEliminateSceneView:_onClear()
	self:_onClearMemberCol()
	self:_onClearMyTeam()
	self:_onClearEnemyTeams()
end

function ShowDownEliminateSceneView:_onTicking()
	local stamp = ShowDownController.instance:getLeftTimeStampToNext(self._activityId, self._curStepId)

	self._txtRemainTime.text = GameUtil.FormatTimeSymbol(stamp)
end

function ShowDownEliminateSceneView:_getState(stepMatchViewMo)
	local stepId = stepMatchViewMo:getStepId()
	local result = stepMatchViewMo:getResult()
	local state = 0

	if stepId > self._curStepId then
		state = 1
	elseif stepId <= self._curStepId then
		state = result == nil and 2 or 3
	end

	return state
end

function ShowDownEliminateSceneView:_onUpdateMemberColUI()
	local leaderHeadInfo = self._scheduleInfo:getMyTeamLeaderHeadInfo()
	local leaderUserId = checknumber(leaderHeadInfo and leaderHeadInfo.userId)
	local memberHeadInfoList = self._scheduleInfo:getMemberHeadInfoList()
	local infoList = {}

	for _, headInfo in ipairs(memberHeadInfoList) do
		if leaderUserId ~= checknumber(headInfo.userId) then
			table.insert(infoList, headInfo)
		end
	end

	self._memberScrollList:reloadData(infoList)
end

function ShowDownEliminateSceneView:_onClearMemberCol()
	self._memberScrollList:dispose()
end

function ShowDownEliminateSceneView:_updateMemberCell(view, cell, headInfo, tag)
	if headInfo then
		if not headInfo.userId then
			local userId = 0
			local myUserId = RoleModel.instance:getUserId()
			local isMe = checknumber(myUserId) == checknumber(userId)
			local mainGo = cell.gameObject
			local headRoot = goutil.findChild(mainGo, "headRoot")
			local tagOfMe = goutil.findChild(mainGo, "tagOfMe")
			local txtName = goutil.findChildTextComponent(mainGo, "txtName")

			if headInfo then
				local proxy = HeadItemController.instance:setHeadCellByInfo(headRoot, headInfo, false)

				if proxy then
					proxy:setCallBack(function()
						ShowDownController.instance:opPlayerInfoView(headRoot, self._activityId, headInfo)
					end)
				end
			else
				HeadItemController.instance:resetHeadCell(headRoot)
			end

			if headInfo then
				txtName.text = headInfo.userName or ""
			end

			GameUtil.SetActive(tagOfMe, isMe)
		end
	end
end

function ShowDownEliminateSceneView:_clearMemberCell(cell)
	local mainGo = cell.gameObject
	local headRoot = goutil.findChild(mainGo, "headRoot")

	HeadItemController.instance:resetHeadCell(headRoot)
end

function ShowDownEliminateSceneView:_onUpdateMyTeamUI()
	local leaderHeadInfo = self._scheduleInfo:getMyTeamLeaderHeadInfo()
	local proxy = HeadItemController.instance:setHeadCellByInfo(self._captainHeadCell, leaderHeadInfo, false)

	if proxy then
		proxy:setCallBack(function()
			ShowDownController.instance:opPlayerInfoView(self._captainHeadCell, self._activityId, leaderHeadInfo)
		end)
	end

	if leaderHeadInfo then
		self._txtCaptainName.text = leaderHeadInfo.userName or ""
	end

	GameUtil.SetActive(self._tagOfMeInLeader, self._scheduleInfo:isLeaderMe())

	local teamIconId = self._scheduleInfo:getMyTeamOfTeamLogo()

	ShowDownController.instance:setTeamHeadCellRoot(self._teamIconInRight, leaderHeadInfo, self._activityId, teamIconId)

	self._txtTeamName.text = self._scheduleInfo:getMyTeamOfTeamName()
	self._txtMyTeamScore.text = self._scheduleInfo:getMyTeamOfScore()

	local myTeamWin = self._scheduleInfo:getMyTeamOfWinCount()

	self._txtMyTeamWin.text = string.format("%s场", myTeamWin)
	self._txtMyTeamHeat.text = self._scheduleInfo:getMyTeamHeatValue()

	local heatIconPath = ShowDownConfig.instance:getCommonValue(self._activityId, "heatIconPath")
	local spriteName = string.format("%s.png", heatIconPath)

	uGuiUtil.setSpriteToImage(self._myTeamHeatIcon, uGuiUtil.SpriteType.BigBg, spriteName)
	GameUtil.SetActive(self._txtMyTeamHeat.gameObject, self._isNeedVoteInAct)
end

function ShowDownEliminateSceneView:_onClearMyTeam()
	HeadItemController.instance:resetHeadCell(self._captainHeadCell)
	ShowDownController:clearTeamHeadCellRoot(self._teamIconInRight)
	uGuiUtil.clearImage(self._myTeamHeatIcon)
end

function ShowDownEliminateSceneView:_getCurStepMatchViewMo()
	return self._stepMatchViewMoList[self._curSelectEnemyTeamIndex] or self._emptyStepMatchViewMo
end

function ShowDownEliminateSceneView:_onUpdateEnemyTeamsUI()
	local curStepMatchViewMo = self:_getCurStepMatchViewMo()
	local stepId = curStepMatchViewMo:getStepId()
	local state = self:_getState(curStepMatchViewMo)

	self._teamScrollList:reloadData(self._stepMatchViewMoList)
	self._teamScrollList:MoveCellInView(Mathf.Max(self._curSelectEnemyTeamIndex - 1, 0), true)
	self._enemyScrollList:reloadData(curStepMatchViewMo:getMemberHeadInfoList())

	self._txtEnemyTeamScore.text = curStepMatchViewMo:getTeamViewMo():getMyScore()
	self._txtEnemyTeamWin.text = curStepMatchViewMo:getTeamViewMo():getWinCount()
	self._txtEnemyTeamHeat.text = curStepMatchViewMo:getTeamViewMo():getTeamSimpleViewMo():getHeatValue()

	local heatIconPath = ShowDownConfig.instance:getCommonValue(self._activityId, "heatIconPath")
	local spriteName = string.format("%s.png", heatIconPath)

	uGuiUtil.setSpriteToImage(self._enemyTeamHeatIcon, uGuiUtil.SpriteType.BigBg, spriteName)
	GameUtil.SetActive(self._txtEnemyTeamHeat.gameObject, self._isNeedVoteInAct)
	GameUtil.SetActive(self._txtFightEmpty.gameObject, state == 1)
	GameUtil.SetActive(self._txtFighting.gameObject, state == 2)
	GameUtil.SetActive(self._resultInRight, state == 3)
	GameUtil.SetActive(self._imgLightLine, state == 2)

	if state == 2 then
		self:_startPlayPkEff()
		self:_playZuozhanEff()
	else
		self:_stopPlayPkEff()
		self:_stopZuozhanEff()
	end

	if state == 3 then
		local addScore = curStepMatchViewMo:getMyScore()
		local winCount = curStepMatchViewMo:getWinCount()
		local loseCount = curStepMatchViewMo:getLoseCount()

		self._txtAddInResult.text = addScore
		self._txtWinInResult.text = string.format("%s胜%s负", winCount, loseCount)

		GameUtil.SetActive(self._imgWinInResult, loseCount < winCount)
		GameUtil.SetActive(self._imgFailInResult, not GameUtil.GetActive(self._imgWinInResult))
	end

	local fmtResult, tips = self:getTryFmtResultAndTips(self._activityId, stepId)

	GameUtil.SetActive(self._btnFmtInRight, fmtResult == GameEnum.ResultCode.Success)
end

function ShowDownEliminateSceneView:_onClearEnemyTeams()
	self._teamScrollList:dispose()
	self._enemyScrollList:dispose()
	self:_stopPlayPkEff()
	self:_stopZuozhanEff()
	uGuiUtil.clearImage(self._enemyTeamHeatIcon)
end

function ShowDownEliminateSceneView:_updateTeamCell(view, cell, stepMatchViewMo, tag)
	local teamIndex = cell.data
	local isSelected = self._curSelectEnemyTeamIndex == teamIndex
	local stepId = stepMatchViewMo:getStepId()
	local roundId = ShowDownController.instance:getRoundIdByStep(self._activityId, stepId)
	local teamId = stepMatchViewMo:getTeamId()
	local teamName = stepMatchViewMo:getTeamName()
	local teamIconId = stepMatchViewMo:getTeamLogo()
	local leaderHeadInfo = stepMatchViewMo:getLeaderHeadInfo()
	local winCount = stepMatchViewMo:getWinCount()
	local loseCount = stepMatchViewMo:getLoseCount()
	local isWin = loseCount < winCount
	local isEmptyForm = ShowDownController.instance:isEmptyFormInPetShop(self._activityId, roundId, stepId)
	local curFormPeriod = ShowDownController.instance:getFormPeriodInStep(self._activityId, self._curStepId)
	local isCanFmt = curFormPeriod ~= ShowDownEnum.FormPeriod_None
	local state = self:_getState(stepMatchViewMo)
	local mainGo = cell.gameObject
	local teamIcon = goutil.findChild(mainGo, "teamIcon")
	local imgSelected = goutil.findChild(mainGo, "imgSelected")
	local imgFinishFmt = goutil.findChild(mainGo, "imgFinishFmt")
	local imgFighting = goutil.findChild(mainGo, "imgFighting")
	local txtTeamName = goutil.findChildTextComponent(mainGo, "teamName/txt")
	local imgWin = goutil.findChild(mainGo, "imgWin")
	local imgFail = goutil.findChild(mainGo, "imgFail")

	txtTeamName.text = teamName

	GameUtil.SetActive(imgSelected, isSelected)
	GameUtil.SetActive(imgFinishFmt, isCanFmt and not isEmptyForm)
	GameUtil.SetActive(imgFighting, state == 2)
	GameUtil.SetActive(imgWin, state == 3 and isWin)
	GameUtil.SetActive(imgFail, state == 3 and not isWin)

	local function func()
		self._curSelectEnemyTeamIndex = teamIndex

		self:_onUpdateEnemyTeamsUI()
	end

	GameUtil.addClickHandler(mainGo, func)
	ShowDownController.instance:setTeamHeadCellRoot(teamIcon, leaderHeadInfo, self._activityId, teamIconId, func)
end

function ShowDownEliminateSceneView:_clearTeamCell(cell)
	local mainGo = cell.gameObject
	local teamIcon = goutil.findChild(mainGo, "teamIcon")

	GameUtil.rmClickHandler(mainGo)
	ShowDownController.instance:clearTeamHeadCellRoot(teamIcon)
end

function ShowDownEliminateSceneView:_updateEnemyCell(view, cell, headInfo, tag)
	local curStepMatchViewMo = self:_getCurStepMatchViewMo()
	local leaderHeadInfo = curStepMatchViewMo:getLeaderHeadInfo()
	local userId = headInfo.userId
	local isCaptain = checknumber(leaderHeadInfo.userId) == checknumber(userId)
	local mainGo = cell.gameObject
	local headRoot = goutil.findChild(mainGo, "headRoot")
	local tagOfCaptain = goutil.findChild(mainGo, "tagOfCaptain")

	if headInfo and not string.nilorempty(headInfo.userName) then
		local proxy = HeadItemController.instance:setHeadCellByInfo(headRoot, headInfo, false)

		if proxy then
			proxy:setCallBack(function()
				ShowDownController.instance:opPlayerInfoView(headRoot, self._activityId, headInfo)
			end)
		end
	else
		HeadItemController.instance:resetHeadCell(headRoot)
	end

	GameUtil.SetActive(tagOfCaptain, isCaptain)
end

function ShowDownEliminateSceneView:_clearEnemyCell(cell)
	local mainGo = cell.gameObject
	local headRoot = goutil.findChild(mainGo, "headRoot")

	HeadItemController.instance:resetHeadCell(headRoot)
end

function ShowDownEliminateSceneView:_onClickBtnFmtInRight()
	local curStepMatchViewMo = self:_getCurStepMatchViewMo()
	local stepId = curStepMatchViewMo:getStepId()
	local roundId = ShowDownController.instance:getRoundIdByStep(self._activityId, stepId)
	local result, tips = self:getTryFmtResultAndTips(self._activityId, stepId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	if self._isPetShopReady then
		ShowDownController.instance:enterShowDownPetShopAndFmt(self._activityId, roundId, stepId)
	end
end

function ShowDownEliminateSceneView:_startPlayPkEff()
	self._delaySecInPk = 3
	self._oldRandomIdx = 0
	self._curDeltaSecInPk = self._delaySecInPk

	self:_tickingPkEff()
	settimer(1, self._tickingPkEff, self, true)
end

function ShowDownEliminateSceneView:_stopPlayPkEff()
	self:_stopPkEff()
	removetimer(self._tickingPkEff, self)
end

function ShowDownEliminateSceneView:_tickingPkEff()
	if self._curDeltaSecInPk >= self._delaySecInPk then
		self._curDeltaSecInPk = 0

		self:_stopPkEff()

		local randomIdx = Mathf.Random(1, #self._pkEffRoots)

		if randomIdx == self._oldRandomIdx then
			randomIdx = Mathf.Random(1, #self._pkEffRoots)
			self._oldRandomIdx = randomIdx
		end

		local go = self._pkEffRoots[randomIdx]

		self:_playPkEff(go)
	else
		self._curDeltaSecInPk = self._curDeltaSecInPk + 1
	end
end

function ShowDownEliminateSceneView:_playPkEff(effParent)
	local randomIdx = Mathf.Random(1, #ShowDownEnum.PkEffPaths)
	local pathName = ShowDownEnum.PkEffPaths[randomIdx]

	self:_stopPkEff()

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

		self._pkEff = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, true, false, finishHandler, loadedHandler, handlerTarget)
	end
end

function ShowDownEliminateSceneView:_stopPkEff()
	if self._pkEff then
		UIEffectManager.instance:stopEffect(self._pkEff)

		self._pkEff = nil
	end
end

function ShowDownEliminateSceneView:_playZuozhanEff()
	local effParent = self._effRootZuozhan
	local pathName = "20240430/leitaisai/fx_ui_leitasai_zuozhan"

	self:_stopZuozhanEff(effParent)

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

		self._zuozhanEff = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, true, false, finishHandler, loadedHandler, handlerTarget)
	end
end

function ShowDownEliminateSceneView:_stopZuozhanEff()
	if self._zuozhanEff then
		UIEffectManager.instance:stopEffect(self._zuozhanEff)

		self._zuozhanEff = nil
	end
end

function ShowDownEliminateSceneView:getTryFmtResultAndTips(activityId, teamStepId)
	local result = GameEnum.ResultCode.Success
	local tips = ""
	local curStepId = ShowDownController.instance:getCurStepId(self._activityId)

	if teamStepId <= curStepId then
		result = GameEnum.ResultCode.Error
		tips = "不是布阵周期"

		return GameEnum.ResultCode.Error, "不是布阵周期"
	end

	local formPeriod = ShowDownController.instance:getFormPeriodInStep(self._activityId, curStepId)

	if formPeriod == ShowDownEnum.FormPeriod_None then
		result = GameEnum.ResultCode.Error
		tips = "不是布阵周期"

		return GameEnum.ResultCode.Error, "不是布阵周期"
	end

	return result, tips
end

function ShowDownEliminateSceneView:_onClickBtnJump()
	GlobalDispatcher:dispatch(GlobalNotify.ShowDownMainViewJumpTab, 1)
end

function ShowDownEliminateSceneView:_onClickBtnSearchInResult()
	local curStepMatchViewMo = self:_getCurStepMatchViewMo()
	local stepId = curStepMatchViewMo:getStepId()
	local myTeamId = self._scheduleInfo:getMyTeamOfTeamId()
	local otherTeamId = curStepMatchViewMo:getTeamId()

	UIStateManager.instance:push(ViewName.ShowDownBattleResutlView, self._activityId, stepId, myTeamId, otherTeamId)
end

return ShowDownEliminateSceneView
