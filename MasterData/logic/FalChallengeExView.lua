-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/landlords/view/FalChallengeExView.lua

module("logic.extensions.landlords.view.FalChallengeExView", package.seeall)

local FalChallengeExView = class("FalChallengeExView", ViewComponent)

function FalChallengeExView:buildUI()
	FalChallengeExView.super.buildUI(self)

	self._playerView = goutil.findChild(self.mainGO, "playerView")
	self._playerViewRecordPosComp = self._playerView:GetComponent(typeof(TestRecordPos))
	self._playerCellList = {}

	for i = 1, self._playerView.transform.childCount do
		local mainGo = self._playerView.transform:GetChild(i - 1)
		local cell = {}

		cell._mainGo = mainGo
		cell._headIcon = goutil.findChild(mainGo, "headIcon")
		cell._name = goutil.findChildTextComponent(mainGo, "name/txt")
		cell._select = goutil.findChild(mainGo, "select")
		cell._sure = goutil.findChild(mainGo, "sure")
		cell._bubble = goutil.findChild(mainGo, "bubble")
		cell._txtBubble = goutil.findChildTextComponent(mainGo, "bubble/txt")

		table.insert(self._playerCellList, cell)
	end

	self._periodInfo = goutil.findChild(self.mainGO, "periodInfo")
	self._clockEffRoot = goutil.findChild(self.mainGO, "periodInfo/clockEffRoot")
	self._clockGo = goutil.findChild(self.mainGO, "periodInfo/clock")
	self._txtClockTime = goutil.findChildTextComponent(self.mainGO, "periodInfo/clock/txtClockTime")
	self._txtPeriod = goutil.findChildTextComponent(self.mainGO, "periodInfo/period/txt")
	self._txtGain = goutil.findChild(self.mainGO, "gain/txt")
	self._btnStart = goutil.findChild(self.mainGO, "btnStart")
	self._btnStartLock = goutil.findChild(self.mainGO, "btnStart/lock")
	self._petNum = goutil.findChild(self.mainGO, "petNum")
	self._txtPetNum = goutil.findChildTextComponent(self.mainGO, "petNum/txt")
	self._petBagmask = goutil.findChild(self.mainGO, "petBagmask")

	local leftCpCol = goutil.findChild(self.mainGO, "leftCpCol")
	local rightCpCol = goutil.findChild(self.mainGO, "rightCpCol")

	self._cpCols = {
		leftCpCol,
		rightCpCol
	}
	self._cpScrollLists = {}
	self._btnBuffs = {}
	self._cpBubbles = {}

	for idx, teamId in ipairs({
		0,
		1
	}) do
		local cpCol = self._cpCols[idx]
		local cpScrollerview = goutil.findChild(cpCol, "cpScrollerview")
		local cpScrollercell = goutil.findChild(cpCol, "cpScrollercell")

		self._cpScrollLists[teamId] = ScrollerList.create(cpScrollerview, cpScrollercell, GameUtil.handler(self._updateCpCell, self), GameUtil.handler(self._clearCpCell, self))

		local cell = {}
		local mainGo = goutil.findChild(cpCol, "cpScrollerview/Viewport/Content/btnBuff")

		cell._mainGo = mainGo
		cell._icon = goutil.findChild(mainGo, "icon")
		cell._txtName = goutil.findChildTextComponent(mainGo, "name/txt")
		self._btnBuffs[teamId] = cell

		local cell = {}

		cell._mainGo = goutil.findChild(cpCol, "cpBubble")
		cell._txtDesc = goutil.findChildTextComponent(cpCol, "cpBubble/txt")
		self._cpBubbles[teamId] = cell
	end

	self._imgScore = goutil.findChild(self.mainGO, "scoreInfo/imgScore"):GetComponent(ComponentType.UIImgNumeralText)
	self._chatCol = goutil.findChild(self.mainGO, "chatCol")
	self._btnChat = goutil.findChild(self.mainGO, "chatCol/btnChat")
	self._chatList = goutil.findChild(self.mainGO, "chatCol/chatList")
	self._chatScrollerview = goutil.findChild(self.mainGO, "chatCol/chatList/chatScrollerview")
	self._chatScrollercell = goutil.findChild(self.mainGO, "chatCol/chatList/chatScrollercell")
	self._chatScrollList = ScrollerList.create(self._chatScrollerview, self._chatScrollercell, GameUtil.handler(self._updateChatCell, self), GameUtil.handler(self._clearChatCell, self))
	self._chatViewUiCustonInput = UICustomInput.Get(self._chatScrollerview)
end

function FalChallengeExView:bindEvents()
	FalChallengeExView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnStart, self._onClickBtnStart, self)
	GameUtil.addClickHandler(self._btnChat, function()
		self:_onClickBtnChat(false)
	end, self)
	self._chatViewUiCustonInput:AddListener(self._onClickBtnChat, self)
end

function FalChallengeExView:unbindEvents()
	FalChallengeExView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnStart)
	GameUtil.rmClickHandler(self._btnChat)
	self._chatViewUiCustonInput:RemoveListener()
end

function FalChallengeExView:onEnter()
	FalChallengeExView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._customFmtMo = params[1]
	self._falGameMo = FightAgainstLandlordsController.instance:getFalGameMo()
	self._activityId = self._falGameMo:getActivityId()
	self._gameId = self._falGameMo:getGameId()
	self._resultMsg = nil
	self._myUserId = FightAgainstLandlordsController.instance:getMyUserId()

	self:_initPlayerInfoList()
	self:_startNewRound()
	self:_onUpdateChatColUI()
	GlobalDispatcher:addListener(GlobalNotify.handlePM_LandlordsPKNotifyLandlordsFormSetRes, self._startNewRound, self)
	GlobalDispatcher:addListener(GlobalNotify.handlePM_LandlordsPKNotifyLandlordsFormShowRes, self._handleFormShowRes, self)
	GlobalDispatcher:addListener(GlobalNotify.handlePM_LandlordsPKNotifyBattleResultRes, self._handleBattleResultRes, self)
	GlobalDispatcher:addListener(GlobalNotify.handlePM_LandlordsPKFormSetRes, self._handlePM_LandlordsPKFormSetRes, self)
	GlobalDispatcher:addListener(GlobalNotify.handlePM_LandlordsPKNotifyChatRes, self._handleNotifyChatRes, self)
	GlobalDispatcher:addListener(GlobalNotify.NotifyCpAndBuffUpdateInFalFmt, self._handleNotifyCpAndBuffUpdateInFalFmt, self)
	self._imgScore:SetNum(self._falGameMo:getProfit(self._myUserId))
end

function FalChallengeExView:onExit()
	FalChallengeExView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.handlePM_LandlordsPKNotifyLandlordsFormSetRes, self._startNewRound, self)
	GlobalDispatcher:removeListener(GlobalNotify.handlePM_LandlordsPKNotifyLandlordsFormShowRes, self._handleFormShowRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.handlePM_LandlordsPKNotifyBattleResultRes, self._handleBattleResultRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.handlePM_LandlordsPKFormSetRes, self._handlePM_LandlordsPKFormSetRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.handlePM_LandlordsPKNotifyChatRes, self._handleNotifyChatRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.NotifyCpAndBuffUpdateInFalFmt, self._handleNotifyCpAndBuffUpdateInFalFmt, self)
	removetimer(self._endFormShowTicking, self)
	self:_onClearCpColUI()
	self:_onClearChatColUI()
	self:_stopBubbleTimer()
	self:_stopBuffBubbleTimer()
	self:_stopFmtClock()
	self:_clearCpIdListInFmt()
	self:_clearAllCpActEff()
end

function FalChallengeExView:_startNewRound()
	self:_setNeedUpPetCount(self._falGameMo:getMaxPetNumAllPlayerInFmt(self._falGameMo:getRoundId(), self._falGameMo:getIdentity(self._myUserId)))
	self:_setLeftSimpleForm(self._falGameMo:getSimpleFormByTeamId(0))
	self:_setRightSimpleForm(self._falGameMo:getSimpleFormByTeamId(1))

	local opPlayerIds = self._falGameMo:getCurOpUserIdListInLeft()
	local isHasMe = table.indexof(opPlayerIds, self._myUserId)

	self:_setForbitType(not isHasMe)

	for _, infoList in pairs(self._playerInfoList) do
		for _, info in ipairs(infoList) do
			local state = self:_getOpState(info.userId)

			if state == 1 then
				self:_setOpState(info.userId, 2)
			end
		end
	end

	for _, userId in ipairs(opPlayerIds) do
		self:_setOpState(userId, 1)
	end

	self:_updateFmt()
	self:_startFmtClock(self._falGameMo:getWaitSecondInFight())

	self._txtPeriod.text = string.format("布阵阶段 %s/%s", self._falGameMo:getRoundId(), 2)

	self:_onUpdatePlayerColUI()
	self:_onUpdateCpColUI()
	self:_onUpdatePlaneUI()
end

function FalChallengeExView:_handleFormShowRes()
	for _, infoList in pairs(self._playerInfoList) do
		for _, info in ipairs(infoList) do
			self:_setOpState(info.userId, 2)
		end
	end

	self:_setLeftSimpleForm(self._falGameMo:getSimpleFormByTeamId(0))
	self:_setRightSimpleForm(self._falGameMo:getSimpleFormByTeamId(1))
	self:_setForbitType(true)
	self:_updateFmt()
	self:_stopFmtClock()
	self:_onUpdatePlayerColUI()
	self:_onUpdateCpColUI()
	self:_onUpdatePlaneUI()

	self._isFormShowEnd = false

	settimer(5, self._endFormShowTicking, self, false)
end

function FalChallengeExView:_handleBattleResultRes(resultMsg)
	self._resultMsg = resultMsg

	if self._isFormShowEnd == true then
		self:_endFormShowTicking()
	end
end

function FalChallengeExView:_endFormShowTicking()
	self._isFormShowEnd = true

	if self._resultMsg == nil then
		return
	end

	BattleModel.instance:setLeftTeamId(self._resultMsg.myTeamId)
	BattleController.instance:viewUserFightMonsterBtlResult(self._resultMsg.battleResult, false)
end

function FalChallengeExView:_handlePM_LandlordsPKFormSetRes()
	self:_setOpState(self._myUserId, 2)
	self:_setLeftSimpleForm(self._customFmtMo:getCurSimpleForm())
	self:_setForbitType(true)
	self:_updateFmt()
	self:_onUpdatePlayerColUI()
	self:_onUpdatePlaneUI()
	FloatWordMgr.instance:show("确认成功")
end

function FalChallengeExView:_handleNotifyCpAndBuffUpdateInFalFmt()
	self:_onUpdateCpColUI()
	self:_onUpdatePlaneUI()
end

function FalChallengeExView:_setLeftSimpleForm(simpleForm)
	self._customFmtMo:updateFormationMoBySimpleForm(simpleForm, 0)
end

function FalChallengeExView:_setRightSimpleForm(simpleForm)
	self._customFmtMo:updateFormationMoBySimpleForm(simpleForm, 1)
end

function FalChallengeExView:_setForbitType(isToForbit)
	self._customFmtMo:setForbitType(isToForbit)
end

function FalChallengeExView:_setNeedUpPetCount(count)
	self._customFmtMo:setNeedUpPetCount(count)
end

function FalChallengeExView:_updateFmt()
	self._customFmtMo:_updateFmt()
end

function FalChallengeExView:_initPlayerInfoList()
	self._playerInfoList = {}
	self._playerInfoList.left = {}
	self._playerInfoList.right = {}

	local userIdList = self._falGameMo:getPlayerUserIdList()

	for _, userId in ipairs(userIdList) do
		local info = {}

		info.userId = userId
		info.opState = 0

		if self._falGameMo:getTeamId(info.userId) == 0 then
			table.insert(self._playerInfoList.left, info)
		else
			table.insert(self._playerInfoList.right, info)
		end
	end

	local cellIdx = 0

	for _, infoList in ipairs({
		self._playerInfoList.left,
		self._playerInfoList.right
	}) do
		for _, info in ipairs(infoList) do
			cellIdx = cellIdx + 1

			local cell = self._playerCellList[cellIdx]

			if cell == nil then
				printError("预制不足")
			end

			info.cell = cell
		end
	end
end

function FalChallengeExView:_getPlayerInfo(userId)
	local playerInfo

	for _, infoList in pairs(self._playerInfoList) do
		for _, info in ipairs(infoList) do
			if info.userId == userId then
				playerInfo = info

				break
			end
		end
	end

	return playerInfo
end

function FalChallengeExView:_getOpState(userId)
	local playerInfo = self:_getPlayerInfo(userId)

	return playerInfo.opState
end

function FalChallengeExView:_setOpState(userId, state)
	local playerInfo = self:_getPlayerInfo(userId)

	playerInfo.opState = state
end

function FalChallengeExView:_startFmtClock(waitSecond)
	self:_stopFmtClock()
	GameUtil.SetActive(self._clockGo, true)
	GameUtil.SetActive(self._clockEffRoot, false)

	self._startFmtClockTime = UnityEngine.Time.realtimeSinceStartup
	self._waitSecondInFmtClock = waitSecond

	settimer(0, self._fmtClockTicking, self)
end

function FalChallengeExView:_stopFmtClock()
	self:_stopFmtClockTicking()
	self:_stopFmtClockEff()
end

function FalChallengeExView:_stopFmtClockTicking()
	removetimer(self._fmtClockTicking, self)

	self._txtClockTime.text = string.format("%sS", 0)
end

function FalChallengeExView:_fmtClockTicking()
	self._leftSecondInFmtClock = self._waitSecondInFmtClock - math.floor(UnityEngine.Time.realtimeSinceStartup - self._startFmtClockTime)
	self._txtClockTime.text = string.format("%sS", Mathf.Max(self._leftSecondInFmtClock, 0))

	if self._leftSecondInFmtClock <= 6 then
		self:_stopFmtClockTicking()
		self:_playFmtClockEff()
	end
end

function FalChallengeExView:_playFmtClockEff()
	GameUtil.SetActive(self._clockGo, false)
	GameUtil.SetActive(self._clockEffRoot, true)

	local effParent = self._clockEffRoot
	local pathName = "20230210/doudizhu/fx_ui_doudizhu_daojishi"

	UIEffectManager.instance:stopEffect(self._myClockEff)

	if effParent and not string.nilorempty(pathName) then
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

		self._myClockEff = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, false, false, finishHandler, loadedHandler, handlerTarget)
	end
end

function FalChallengeExView:_stopFmtClockEff()
	GameUtil.SetActive(self._clockEffRoot, false)
	UIEffectManager.instance:stopEffect(self._myClockEff)
end

function FalChallengeExView:_onUpdatePlayerColUI()
	local myIdentity = self._falGameMo:getIdentity(self._myUserId)

	self._playerViewRecordPosComp:LoadPlan((myIdentity == GameEnum.FalIdentity.Landlord or nil) and 1)

	for _, infoList in pairs(self._playerInfoList) do
		for _, info in ipairs(infoList) do
			local cell = info.cell
			local headInfo = self._falGameMo:getHeadInfo(info.userId)

			if headInfo then
				HeadItemController.instance:setHeadCellByInfo(cell._headIcon, headInfo)

				cell._name.text = headInfo.userName
			end

			self:_loadLandSelectEff(cell._select, info.userId)
			self:_loadLandSureEff(cell._sure, info.userId)

			local opState = self:_getOpState(info.userId)

			if opState == 0 then
				GameUtil.SetActive(cell._select, false)
				GameUtil.SetActive(cell._sure, false)
			elseif opState == 1 then
				GameUtil.SetActive(cell._select, true)
				GameUtil.SetActive(cell._sure, false)
			elseif opState == 2 then
				GameUtil.SetActive(cell._select, false)
				GameUtil.SetActive(cell._sure, true)
			end
		end
	end
end

function FalChallengeExView:_onClearPlayerColUI()
	for _, infoList in pairs(self._playerInfoList) do
		for _, info in ipairs(infoList) do
			HeadItemController.instance:resetHeadCell(info.cell._headIcon)
		end
	end

	self:_clearLandSelectEff()
	self:_clearLandSureEff()
end

function FalChallengeExView:_loadLandSelectEff(mainGo, userId)
	local effParent = mainGo
	local pathName = "20230210/doudizhu2/fx_ui_doudizhu_quan_cheng"

	if effParent and not string.nilorempty(pathName) then
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

		if self._selectEffList == nil then
			self._selectEffList = {}
		end

		if self._selectEffList[userId] == nil then
			self._selectEffList[userId] = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, true, false, finishHandler, loadedHandler, handlerTarget)
		end
	end
end

function FalChallengeExView:_stopLandSelectEff(userId)
	if self._selectEffList then
		UIEffectManager.instance:stopEffect(self._selectEffList[userId])

		self._selectEffList[userId] = nil
	end
end

function FalChallengeExView:_clearLandSelectEff()
	if self._selectEffList == nil then
		return
	end

	for _, eff in pairs(self._selectEffList) do
		UIEffectManager.instance:stopEffect(eff)
	end

	table.clear(self._selectEffList)
end

function FalChallengeExView:_loadLandSureEff(mainGo, userId)
	local effParent = mainGo
	local pathName = "20230210/doudizhu2/fx_ui_doudizhu_quan_lv"

	if effParent and not string.nilorempty(pathName) then
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

		if self._sureEffList == nil then
			self._sureEffList = {}
		end

		if self._sureEffList[userId] == nil then
			self._sureEffList[userId] = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, true, false, finishHandler, loadedHandler, handlerTarget)
		end
	end
end

function FalChallengeExView:_stopLandSureEff(userId)
	if self._sureEffList then
		UIEffectManager.instance:stopEffect(self._sureEffList[userId])

		self._sureEffList[userId] = nil
	end
end

function FalChallengeExView:_clearLandSureEff()
	if self._sureEffList == nil then
		return
	end

	for _, eff in pairs(self._sureEffList) do
		UIEffectManager.instance:stopEffect(eff)
	end

	table.clear(self._sureEffList)
end

function FalChallengeExView:_onUpdateCpColUI()
	for idx, teamId in ipairs({
		0,
		1
	}) do
		local userIdList = self._falGameMo:getUserIdListAsSameTeam(teamId)
		local bagPetList = self._falGameMo:getBagCreepsIdsAsSameTeam(teamId)
		local cpIdList = FightAgainstLandlordsController.instance:getCpIdListOfAnd(self._activityId, bagPetList)
		local infoList = {}

		for _, cpId in ipairs(cpIdList) do
			local info = {}

			info.cpId = cpId
			info.teamId = teamId

			table.insert(infoList, info)
		end

		self._cpScrollLists[teamId]:reloadData(infoList)

		local buffIds = self._falGameMo:getBuffIdsAsSameTeam(teamId)
		local buffId = checknumber(buffIds[1])
		local buffData = FightAgainstLandlordsConfig.instance:getFalBuffData(self._activityId, buffId)
		local btnBuff = self._btnBuffs[teamId]

		GameUtil.SetActive(btnBuff._mainGo, buffData ~= nil)

		if buffData then
			local path = buffData.iconPath
			local bgGo = btnBuff._icon

			if not string.nilorempty(path) and bgGo then
				local spriteType = uGuiUtil.SpriteType.BigBg
				local spriteName = string.format("ui/%s.png", path)

				local function func()
					return
				end

				uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
			else
				uGuiUtil.clearImage(bgGo)
			end

			btnBuff._txtName.text = buffData.name

			GameUtil.addClickHandler(btnBuff._mainGo, GameUtil.handler(self._showBuffTips, self, buffId, teamId), self)
		end
	end

	for idx, teamId in ipairs({
		0,
		1
	}) do
		self:_hideBuffTips(teamId)
	end
end

function FalChallengeExView:_onClearCpColUI()
	for idx, teamId in ipairs({
		0,
		1
	}) do
		self._cpScrollLists[teamId]:dispose()

		local btnBuff = self._btnBuffs[teamId]

		uGuiUtil.clearImage(btnBuff._icon)
		GameUtil.rmClickHandler(btnBuff._mainGo)
	end
end

function FalChallengeExView:_updateCpCell(view, cell, info, tag)
	local cpId = info.cpId
	local teamId = info.teamId
	local fmtPetIdList = self._customFmtMo:getPetIdListOfFmt(teamId)
	local cpData = FightAgainstLandlordsConfig.instance:getFalCpData(self._activityId, cpId)
	local buffId = cpData.buffIds[1]
	local buffData = FightAgainstLandlordsConfig.instance:getFalBuffData(self._activityId, buffId)
	local mainGo = cell.gameObject
	local imgAixin = goutil.findChild(mainGo, "aixin/img")
	local petView = goutil.findChild(mainGo, "petView")
	local pet_1 = goutil.findChild(mainGo, "petView/pet_1")
	local pet_2 = goutil.findChild(mainGo, "petView/pet_2")

	for idx, go in ipairs({
		pet_1,
		pet_2
	}) do
		local headIcon = goutil.findChild(go, "headIcon")
		local mask = goutil.findChild(go, "mask")
		local creepsId = checknumber(cpData.creepsIds[idx])
		local creepsData = FightAgainstLandlordsConfig.instance:getFalCreepsData(creepsId)

		if creepsData then
			local skinId = checknumber(creepsData.faceId)

			if skinId == 0 then
				skinId = creepsData.raceId
			end

			MaterialMgr.setIcon(headIcon, MatType.Pet, skinId, nil, nil)
		end

		GameUtil.SetActive(mask, table.indexof(fmtPetIdList, creepsId) == false)
	end

	local isFit = true

	for _, creepsId in ipairs(cpData.creepsIds) do
		isFit = isFit and table.indexof(fmtPetIdList, creepsId) ~= false
	end

	if isFit and not self:_isHasActOfTheCp(cpId) then
		self:_setCpNode(true, cpId)
		self:_playCpActEff(mainGo)
	else
		self:_stopCpActEff(mainGo)
	end

	local comp = imgAixin:GetComponent("Image")

	if comp then
		comp.color = FightAgainstLandlordsController.instance:getColorByCpId(self._activityId, cpId)
	end

	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._showBuffTips, self, buffId, teamId), self)
end

function FalChallengeExView:_clearCpCell(cell)
	local mainGo = cell.gameObject
	local petView = goutil.findChild(mainGo, "petView")
	local pet_1 = goutil.findChild(mainGo, "petView/pet_1")
	local pet_2 = goutil.findChild(mainGo, "petView/pet_2")

	for idx, go in ipairs({
		pet_1,
		pet_2
	}) do
		local headIcon = goutil.findChild(go, "headIcon")

		MaterialMgr.resetAll(headIcon)
	end

	GameUtil.rmClickHandler(mainGo)
end

function FalChallengeExView:_showBuffTips(buffId, teamId)
	local buffData = FightAgainstLandlordsConfig.instance:getFalBuffData(self._activityId, buffId)

	if buffData == nil then
		return
	end

	if self._buffBubbleInfos == nil then
		self._buffBubbleInfos = {}

		for idx, teamId in ipairs({
			0,
			1
		}) do
			self._buffBubbleInfos[teamId] = {}
			self._buffBubbleInfos[teamId].curTime = 0
		end
	end

	self._buffBubbleInfos[teamId].curTime = 3

	self:_stopBuffBubbleTimer()

	local bubble = self._cpBubbles[teamId]

	bubble._txtDesc.text = buffData.desc

	GameUtil.SetActive(bubble._mainGo, true)

	self._buffBubbleDelta = 0.5

	settimer(self._buffBubbleDelta, self._buffTipsTicking, self)
end

function FalChallengeExView:_stopBuffBubbleTimer()
	removetimer(self._buffTipsTicking, self)
end

function FalChallengeExView:_buffTipsTicking()
	local opNum = 0

	for idx, teamId in ipairs({
		0,
		1
	}) do
		local curTime = self._buffBubbleInfos[teamId].curTime

		if curTime > 0 then
			local leftTime = Mathf.Max(curTime - self._buffBubbleDelta, 0)

			self._buffBubbleInfos[teamId].curTime = leftTime

			if leftTime <= 0 then
				self:_hideBuffTips(teamId)
			end

			opNum = opNum + 1
		end
	end

	if opNum == 0 then
		self:_stopBuffBubbleTimer()
	end
end

function FalChallengeExView:_hideBuffTips(teamId)
	local bubble = self._cpBubbles[teamId]

	GameUtil.SetActive(bubble._mainGo, false)
end

function FalChallengeExView:_setCpNode(isAdd, cpId)
	if self._cpIdListInFmt == nil then
		self._cpIdListInFmt = {}
	end

	if isAdd then
		if table.indexof(self._cpIdListInFmt, cpId) == false then
			table.insert(self._cpIdListInFmt, cpId)
		end
	else
		table.removebyvalue(self._cpIdListInFmt, cpId, true)
	end
end

function FalChallengeExView:_isHasActOfTheCp(cpId)
	return (self._cpIdListInFmt or nil) and table.indexof(self._cpIdListInFmt, cpId) ~= false
end

function FalChallengeExView:_clearCpIdListInFmt()
	if self._cpIdListInFmt then
		table.clear(self._cpIdListInFmt)

		self._cpIdListInFmt = nil
	end
end

function FalChallengeExView:_playCpActEff(mainGo)
	self:_stopCpActEff(mainGo)

	if self._cpActInfoList == nil then
		self._cpActInfoList = {}
	end

	local info = {}

	info.curNum = 0
	info.totalNum = 5
	info.mainGo = mainGo
	self._cpActInfoList[mainGo] = info

	GameUtil.SetActive(mainGo, true)

	self._cpActLightDelta = 0.1

	settimer(self._cpActLightDelta, self._cpActTicking, self)
end

function FalChallengeExView:_stopCpActEff(mainGo)
	if self._cpActInfoList then
		self._cpActInfoList[mainGo] = nil
	end
end

function FalChallengeExView:_cpActTicking()
	self._opNumInCpActTicking = 0
	self._recoveryKeyList = {}

	for k, info in pairs(self._cpActInfoList) do
		self._opNumInCpActTicking = self._opNumInCpActTicking + 1
		info.curNum = info.curNum + 1

		GameUtil.SetActive(info.mainGo, info.curNum % 2 == 1)

		if info.curNum >= info.totalNum then
			table.insert(self._recoveryKeyList, k)
		end
	end

	for _, key in ipairs(self._recoveryKeyList) do
		self:_stopCpActEff(key)
	end

	if self._opNumInCpActTicking == 0 then
		self:_clearAllCpActEff()
	end
end

function FalChallengeExView:_clearAllCpActEff()
	removetimer(self._cpActTicking, self)

	if self._cpActInfoList then
		table.clear(self._cpActInfoList)
	end
end

function FalChallengeExView:_onUpdateChatColUI()
	local dataList = {}
	local cfg = FightAgainstLandlordsConfig.instance:getFalChatCfg()
	local chatScence = 2
	local myIdentity = self._falGameMo:getIdentity(self._myUserId)

	for _, data in ipairs(cfg) do
		if FightAgainstLandlordsController.instance:isFitTheChat(data.chatId, chatScence, myIdentity) then
			table.insert(dataList, data)
		end
	end

	self._chatScrollList:reloadData(dataList)

	local userIdList = self._falGameMo:getPlayerUserIdList()

	for _, userId in ipairs(userIdList) do
		self:_hideBubble(userId)
	end
end

function FalChallengeExView:_onClearChatColUI()
	self._chatScrollList:dispose()
end

function FalChallengeExView:_updateChatCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")

	txtName.text = data.value

	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._clickChatCell, self, mainGo, data.chatId))
end

function FalChallengeExView:_clearChatCell(cell)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)
end

function FalChallengeExView:_clickChatCell(mainGo, chatId)
	FightAgainstLandlordsController.instance:sendPM_LandlordsPKChatReq(chatId)
	self:_onClickBtnChat(false)
end

function FalChallengeExView:_onClickBtnChat(hover)
	if not hover then
		GameUtil.SetActive(self._chatList, not GameUtil.GetActive(self._chatList))
	end
end

function FalChallengeExView:_handleNotifyChatRes(msg)
	local chatScence = 2
	local identity = self._falGameMo:getIdentity(self._myUserId)
	local isFit = FightAgainstLandlordsController.instance:isFitTheChat(msg.chatId, chatScence, identity)

	if not isFit then
		return
	end

	if self._bubbleInfoListGroup == nil then
		self._bubbleInfoListGroup = {}

		local userIdList = self._falGameMo:getPlayerUserIdList()

		for _, userId in ipairs(userIdList) do
			self._bubbleInfoListGroup[userId] = {}
		end
	end

	local info = {}

	info.msg = msg
	info.totalSec = 3
	info.curSec = 0
	info.isShowing = false
	info.speed = 1.5

	table.insert(self._bubbleInfoListGroup[msg.sendUserId], info)

	self._bubbleDelta = 0.1

	settimer(self._bubbleDelta, self._bubbleTicking, self)
end

function FalChallengeExView:_stopBubbleTimer()
	removetimer(self._bubbleTicking, self)
end

function FalChallengeExView:_bubbleTicking()
	local trash = {}
	local taskCount = 0

	for _, infoList in pairs(self._bubbleInfoListGroup) do
		local listLength = #infoList
		local info = infoList[1]

		if info then
			taskCount = taskCount + 1

			if info.curSec >= info.totalSec then
				if trash[info.msg.sendUserId] == nil then
					trash[info.msg.sendUserId] = {}
				end

				table.insert(trash[info.msg.sendUserId], info)
			end

			info.curSec = listLength > 0 and info.curSec + self._bubbleDelta * info.speed or info.curSec + self._bubbleDelta

			if not info.isShowing then
				info.isShowing = true

				self:_showBubble(info.msg.sendUserId, info.msg.chatId)
			end
		end
	end

	for _, infoList in pairs(trash) do
		for _, info in ipairs(infoList) do
			local userId = info.msg.sendUserId

			table.removebyvalue(self._bubbleInfoListGroup[userId], info)
			self:_hideBubble(userId)
		end
	end

	if taskCount <= 0 then
		self:_stopBubbleTimer()
	end
end

function FalChallengeExView:_showBubble(userId, chatId)
	local info = self:_getPlayerInfo(userId)
	local cell = info.cell

	GameUtil.SetActive(cell._bubble, true)

	local data = FightAgainstLandlordsConfig.instance:getFalChatData(chatId)

	if data then
		cell._txtBubble.text = data.value
	end
end

function FalChallengeExView:_hideBubble(userId)
	local info = self:_getPlayerInfo(userId)
	local cell = info.cell

	GameUtil.SetActive(cell._bubble, false)
end

function FalChallengeExView:_onUpdatePlaneUI()
	local roundId = self._falGameMo:getRoundId()
	local opState = self:_getOpState(self._myUserId)
	local isInOpState = opState == 1
	local maxPetNumOnePlayer = self._falGameMo:getMaxPetNumOnePlayerInFmt(roundId, self._falGameMo:getIdentity(self._myUserId))
	local allPetNumInFmt = self._customFmtMo:getAllPetNumInFmt(self._falGameMo:getTeamId(self._myUserId))
	local myPetNumInFmt = self._customFmtMo:getMyPetNumInFmt(self._myUserId, roundId)

	self._txtPetNum.text = string.format("可上阵精灵：<color=%s>%s</color>/%s", (allPetNumInFmt < maxPetNumOnePlayer or nil) and "#CE5553FF", myPetNumInFmt, maxPetNumOnePlayer)

	GameUtil.SetActive(self._petNum, isInOpState)
	GameUtil.SetActive(self._btnStartLock, not isInOpState)
	GameUtil.SetActive(self._petBagmask, not isInOpState)
end

function FalChallengeExView:_onClickBtnStart()
	local opState = self:_getOpState(self._myUserId)

	if opState == 1 then
		local roundId = self._falGameMo:getRoundId()
		local myPetNumInFmt = self._customFmtMo:getMyPetNumInFmt(self._myUserId, roundId)

		if myPetNumInFmt <= 0 then
			FloatWordMgr.instance:show("没有上阵精灵，请至少上阵一只")
		else
			local simpleForm = self._customFmtMo:getCurSimpleForm()

			FightAgainstLandlordsController.instance:sendPM_LandlordsPKFormSetReq(simpleForm)
		end
	else
		FloatWordMgr.instance:show("当前已锁定，不可操作")
	end
end

return FalChallengeExView
