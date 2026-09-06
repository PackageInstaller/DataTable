-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownFinalSceneView.lua

module("logic.extensions.showdown.view.ShowDownFinalSceneView", package.seeall)

local ShowDownFinalSceneView = class("ShowDownFinalSceneView", ViewComponent)

function ShowDownFinalSceneView:ctor()
	ShowDownFinalSceneView.super.ctor(self)
end

function ShowDownFinalSceneView:buildUI()
	ShowDownFinalSceneView.super.buildUI(self)

	self._captainHeadCell = goutil.findChild(self.mainGO, "leftCol/captainHeadCell")
	self._tagOfMeInLeader = goutil.findChild(self.mainGO, "leftCol/tagOfMeInLeader")
	self._txtCaptainName = goutil.findChildTextComponent(self.mainGO, "leftCol/txtCaptainName")

	local memberScrView = goutil.findChild(self.mainGO, "leftCol/memberCol/scrView")
	local memberScrCell = goutil.findChild(self.mainGO, "leftCol/memberCol/scrCell")

	self._memberScrollList = ScrollerList.create(memberScrView, memberScrCell, GameUtil.handler(self._updateMemberCell, self), GameUtil.handler(self._clearMemberCell, self))
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
	self._txtTips = goutil.findChildTextComponent(self.mainGO, "rightCol/txtTips")
	self._imgLightLine = goutil.findChild(self.mainGO, "rightCol/imgLightLine")
	self._teamCell = goutil.findChild(self.mainGO, "rightCol/teamCell")
	self._teamIconInTeamCell = goutil.findChild(self.mainGO, "rightCol/teamCell/teamIcon")
	self._imgSelectedInTeamCell = goutil.findChild(self.mainGO, "rightCol/teamCell/imgSelected")
	self._imgFinishFmtInTeamCell = goutil.findChild(self.mainGO, "rightCol/teamCell/imgFinishFmt")
	self._imgFightingInTeamCell = goutil.findChild(self.mainGO, "rightCol/teamCell/imgFighting")
	self._txtNameInTeamCell = goutil.findChildTextComponent(self.mainGO, "rightCol/teamCell/teamName/txt")
	self._txtMyTeamHeatInTeamCell = goutil.findChildTextComponent(self.mainGO, "rightCol/teamCell/txtMyTeamHeat")
	self._myTeamHeatIconInTeamCell = goutil.findChild(self.mainGO, "rightCol/teamCell/txtMyTeamHeat/icon")
	self._imgWinInTeamCell = goutil.findChild(self.mainGO, "rightCol/teamCell/imgWin")
	self._imgFailInTeamCell = goutil.findChild(self.mainGO, "rightCol/teamCell/imgFail")
	self._txtEnemyTeamScore = goutil.findChildTextComponent(self.mainGO, "rightCol/txtEnemyTeamScore")
	self._txtEnemyTeamWin = goutil.findChildTextComponent(self.mainGO, "rightCol/txtEnemyTeamWin")
	self._txtEnemyTeamHeat = goutil.findChildTextComponent(self.mainGO, "rightCol/txtEnemyTeamHeat")
	self._enemyTeamHeatIcon = goutil.findChild(self.mainGO, "rightCol/txtEnemyTeamHeat/icon")
	self._txtFightEmpty = goutil.findChildTextComponent(self.mainGO, "rightCol/txtFightEmpty")
	self._txtFighting = goutil.findChildTextComponent(self.mainGO, "rightCol/txtFighting")
	self._resultInRight = goutil.findChild(self.mainGO, "rightCol/result")
	self._txtAddInResult = goutil.findChildTextComponent(self.mainGO, "rightCol/result/txtAdd")
	self._txtWinInResult = goutil.findChildTextComponent(self.mainGO, "rightCol/result/txtWin")
	self._imgWinInResult = goutil.findChild(self.mainGO, "rightCol/result/imgWin")
	self._imgFailInResult = goutil.findChild(self.mainGO, "rightCol/result/imgFail")
	self._btnSearchInResult = goutil.findChild(self.mainGO, "rightCol/result/btnSearch")
	self._btnFmtInRight = goutil.findChild(self.mainGO, "rightCol/btnFmt")
	self._btnAdjustInRight = goutil.findChild(self.mainGO, "rightCol/btnAdjust")

	local enemyScrview = goutil.findChild(self.mainGO, "rightCol/enemyScrview")
	local enemyScrCell = goutil.findChild(self.mainGO, "rightCol/enemyScrCell")

	self._enemyScrollList = ScrollerList.create(enemyScrview, enemyScrCell, GameUtil.handler(self._updateEnemyCell, self), GameUtil.handler(self._clearEnemyCell, self))
	self._pkEffView = goutil.findChild(self.mainGO, "rightCol/pkEffView")
	self._pkEffRoots = GameUtil.getChildren(self._pkEffView)
	self._effRootZuozhan = goutil.findChild(self.mainGO, "rightCol/effRootZuozhan")
end

function ShowDownFinalSceneView:bindEvents()
	ShowDownFinalSceneView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnFmtInRight, GameUtil.handler(self._onClickBtnFmtInRight, self))
	GameUtil.addClickHandler(self._btnAdjustInRight, GameUtil.handler(self._onClickBtnAdjustInRight, self))
	GameUtil.addClickHandler(self._btnSearchInResult, GameUtil.handler(self._onClickBtnSearchInResult, self))
end

function ShowDownFinalSceneView:unbindEvents()
	ShowDownFinalSceneView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnFmtInRight)
	GameUtil.rmClickHandler(self._btnAdjustInRight)
	GameUtil.rmClickHandler(self._btnAdjustInRight)
end

function ShowDownFinalSceneView:onEnter()
	ShowDownFinalSceneView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._activityType = ShowDownController.instance:getActivityType()

	local isInTime = ShowDownController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self:_onUpdateDataByStep()

	self._isNeedVoteInAct = ShowDownController.instance:isNeedGuessInAct(self._activityId)
	self._isPetShopReady = false

	GameUtil.SetActive(self._remainTime, false)
	self.addGEvent(self, GlobalNotify.ShowDownStepChange, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDown_GetScheduleInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDown_GetMainInfoRes, self._handlePM_ShowDown_GetMainInfoRes, self)
	ShowDownController.instance:sendPM_ShowDown_GetScheduleInfoReq(self._activityId)

	if self._curRoundId >= ShowDownEnum.Round_Final_01 and self._curRoundId < ShowDownEnum.Round_Final_Result then
		ShowDownController.instance:sendPM_ShowDown_GetMainInfoReq(self._activityId, -1)
	end
end

function ShowDownFinalSceneView:onExit()
	ShowDownFinalSceneView.super.onExit(self)
	removetimer(self._onTicking, self)
	self:_onClear()
end

function ShowDownFinalSceneView:_handlePM_ShowDown_GetMainInfoRes()
	self._isPetShopReady = true

	self:_onUpdate()
end

function ShowDownFinalSceneView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function ShowDownFinalSceneView:_onUpdateData()
	self:_onUpdateDataByStep()
	self:_onUpdateEnemyTeamsData()
end

function ShowDownFinalSceneView:_onUpdateDataByStep()
	self._curStepId = ShowDownController.instance:getCurStepId(self._activityId)
	self._curRoundId = ShowDownController.instance:getRoundIdByStep(self._activityId, self._curStepId)
	self._scheduleInfo = ShowDownController.instance:getScheduleInfoInFinal(self._activityId)
end

function ShowDownFinalSceneView:_onUpdateUI()
	local isOut = self._curRoundId == ShowDownEnum.Round_Final_Result

	GameUtil.SetActive(self._txtTipsOut.gameObject, isOut)
	GameUtil.SetActive(self._remainTime, not isOut)

	if isOut then
		removetimer(self._onTicking, self)
	else
		local tipsStr = ShowDownController.instance:getShowTipsInStep(self._activityId, self._curStepId)

		self._txtRemainTimeName.text = tipsStr .. "："

		self:_onTicking()
		settimer(1, self._onTicking, self, true)
	end

	self:_onUpdateMemberColUI()
	self:_onUpdateMyTeamUI()
	self:_onUpdateEnemyTeamsUI()
end

function ShowDownFinalSceneView:_onClear()
	self:_onClearMemberCol()
	self:_onClearMyTeam()
	self:_onClearEnemyTeams()
end

function ShowDownFinalSceneView:_onTicking()
	local stamp = ShowDownController.instance:getLeftTimeStampToNext(self._activityId, self._curStepId)

	self._txtRemainTime.text = GameUtil.FormatTimeSymbol(stamp)
end

function ShowDownFinalSceneView:_onUpdateMemberColUI()
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

function ShowDownFinalSceneView:_onClearMemberCol()
	self._memberScrollList:dispose()
end

function ShowDownFinalSceneView:_updateMemberCell(view, cell, headInfo, tag)
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

function ShowDownFinalSceneView:_clearMemberCell(cell)
	local mainGo = cell.gameObject
	local headRoot = goutil.findChild(mainGo, "headRoot")

	HeadItemController.instance:resetHeadCell(headRoot)
end

function ShowDownFinalSceneView:_onUpdateMyTeamUI()
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
	GameUtil.SetActive(self._txtMyTeamHeat, self._isNeedVoteInAct)
end

function ShowDownFinalSceneView:_onClearMyTeam()
	HeadItemController.instance:resetHeadCell(self._captainHeadCell)
	ShowDownController:clearTeamHeadCellRoot(self._teamIconInRight)
	uGuiUtil.clearImage(self._myTeamHeatIcon)
end

function ShowDownFinalSceneView:_onUpdateEnemyTeamsData()
	self._stepMatchViewMoList = self._scheduleInfo:getStepMatchViewMoList()
	self._curSelectEnemyTeamIndex = self._curSelectEnemyTeamIndex or 1
	self._curSelectEnemyTeamIndex = Mathf.Clamp(self._curSelectEnemyTeamIndex, 0, #self._stepMatchViewMoList)
	self._emptyStepMatchViewMo = ShowDownStepMatchViewMo.New()
end

function ShowDownFinalSceneView:_getCurStepMatchViewMo()
	return self._stepMatchViewMoList[self._curSelectEnemyTeamIndex] or self._emptyStepMatchViewMo
end

function ShowDownFinalSceneView:_onUpdateEnemyTeamsUI()
	local curStepMatchViewMo = self:_getCurStepMatchViewMo()
	local stepId = curStepMatchViewMo:getStepId()
	local teamId = curStepMatchViewMo:getTeamId()
	local teamName = curStepMatchViewMo:getTeamName()
	local teamIconId = curStepMatchViewMo:getTeamLogo()
	local result = curStepMatchViewMo:getResult()
	local heatValue = curStepMatchViewMo:getHeatValue()
	local leaderHeadInfo = curStepMatchViewMo:getLeaderHeadInfo()
	local roundId = ShowDownController.instance:getRoundIdByStep(self._activityId, stepId)
	local isEmptyForm = ShowDownController.instance:isEmptyFormInPetShop(self._activityId, roundId, stepId)
	local isShowResult = ShowDownController.instance:isShowResultInStep(self._activityId, self._curStepId)
	local isBattleStep = ShowDownController.instance:isBattleStepInStep(self._activityId, self._curStepId)
	local isCanChangeOrder = ShowDownController.instance:isCanChangeOrderInStep(self._activityId, self._curStepId)
	local curFormPeriod = ShowDownController.instance:getFormPeriodInStep(self._activityId, self._curStepId)
	local isCanFmt = curFormPeriod ~= ShowDownEnum.FormPeriod_None
	local state = 1

	if roundId > self._curRoundId then
		state = 1
	elseif self._curRoundId == roundId then
		if isCanFmt or isCanChangeOrder then
			state = 1
		elseif isBattleStep then
			state = 2
		elseif result then
			state = 3
		end
	elseif roundId < self._curRoundId then
		state = 3
	end

	ShowDownController.instance:setTeamHeadCellRoot(self._teamIconInTeamCell, leaderHeadInfo, self._activityId, teamIconId)

	self._txtNameInTeamCell.text = teamName
	self._txtMyTeamHeatInTeamCell.text = heatValue

	local heatIconPath = ShowDownConfig.instance:getCommonValue(self._activityId, "heatIconPath")
	local spriteName = string.format("%s.png", heatIconPath)

	uGuiUtil.setSpriteToImage(self._myTeamHeatIconInTeamCell, uGuiUtil.SpriteType.BigBg, spriteName)
	GameUtil.SetActive(self._txtMyTeamHeatInTeamCell, self._isNeedVoteInAct)
	GameUtil.SetActive(self._imgFinishFmtInTeamCell, isCanFmt and not isEmptyForm)
	GameUtil.SetActive(self._imgFightingInTeamCell, state == 2)
	GameUtil.SetActive(self._imgLightLine, state == 2)

	if state == 2 then
		self:_startPlayPkEff()
		self:_playZuozhanEff()
	else
		self:_stopPlayPkEff()
		self:_stopZuozhanEff()
	end

	self._enemyScrollList:reloadData(curStepMatchViewMo:getMemberHeadInfoList())

	self._txtEnemyTeamScore.text = curStepMatchViewMo:getTeamViewMo():getMyScore()
	self._txtEnemyTeamWin.text = curStepMatchViewMo:getTeamViewMo():getWinCount()
	self._txtEnemyTeamHeat.text = curStepMatchViewMo:getTeamViewMo():getTeamSimpleViewMo():getHeatValue()

	local heatIconPath = ShowDownConfig.instance:getCommonValue(self._activityId, "heatIconPath")
	local spriteName = string.format("%s.png", heatIconPath)

	uGuiUtil.setSpriteToImage(self._enemyTeamHeatIcon, uGuiUtil.SpriteType.BigBg, spriteName)
	GameUtil.SetActive(self._txtEnemyTeamHeat, self._isNeedVoteInAct)
	GameUtil.SetActive(self._txtFightEmpty.gameObject, state == 1)
	GameUtil.SetActive(self._txtFighting.gameObject, state == 2)
	GameUtil.SetActive(self._resultInRight, state == 3)

	if state == 3 then
		local addScore = curStepMatchViewMo:getMyScore()
		local winCount = curStepMatchViewMo:getWinCount()
		local loseCount = curStepMatchViewMo:getLoseCount()
		local isWin = loseCount < winCount

		self._txtAddInResult.text = addScore
		self._txtWinInResult.text = string.format("%s胜%s负", winCount, loseCount)

		GameUtil.SetActive(self._imgWinInResult, isWin)
		GameUtil.SetActive(self._imgFailInResult, not isWin)
		GameUtil.SetActive(self._imgWinInTeamCell, isWin)
		GameUtil.SetActive(self._imgFailInTeamCell, not isWin)
	else
		GameUtil.SetActive(self._imgWinInTeamCell, false)
		GameUtil.SetActive(self._imgFailInTeamCell, false)
	end

	local fmtResult, _ = self:getTryFmtResultAndTips(self._activityId, stepId)

	GameUtil.SetActive(self._btnFmtInRight, fmtResult == GameEnum.ResultCode.Success)

	local adjustResult, _ = self:getTryAdjustResultAndTips(self._activityId, stepId)

	GameUtil.SetActive(self._btnAdjustInRight, adjustResult == GameEnum.ResultCode.Success)
end

function ShowDownFinalSceneView:_onClearEnemyTeams()
	self._enemyScrollList:dispose()
	uGuiUtil.clearImage(self._myTeamHeatIcon)
	uGuiUtil.clearImage(self._enemyTeamHeatIcon)
	ShowDownController.instance:clearTeamHeadCellRoot(self._teamIconInTeamCell)
	self:_stopPlayPkEff()
	self:_stopZuozhanEff()
end

function ShowDownFinalSceneView:_updateEnemyCell(view, cell, headInfo, tag)
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

function ShowDownFinalSceneView:_clearEnemyCell(cell)
	local mainGo = cell.gameObject
	local headRoot = goutil.findChild(mainGo, "headRoot")

	HeadItemController.instance:resetHeadCell(headRoot)
end

function ShowDownFinalSceneView:_onClickBtnFmtInRight()
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
	else
		printError("未初始化商店信息")
	end
end

function ShowDownFinalSceneView:_onClickBtnSearchInResult()
	local curStepMatchViewMo = self:_getCurStepMatchViewMo()
	local stepId = curStepMatchViewMo:getStepId()
	local otherTeamId = curStepMatchViewMo:getTeamId()
	local roundId = ShowDownController.instance:getRoundIdByStep(self._activityId, stepId)
	local myTeamId = ShowDownController.instance:getMyTeamId(self._activityId, roundId)

	UIStateManager.instance:push(ViewName.ShowDownBattleResutlView, self._activityId, stepId, myTeamId, otherTeamId, true)
end

function ShowDownFinalSceneView:_onClickBtnAdjustInRight()
	local curStepMatchViewMo = self:_getCurStepMatchViewMo()
	local stepId = curStepMatchViewMo:getStepId()
	local enemyTeamId = curStepMatchViewMo:getTeamId()
	local roundId = ShowDownController.instance:getRoundIdByStep(self._activityId, stepId)
	local result, tips = self:getTryAdjustResultAndTips(self._activityId, stepId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	if self._isPetShopReady then
		ShowDownController.instance:opFinalFmtAdjustView(self._activityId, roundId, enemyTeamId, ShowDownEnum.FmtAdjustState_Adjust)
	end
end

function ShowDownFinalSceneView:_startPlayPkEff()
	self._delaySecInPk = 3
	self._oldRandomIdx = 0
	self._curDeltaSecInPk = self._delaySecInPk

	self:_tickingPkEff()
	settimer(1, self._tickingPkEff, self, true)
end

function ShowDownFinalSceneView:_stopPlayPkEff()
	self:_stopPkEff()
	removetimer(self._tickingPkEff, self)
end

function ShowDownFinalSceneView:_tickingPkEff()
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

function ShowDownFinalSceneView:_playPkEff(effParent)
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

function ShowDownFinalSceneView:_stopPkEff()
	if self._pkEff then
		UIEffectManager.instance:stopEffect(self._pkEff)

		self._pkEff = nil
	end
end

function ShowDownFinalSceneView:_playZuozhanEff()
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

function ShowDownFinalSceneView:_stopZuozhanEff()
	if self._zuozhanEff then
		UIEffectManager.instance:stopEffect(self._zuozhanEff)

		self._zuozhanEff = nil
	end
end

function ShowDownFinalSceneView:getTryFmtResultAndTips(activityId, teamStepId)
	local result = GameEnum.ResultCode.Success
	local tips = ""
	local curStepId = ShowDownController.instance:getCurStepId(self._activityId)
	local curRoundId = ShowDownController.instance:getRoundIdByStep(activityId, curStepId)
	local teamRoundId = ShowDownController.instance:getRoundIdByStep(activityId, teamStepId)

	if curRoundId ~= teamRoundId then
		result = GameEnum.ResultCode.Error
		tips = "不在参战阶段内"

		return GameEnum.ResultCode.Error, "不在参战阶段内"
	end

	local formPeriod = ShowDownController.instance:getFormPeriodInStep(self._activityId, curStepId)

	if formPeriod == ShowDownEnum.FormPeriod_None then
		result = GameEnum.ResultCode.Error
		tips = "不是布阵周期"

		return GameEnum.ResultCode.Error, "不是布阵周期"
	end

	return result, tips
end

function ShowDownFinalSceneView:getTryAdjustResultAndTips(activityId, teamStepId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self._scheduleInfo:isLeaderMe() then
		result = GameEnum.ResultCode.Error
		tips = "非队长无法进行调整"

		return GameEnum.ResultCode.Error, "非队长无法进行调整"
	end

	local curStepId = ShowDownController.instance:getCurStepId(self._activityId)
	local curRoundId = ShowDownController.instance:getRoundIdByStep(activityId, curStepId)
	local teamRoundId = ShowDownController.instance:getRoundIdByStep(activityId, teamStepId)

	if curRoundId ~= teamRoundId then
		result = GameEnum.ResultCode.Error
		tips = "不在参战阶段内"

		return GameEnum.ResultCode.Error, "不在参战阶段内"
	end

	local isCanChangeOrder = ShowDownController.instance:isCanChangeOrderInStep(activityId, curStepId)

	if not isCanChangeOrder then
		result = GameEnum.ResultCode.Error
		tips = "不在调整阶段内"

		return GameEnum.ResultCode.Error, "不在调整阶段内"
	end

	return result, tips
end

return ShowDownFinalSceneView
