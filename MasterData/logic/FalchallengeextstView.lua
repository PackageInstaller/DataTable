-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/landlords/view/FalchallengeextstView.lua

module("logic.extensions.landlords.view.FalchallengeextstView", package.seeall)

local FalchallengeextstView = class("FalchallengeextstView", ViewComponent)

function FalchallengeextstView:buildUI()
	FalchallengeextstView.super.buildUI(self)

	self._playerView = goutil.findChild(self.mainGO, "playerView")
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
	self._btnStartLock = goutil.findChild(self.mainGO, "lock")
	self._btnStart = self:getGo("btnSave")
	self._btnCheck = self:getBtn("btnCheck")
	self._imgScore = goutil.findChild(self.mainGO, "scoreInfo/imgScore"):GetComponent(ComponentType.UIImgNumeralText)
	self._chatCol = goutil.findChild(self.mainGO, "chatCol")
	self._btnChat = goutil.findChild(self.mainGO, "chatCol/btnChat")
	self._chatList = goutil.findChild(self.mainGO, "chatCol/chatList")
	self._chatScrollerview = goutil.findChild(self.mainGO, "chatCol/chatList/chatScrollerview")
	self._chatScrollercell = goutil.findChild(self.mainGO, "chatCol/chatList/chatScrollercell")
	self._chatScrollList = ScrollerList.create(self._chatScrollerview, self._chatScrollercell, GameUtil.handler(self._updateChatCell, self), GameUtil.handler(self._clearChatCell, self))
	self._chatViewUiCustonInput = UICustomInput.Get(self._chatScrollerview)
end

function FalchallengeextstView:bindEvents()
	FalchallengeextstView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnStart, self._onClickBtnStart, self)
	GameUtil.addClickHandler(self._btnChat, function()
		self:_onClickBtnChat(false)
	end, self)
	self._chatViewUiCustonInput:AddListener(self._onClickBtnChat, self)
	self._btnCheck:AddClickListener(self._onClickbtnCheck, self)
end

function FalchallengeextstView:unbindEvents()
	FalchallengeextstView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnStart)
	GameUtil.rmClickHandler(self._btnChat)
	self._chatViewUiCustonInput:RemoveListener()
	self._btnCheck:RemoveClickListener()
end

function FalchallengeextstView:onEnter()
	FalchallengeextstView.super.onEnter(self)

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

function FalchallengeextstView:onExit()
	FalchallengeextstView.super.onExit(self)
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

	self._isPlayFmtClock = false
end

function FalchallengeextstView:_startNewRound()
	self:_updateFmt()
	self:_startFmtClock(self._falGameMo:getWaitSecondInFight() - 2)

	self._txtPeriod.text = "布阵阶段"

	self:_onUpdatePlayerColUI()
	self:_onUpdateCpColUI()
	self:_onUpdatePlaneUI()
end

function FalchallengeextstView:_handleFormShowRes()
	for _, infoList in pairs(self._playerInfoList) do
		for _, info in ipairs(infoList) do
			self:_setOpState(info.userId, 2)
		end
	end

	self:_stopFmtClock()
	self:_onUpdatePlayerColUI()
	self:_onUpdateCpColUI()
	self:_onUpdatePlaneUI()

	self._isFormShowEnd = false

	settimer(5, self._endFormShowTicking, self, false)
end

function FalchallengeextstView:_handleBattleResultRes(resultMsg)
	self._resultMsg = resultMsg

	if self._isFormShowEnd == true then
		self:_endFormShowTicking()
	end
end

function FalchallengeextstView:_endFormShowTicking()
	self._isFormShowEnd = true

	if self._resultMsg == nil then
		return
	end

	local btlResultList = {}

	if not self._resultMsg.resultItems then
		local items = {}

		for i, item in ipairs(self._resultMsg.resultItems) do
			table.insert(btlResultList, item.battleResult)
		end

		BattleModel.instance:setLeftTeamId(self._resultMsg.resultItems[1].myTeamId)
		BattleController.instance:viewUserFightMonsterBtlResultWithList(btlResultList, function(idx)
			local item = items[idx]

			BattleModel.instance:setLeftTeamId(item.myTeamId)
		end)
	end
end

function FalchallengeextstView:_handlePM_LandlordsPKFormSetRes()
	self:_setOpState(self._myUserId, 2)
	self:_setLeftSimpleForm(self._customFmtMo:getCurSimpleForm())
	self:_setForbitType(true)
	self:_updateFmt()
	self:_onUpdatePlayerColUI()
	self:_onUpdatePlaneUI()
	FloatWordMgr.instance:show("确认成功")
end

function FalchallengeextstView:_handleNotifyCpAndBuffUpdateInFalFmt()
	self:_onUpdateCpColUI()
	self:_onUpdatePlaneUI()
end

function FalchallengeextstView:_setLeftSimpleForm(simpleForm)
	return
end

function FalchallengeextstView:_setRightSimpleForm(simpleForm)
	return
end

function FalchallengeextstView:_setForbitType(isToForbit)
	return
end

function FalchallengeextstView:_setNeedUpPetCount(count)
	return
end

function FalchallengeextstView:_updateFmt()
	return
end

function FalchallengeextstView:_initPlayerInfoList()
	self._playerInfoList = {}
	self._playerInfoList.left = {}
	self._playerInfoList.right = {}

	local userIdList = self._falGameMo:getPlayerUserIdList()

	for _, userId in ipairs(userIdList) do
		local info = {}

		info.userId = userId
		info.opState = 1

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

function FalchallengeextstView:_getPlayerInfo(userId)
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

function FalchallengeextstView:_getOpState(userId)
	local playerInfo = self:_getPlayerInfo(userId)

	return playerInfo.opState
end

function FalchallengeextstView:_setOpState(userId, state)
	local playerInfo = self:_getPlayerInfo(userId)

	playerInfo.opState = state
end

function FalchallengeextstView:_startFmtClock(waitSecond)
	self:_stopFmtClock()
	GameUtil.SetActive(self._clockGo, true)
	GameUtil.SetActive(self._clockEffRoot, false)

	self._startFmtClockTime = UnityEngine.Time.realtimeSinceStartup
	self._waitSecondInFmtClock = waitSecond

	settimer(0, self._fmtClockTicking, self)
end

function FalchallengeextstView:_stopFmtClock()
	self:_stopFmtClockTicking()
	self:_stopFmtClockEff()
end

function FalchallengeextstView:_stopFmtClockTicking()
	removetimer(self._fmtClockTicking, self)

	self._txtClockTime.text = string.format("%ss", 0)
end

function FalchallengeextstView:_fmtClockTicking()
	self._leftSecondInFmtClock = self._waitSecondInFmtClock - math.floor(UnityEngine.Time.realtimeSinceStartup - self._startFmtClockTime)
	self._txtClockTime.text = string.format("%ss", Mathf.Max(self._leftSecondInFmtClock, 0))

	if self._leftSecondInFmtClock <= 6 then
		self:_playFmtClockEff()
	end

	if self._leftSecondInFmtClock <= 0 then
		self:_stopFmtClockTicking()
		self._customFmtMo:forceSaveFmt()
	end
end

function FalchallengeextstView:_playFmtClockEff()
	if self._isPlayFmtClock then
		return
	end

	self._isPlayFmtClock = true

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

function FalchallengeextstView:_stopFmtClockEff()
	GameUtil.SetActive(self._clockEffRoot, false)
	UIEffectManager.instance:stopEffect(self._myClockEff)
end

function FalchallengeextstView:_onUpdatePlayerColUI()
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

function FalchallengeextstView:_onClearPlayerColUI()
	for _, infoList in pairs(self._playerInfoList) do
		for _, info in ipairs(infoList) do
			HeadItemController.instance:resetHeadCell(info.cell._headIcon)
		end
	end

	self:_clearLandSelectEff()
	self:_clearLandSureEff()
end

function FalchallengeextstView:_loadLandSelectEff(mainGo, userId)
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

function FalchallengeextstView:_stopLandSelectEff(userId)
	if self._selectEffList then
		UIEffectManager.instance:stopEffect(self._selectEffList[userId])

		self._selectEffList[userId] = nil
	end
end

function FalchallengeextstView:_clearLandSelectEff()
	if self._selectEffList == nil then
		return
	end

	for _, eff in pairs(self._selectEffList) do
		UIEffectManager.instance:stopEffect(eff)
	end

	table.clear(self._selectEffList)
end

function FalchallengeextstView:_loadLandSureEff(mainGo, userId)
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

function FalchallengeextstView:_stopLandSureEff(userId)
	if self._sureEffList then
		UIEffectManager.instance:stopEffect(self._sureEffList[userId])

		self._sureEffList[userId] = nil
	end
end

function FalchallengeextstView:_clearLandSureEff()
	if self._sureEffList == nil then
		return
	end

	for _, eff in pairs(self._sureEffList) do
		UIEffectManager.instance:stopEffect(eff)
	end

	table.clear(self._sureEffList)
end

function FalchallengeextstView:_onUpdateCpColUI()
	return
end

function FalchallengeextstView:_onClearCpColUI()
	return
end

function FalchallengeextstView:_clearCpCell(cell)
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

function FalchallengeextstView:_showBuffTips(buffId, teamId)
	return
end

function FalchallengeextstView:_stopBuffBubbleTimer()
	removetimer(self._buffTipsTicking, self)
end

function FalchallengeextstView:_buffTipsTicking()
	return
end

function FalchallengeextstView:_hideBuffTips(teamId)
	return
end

function FalchallengeextstView:_setCpNode(isAdd, cpId)
	return
end

function FalchallengeextstView:_isHasActOfTheCp(cpId)
	return (self._cpIdListInFmt or nil) and table.indexof(self._cpIdListInFmt, cpId) ~= false
end

function FalchallengeextstView:_clearCpIdListInFmt()
	if self._cpIdListInFmt then
		table.clear(self._cpIdListInFmt)

		self._cpIdListInFmt = nil
	end
end

function FalchallengeextstView:_playCpActEff(mainGo)
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

function FalchallengeextstView:_stopCpActEff(mainGo)
	if self._cpActInfoList then
		self._cpActInfoList[mainGo] = nil
	end
end

function FalchallengeextstView:_cpActTicking()
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

function FalchallengeextstView:_clearAllCpActEff()
	removetimer(self._cpActTicking, self)

	if self._cpActInfoList then
		table.clear(self._cpActInfoList)
	end
end

function FalchallengeextstView:_onUpdateChatColUI()
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

function FalchallengeextstView:_onClearChatColUI()
	self._chatScrollList:dispose()
end

function FalchallengeextstView:_updateChatCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")

	txtName.text = data.value

	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._clickChatCell, self, mainGo, data.chatId))
end

function FalchallengeextstView:_clearChatCell(cell)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)
end

function FalchallengeextstView:_clickChatCell(mainGo, chatId)
	FightAgainstLandlordsController.instance:sendPM_LandlordsPKChatReq(chatId)
	self:_onClickBtnChat(false)
end

function FalchallengeextstView:_onClickBtnChat(hover)
	if not hover then
		GameUtil.SetActive(self._chatList, not GameUtil.GetActive(self._chatList))
	end
end

function FalchallengeextstView:_handleNotifyChatRes(msg)
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

function FalchallengeextstView:_stopBubbleTimer()
	removetimer(self._bubbleTicking, self)
end

function FalchallengeextstView:_bubbleTicking()
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

function FalchallengeextstView:_showBubble(userId, chatId)
	local info = self:_getPlayerInfo(userId)
	local cell = info.cell

	GameUtil.SetActive(cell._bubble, true)

	local data = FightAgainstLandlordsConfig.instance:getFalChatData(chatId)

	if data then
		cell._txtBubble.text = data.value
	end
end

function FalchallengeextstView:_hideBubble(userId)
	local info = self:_getPlayerInfo(userId)
	local cell = info.cell

	GameUtil.SetActive(cell._bubble, false)
end

function FalchallengeextstView:_onUpdatePlaneUI()
	local roundId = self._falGameMo:getRoundId()
	local opState = self:_getOpState(self._myUserId)
	local isLock = opState == 2

	GameUtil.SetActive(self._btnStartLock, isLock)
end

function FalchallengeextstView:_onClickBtnStart()
	self._customFmtMo:saveFmt()
end

function FalchallengeextstView:_onClickbtnCheck()
	UIStateManager.instance:push(ViewName.FalgamespetshowView)
end

return FalchallengeextstView
