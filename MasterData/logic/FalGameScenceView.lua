-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/landlords/view/FalGameScenceView.lua

module("logic.extensions.landlords.view.FalGameScenceView", package.seeall)

local FalGameScenceView = class("FalGameScenceView", ViewComponent)

FalGameScenceView.Procedure = {
	LandlordFaPai = 3,
	FarmerFaPai = 1,
	RobLandlord = 2
}
FalGameScenceView.PlayerIdxList = {
	Two = 2,
	One = 1,
	Three = 3
}
FalGameScenceView.EffNameInFlyPai = {
	[GameEnum.FalIdentity.Landlord] = {
		[FalGameScenceView.PlayerIdxList.One] = "20230210/doudizhu1/fx_ui_doudizhu_dizhu_xia",
		[FalGameScenceView.PlayerIdxList.Two] = "20230210/doudizhu1/fx_ui_doudizhu_dizhu_zuo",
		[FalGameScenceView.PlayerIdxList.Three] = "20230210/doudizhu1/fx_ui_doudizhu_dizhu_you"
	},
	[GameEnum.FalIdentity.Farmer] = {
		[FalGameScenceView.PlayerIdxList.One] = "20230210/doudizhu1/fx_ui_doudizhu_xia",
		[FalGameScenceView.PlayerIdxList.Two] = "20230210/doudizhu1/fx_ui_doudizhu_zuo",
		[FalGameScenceView.PlayerIdxList.Three] = "20230210/doudizhu1/fx_ui_doudizhu_you"
	}
}
FalGameScenceView.EventKey = {}
FalGameScenceView.EventKey.FlyFramerPaiToAllPlayer = "flyFramerPaiToAllPlayer"

function FalGameScenceView:buildUI()
	FalGameScenceView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._roleRoot = goutil.findChild(self.mainGO, "roleRoot")
	self._myPetScrollerview = goutil.findChild(self.mainGO, "myPetCol/myPetScrollerview")
	self._myPetScrollerCell = goutil.findChild(self.mainGO, "myPetCol/myPetScrollerCell")
	self._myPetScrollList = ScrollerList.create(self._myPetScrollerview, self._myPetScrollerCell, GameUtil.handler(self._updateMyPetCell, self), GameUtil.handler(self._clearMyPetCell, self))
	self._landBuffIcon = goutil.findChild(self.mainGO, "landlordsInfo/buff/icon")
	self._txtBuffNameInLand = goutil.findChildTextComponent(self.mainGO, "landlordsInfo/txtBuffName")
	self._txtBuffDescInLand = goutil.findChildTextComponent(self.mainGO, "landlordsInfo/txtBuffDesc")
	self._landPetScrollerview = goutil.findChild(self.mainGO, "landlordsInfo/landPetCol/landPetScrollerview")
	self._landPetScrollerCell = goutil.findChild(self.mainGO, "landlordsInfo/landPetCol/landPetScrollerCell")
	self._landPetScrollList = ScrollerList.create(self._landPetScrollerview, self._landPetScrollerCell, GameUtil.handler(self._updateLandPetCell, self), GameUtil.handler(self._clearLandPetCell, self))
	self._selectInfo = goutil.findChild(self.mainGO, "selectInfo")
	self._btnSureInSel = goutil.findChild(self.mainGO, "selectInfo/btnSure")
	self._btnCancelInSel = goutil.findChild(self.mainGO, "selectInfo/btnCancel")
	self._clock = goutil.findChild(self.mainGO, "selectInfo/clock")
	self._txtClock = goutil.findChildTextComponent(self.mainGO, "selectInfo/clock/txt")
	self._clockEffRoot = goutil.findChild(self.mainGO, "selectInfo/clockEffRoot")
	self._scoreInfo = goutil.findChild(self.mainGO, "scoreInfo")
	self._imgItem = goutil.findChild(self.mainGO, "scoreInfo/imgItem")
	self._effRateRoot = goutil.findChild(self.mainGO, "scoreInfo/scoreCol/rate/effRateRoot")
	self._imgScore = goutil.findChild(self.mainGO, "scoreInfo/scoreCol/imgScore"):GetComponent(ComponentType.UIImgNumeralText)
	self._otPlayerView = goutil.findChild(self.mainGO, "playerCol/otPlayerView")
	self._otPlayerCellList = {}

	for i = 1, self._otPlayerView.transform.childCount do
		local mainGo = self._otPlayerView.transform:GetChild(i - 1)
		local cell = {}

		cell._mainGo = mainGo
		cell._headIcon = goutil.findChild(mainGo, "headIcon")
		cell._name = goutil.findChildTextComponent(mainGo, "name/txt")
		cell._identityTag = {}
		cell._identityTag._mainGo = goutil.findChild(mainGo, "identityTag")
		cell._identityTag._img = goutil.findChild(mainGo, "identityTag/img")
		cell._identityTag._eff = goutil.findChild(mainGo, "identityTag/eff")
		cell._identityTagEff = goutil.findChild(mainGo, "identityTagEff")
		cell._identityFlag = {}
		cell._identityFlag._mainGo = goutil.findChild(mainGo, "identityFlag")
		cell._identityFlag._img = goutil.findChild(mainGo, "identityFlag/img")
		cell._identityFlag._eff = goutil.findChild(mainGo, "identityFlag/eff")
		cell._clock = goutil.findChild(mainGo, "clock")
		cell._txtClock = goutil.findChildTextComponent(mainGo, "clock/txt")
		cell._bubble = goutil.findChild(mainGo, "bubble")
		cell._txtBubble = goutil.findChildTextComponent(mainGo, "bubble/txt")
		cell._txtGoldNum = goutil.findChildTextComponent(mainGo, "txtGoldNum")

		table.insert(self._otPlayerCellList, cell)
	end

	self._myPlayerCell = {}

	local cell = {}
	local mainGo = goutil.findChild(self.mainGO, "playerCol/myPlayerCell")

	cell._mainGo = mainGo
	cell._headIcon = goutil.findChild(mainGo, "headIcon")
	cell._name = goutil.findChildTextComponent(mainGo, "name/txt")
	cell._identityTag = {}
	cell._identityTag._mainGo = goutil.findChild(mainGo, "identityTag")
	cell._identityTag._img = goutil.findChild(mainGo, "identityTag/img")
	cell._identityTag._eff = goutil.findChild(mainGo, "identityTag/eff")
	cell._identityFlag = {}
	cell._identityFlag._mainGo = goutil.findChild(mainGo, "identityFlag")
	cell._identityFlag._img = goutil.findChild(mainGo, "identityFlag/img")
	cell._identityFlag._eff = goutil.findChild(mainGo, "identityFlag/eff")
	cell._bubble = goutil.findChild(mainGo, "bubble")
	cell._txtBubble = goutil.findChildTextComponent(mainGo, "bubble/txt")
	cell._txtGoldNum = goutil.findChildTextComponent(mainGo, "txtGoldNum")
	self._myPlayerCell = cell
	self._chatCol = goutil.findChild(self.mainGO, "chatCol")
	self._btnChat = goutil.findChild(self.mainGO, "chatCol/btnChat")
	self._chatList = goutil.findChild(self.mainGO, "chatCol/chatList")
	self._chatScrollerview = goutil.findChild(self.mainGO, "chatCol/chatList/chatScrollerview")
	self._chatScrollercell = goutil.findChild(self.mainGO, "chatCol/chatList/chatScrollercell")
	self._chatScrollList = ScrollerList.create(self._chatScrollerview, self._chatScrollercell, GameUtil.handler(self._updateChatCell, self), GameUtil.handler(self._clearChatCell, self))
	self._chatViewUiCustonInput = UICustomInput.Get(self._chatScrollerview)
	self._btnCheck = self:getBtn("btnCheck")
	self._empty = self:getGo("landlordsInfo/landPetCol/empty")
end

function FalGameScenceView:bindEvents()
	FalGameScenceView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, function()
		FloatWordMgr.instance:show("游戏中，无法返回")
	end, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSureInSel, function()
		self:_onClickBtnInSel(true)
	end, self)
	GameUtil.addClickHandler(self._btnCancelInSel, function()
		self:_onClickBtnInSel(false)
	end, self)
	GameUtil.addClickHandler(self._btnChat, function()
		self:_onClickBtnChat(false)
	end, self)
	self._chatViewUiCustonInput:AddListener(self._onClickBtnChat, self)
	self._btnCheck:AddClickListener(self._onClickbtnCheck, self)
end

function FalGameScenceView:unbindEvents()
	FalGameScenceView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSureInSel)
	GameUtil.rmClickHandler(self._btnCancelInSel)
	GameUtil.rmClickHandler(self._btnChat)
	self._chatViewUiCustonInput:RemoveListener()
	self._btnCheck:RemoveClickListener()
end

function FalGameScenceView:onEnter()
	FalGameScenceView.super.onEnter(self)

	self._falGameMo = FightAgainstLandlordsController.instance:getFalGameMo()
	self._activityId = self._falGameMo:getActivityId()
	self._gameId = self._falGameMo:getGameId()
	self._myUserId = FightAgainstLandlordsController.instance:getMyUserId()

	self:_initPlayerInfoList()
	self:_loadRoleRes()

	self._curProcedure = FalGameScenceView.Procedure.FarmerFaPai

	self:_runProcedure()
	self.addGEvent(self, GlobalNotify.handlePM_LandlordsPKNotifyLandlordsAckRes, self._handleAckRes, self)
	self.addGEvent(self, GlobalNotify.handlePM_LandlordsPKNotifyLandlordsCofirmRes, self._handleCofirmRes, self)
	self.addGEvent(self, GlobalNotify.handlePM_LandlordsPKNotifyChatRes, self._handleNotifyChatRes, self)
	self:_forceShowPets()
end

function FalGameScenceView:onExit()
	FalGameScenceView.super.onExit(self)
	self._myPetScrollList:dispose()
	self._landPetScrollList:dispose()
	removetimer(self._continueToFlyLandPai, self)
	self:_onClearAllPlayerCell()
	self:_stopOtPlayerClock()
	self:_stopMyPlayerClock()
	self:_stopEnterChallenge()
	self:_stopEffRate()
	self:_onClearChatColUI()
	self:_stopBubbleTimer()
	self:_clearFlyPai()
	self:_clearQueue()
end

function FalGameScenceView:_runProcedure()
	if self._curProcedure == FalGameScenceView.Procedure.FarmerFaPai then
		self._cofirmMsg = nil
		self._lastRateValue = self._falGameMo:getRateValue()

		self:_stopPlayerClock()
		self:_onUpdateChatColUI()
		self:_onUpdateAllPlayerCell()
		self:_updateLandPetCol()
		GameUtil.SetActive(self._scoreInfo, false)
		GameUtil.SetActive(self._selectInfo, false)

		local function playRoleAnimEndCallBack()
			self:_playRoleAnim(false)

			local key = FalGameScenceView.EventKey.FlyFramerPaiToAllPlayer
			local totalNum = self:_getPlayerNum()

			local function endCallBack()
				self:_setRoleShow(false)
				self:_updateMyPetCol()
				self:_playMyPetColAnim()
			end

			self._startNode(self, key, totalNum, endCallBack, self)

			local function effFinishHandler(handlerTarget, eff)
				local key = FalGameScenceView.EventKey.FlyFramerPaiToAllPlayer

				self:_calcNode(key, 1)
			end

			self:_playFlyPaiEffToPlayer(GameEnum.FalIdentity.Farmer, FalGameScenceView.PlayerIdxList.One, effFinishHandler)
			self:_playFlyPaiEffToPlayer(GameEnum.FalIdentity.Farmer, FalGameScenceView.PlayerIdxList.Two, effFinishHandler)
			self:_playFlyPaiEffToPlayer(GameEnum.FalIdentity.Farmer, FalGameScenceView.PlayerIdxList.Three, effFinishHandler)
		end

		self:_setRoleShow(true)
		self:_playRoleAnim(true, playRoleAnimEndCallBack)
	elseif self._curProcedure == FalGameScenceView.Procedure.RobLandlord then
		self:_stopFaPaiEffToPlayer(GameEnum.FalIdentity.Farmer, FalGameScenceView.PlayerIdxList.One)
		self:_stopFaPaiEffToPlayer(GameEnum.FalIdentity.Farmer, FalGameScenceView.PlayerIdxList.Two)
		self:_stopFaPaiEffToPlayer(GameEnum.FalIdentity.Farmer, FalGameScenceView.PlayerIdxList.Three)
		self:_playRoleAnim(false)
		self:_setRoleShow(false)
		GameUtil.SetActive(self._scoreInfo, true)
		self:_updateMyPetCol()
	elseif self._curProcedure == FalGameScenceView.Procedure.LandlordFaPai then
		if self._cofirmMsg then
			self:_startEnterChallenge(self._cofirmMsg.waitSecond)
		end

		self:_onUpdateAllPlayerCell()
		self:_updateLandPetCol()
		self:_updateScoreInfo()
		self:_onUpdateChatColUI()
		GameUtil.SetActive(self._selectInfo, false)

		local isFlyTag = false

		for playerIdx, playerInfo in ipairs(self._playerInfoList) do
			local userId = self:_getPlayerUserId(playerIdx)
			local identity = self._falGameMo:getIdentity(userId)

			if identity == GameEnum.FalIdentity.Landlord then
				isFlyTag = true

				self:_playFlyTagEffToPlayer(identity, playerIdx)

				break
			end
		end

		settimer(1.5, self._continueToFlyLandPai, self, false)
	end
end

function FalGameScenceView:_continueToFlyLandPai()
	GameUtil.SetActive(self._scoreInfo, false)

	local userIdList = self._falGameMo:getPlayerUserIdList()

	for _, userId in ipairs(userIdList) do
		if self._falGameMo:getIdentity(userId) == GameEnum.FalIdentity.Landlord then
			local playerIdx = self:_getPlayerIdxByUserId(userId)

			local function callBack()
				self:_updateMyPetCol()
			end

			self:_playFlyPaiEffToPlayer(GameEnum.FalIdentity.Landlord, playerIdx, callBack)
		end
	end
end

function FalGameScenceView:_handleAckRes(ackMsg)
	if self._curProcedure ~= FalGameScenceView.Procedure.RobLandlord then
		self._curProcedure = FalGameScenceView.Procedure.RobLandlord

		self:_runProcedure()
	end

	self:_updatePlayerMoByAckMsg(ackMsg)
	self:_onUpdateAllPlayerCell()

	self._curAckPlayerIdx = self:_getPlayerIdxByUserId(ackMsg.ackPlayerId)

	self:_startPlayerClock(self._curAckPlayerIdx)
	self:_updateScoreInfo()
end

function FalGameScenceView:_handleCofirmRes(cofirmMsg)
	self._cofirmMsg = cofirmMsg

	for playerIdx = 1, self:_getPlayerNum() do
		self:_setState(playerIdx, GameEnum.FalIdentity.Nothing)
	end

	self._curProcedure = FalGameScenceView.Procedure.LandlordFaPai

	self:_runProcedure()
end

function FalGameScenceView:_initPlayerInfoList()
	self._playerInfoList = {}

	local userIdList = {}
	local curIdx = 1

	userIdList[curIdx] = self._myUserId

	for idx, userId in ipairs(self._falGameMo:getPlayerUserIdList()) do
		if userId ~= self._myUserId then
			curIdx = curIdx + 1
			userIdList[curIdx] = userId
		end
	end

	local otPlayerCellIdx = 0

	for playerIdx, userId in ipairs(userIdList) do
		local info = {}

		info.userId = userId
		info.playerIdx = playerIdx

		if info.userId == self._myUserId then
			info.cell = self._myPlayerCell
		else
			otPlayerCellIdx = otPlayerCellIdx + 1
			info.cell = self._otPlayerCellList[otPlayerCellIdx]
		end

		info.mo = {}
		info.mo.state = GameEnum.FalIdentity.Nothing
		info.mo.waitSecond = -1
		self._playerInfoList[playerIdx] = info
	end
end

function FalGameScenceView:_updatePlayerMoByAckMsg(ackMsg)
	local nextInfo = self:_getPlayerInfoByUserId(ackMsg.ackPlayerId)

	nextInfo.mo.waitSecond = ackMsg.waitSecond

	if ackMsg.lastAckPlayerId then
		local lastPlayerIdx = self:_getPlayerIdxByUserId(ackMsg.lastAckPlayerId)

		if lastPlayerIdx > 0 then
			if ackMsg.lastStateResult == 1 then
				self:_setState(lastPlayerIdx, GameEnum.FalIdentity.Landlord)
			elseif ackMsg.lastStateResult == 2 then
				self:_setState(lastPlayerIdx, GameEnum.FalIdentity.Farmer)
			end
		end
	end
end

function FalGameScenceView:_getPlayerNum()
	return (self._playerInfoList or nil) and (#self._playerInfoList or 0)
end

function FalGameScenceView:_getPlayerInfo(playerIdx)
	return self._playerInfoList[playerIdx]
end

function FalGameScenceView:_getPlayerInfoByUserId(userId)
	return self._playerInfoList[self:_getPlayerIdxByUserId(userId)]
end

function FalGameScenceView:_getPlayerCell(playerIdx)
	return self:_getPlayerInfo(playerIdx).cell
end

function FalGameScenceView:_getPlayerUserId(playerIdx)
	return self:_getPlayerInfo(playerIdx).userId
end

function FalGameScenceView:_getPlayerIdxByUserId(userId)
	local playerIdx = 0

	for _, playerInfo in ipairs(self._playerInfoList) do
		if playerInfo.userId == userId then
			playerIdx = playerInfo.playerIdx

			break
		end
	end

	return playerIdx
end

function FalGameScenceView:_isMeByPlayerIdx(playerIdx)
	local playerInfo = self:_getPlayerInfo(playerIdx)

	return playerInfo.userId == self._myUserId
end

function FalGameScenceView:_getPlayerCount()
	return #self._playerInfoList
end

function FalGameScenceView:_getPlayerMo(playerIdx)
	return self:_getPlayerInfo(playerIdx).mo
end

function FalGameScenceView:_getState(playerIdx)
	local mo = self:_getPlayerMo(playerIdx)

	return mo.state
end

function FalGameScenceView:_setState(playerIdx, state)
	local mo = self:_getPlayerMo(playerIdx)

	mo.state = state
end

function FalGameScenceView:_getWaitSecondInAck(playerIdx)
	local mo = self:_getPlayerMo(playerIdx)

	return mo.waitSecond
end

function FalGameScenceView:_clearQueue()
	if self._eventQueue then
		table.clear(self._eventQueue)
	end

	self._eventQueue = nil
end

function FalGameScenceView:_startNode(key, totalNum, endCallBack, handler)
	if self._eventQueue == nil then
		self._eventQueue = {}
	end

	self._eventQueue[key] = {
		curNum = 0,
		totalNum = totalNum,
		endCallBack = endCallBack,
		handler = handler
	}
end

function FalGameScenceView:_endNode(key, isNeedCallBack)
	local node = self._eventQueue[key]

	if isNeedCallBack then
		GameUtil.callBack(node.endCallBack, node.handler)
	end

	table.clear(self._eventQueue[key])

	self._eventQueue[key] = nil
end

function FalGameScenceView:_calcNode(key, delta)
	if self._eventQueue[key] == nil then
		return
	end

	local curNum = self._eventQueue[key].curNum

	curNum = curNum + delta

	if curNum >= self._eventQueue[key].totalNum then
		self:_endNode(key, true)
	else
		self._eventQueue[key].curNum = curNum
	end
end

function FalGameScenceView:_clearFlyPai()
	if self._flyPaiEffPool == nil then
		return
	end

	for _, effs in pairs(self._flyPaiEffPool) do
		for _, eff in pairs(effs) do
			UIEffectManager.instance:stopEffect(eff)
		end
	end

	table.clear(self._flyPaiEffPool)
end

function FalGameScenceView:_playFlyPaiEffToPlayer(identity, playerIdx, finishHandler)
	local effParent = self.mainGO
	local pathName = FalGameScenceView.EffNameInFlyPai[identity][playerIdx]

	if effParent and not string.nilorempty(pathName) then
		local path = pathName .. ".prefab"

		local function loadedHandler(handlerTarget, eff)
			eff:setParent(effParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true
		end

		local handlerTarget

		if self._flyPaiEffPool == nil then
			self._flyPaiEffPool = {}
		end

		if self._flyPaiEffPool[identity] == nil then
			self._flyPaiEffPool[identity] = {}
		end

		self._flyPaiEffPool[identity][playerIdx] = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, false, false, finishHandler, loadedHandler, handlerTarget)
	end
end

function FalGameScenceView:_stopFaPaiEffToPlayer(identity, playerIdx)
	if self._flyPaiEffPool and self._flyPaiEffPool[identity] then
		UIEffectManager.instance:stopEffect(self._flyPaiEffPool[identity][playerIdx])
	end
end

FalGameScenceView.SmbNameHash_IgnoreFather_FlyTag = {
	[GameEnum.FalIdentity.Landlord] = {
		[FalGameScenceView.PlayerIdxList.One] = "flytaganimofme",
		[FalGameScenceView.PlayerIdxList.Two] = "flytaganimofone",
		[FalGameScenceView.PlayerIdxList.Three] = "flytaganimoftwo"
	},
	[GameEnum.FalIdentity.Farmer] = {
		[FalGameScenceView.PlayerIdxList.One] = "",
		[FalGameScenceView.PlayerIdxList.Two] = "",
		[FalGameScenceView.PlayerIdxList.Three] = ""
	}
}

function FalGameScenceView:_getFlyTagAnimOfSmbNameHash(identity, playerIdx)
	return FalGameScenceView.SmbNameHash_IgnoreFather_FlyTag[identity][playerIdx]
end

function FalGameScenceView:_clearFlyTag()
	if self._flyTagEffPool == nil then
		return
	end

	for _, effs in pairs(self._flyTagEffPool) do
		for _, eff in pairs(effs) do
			UIEffectManager.instance:stopEffect(eff)
		end
	end

	table.clear(self._flyTagEffPool)
end

function FalGameScenceView:_playFlyTagEffToPlayer(identity, playerIdx)
	local cell = self:_getPlayerCell(playerIdx)
	local animator = cell._identityTag._mainGo:GetComponent(ComponentType.Animator)

	if animator then
		local smbNameHash = self:_getFlyTagAnimOfSmbNameHash(identity, playerIdx)

		animator:Play(smbNameHash, 0, 0)
	else
		printError(string.format("缺失animator, identity=%s, playerIdx=%s", identity, playerIdx))
	end
end

function FalGameScenceView:_stopFlyTagEffToPlayer(identity, playerIdx)
	if self._flyTagEffPool and self._flyTagEffPool[identity] then
		UIEffectManager.instance:stopEffect(self._flyTagEffPool[identity][playerIdx])
	end
end

function FalGameScenceView:_clearAllFlyTagEff()
	return
end

function FalGameScenceView:_onStateChange(state, animator, animatorStateInfo, layerIndex, finishHandler)
	printError("_onStateChange")
	printError(string.format("state = %s", state))

	if state ~= AnimatorListener.STATE_ENTER then
		return
	end

	printError("xxxxxxxxx")
	GameUtil.callBack(finishHandler)
end

function FalGameScenceView:_loadRoleRes()
	if not self._roleGo then
		local go = self:getResInstance(FalGameScenceViewPresentor.DouDiZhuCharacterPath)

		self._roleGo = go

		if go then
			local scale = 0.25

			goutil.addChildToParent(go, self._roleRoot)
			GameUtil.setLocalScale(go, scale, scale, scale)
		end
	end

	self:_playRoleAnim(false)
end

function FalGameScenceView:_setRoleShow(isNeedShow)
	GameUtil.SetActive(self._roleGo, isNeedShow)
end

function FalGameScenceView:_playRoleAnim(isFaPai, callBack)
	local name = ""
	local isLoop = false

	if isFaPai then
		name = "idle2"
		isLoop = false
	else
		name = "idle"
		isLoop = true
	end

	RoleObjectPool.instance:playAnimation(self._roleGo, name, isLoop, callBack)
end

function FalGameScenceView:_onUpdateAllPlayerCell()
	for playerIdx, playerInfo in ipairs(self._playerInfoList) do
		if self:_isMeByPlayerIdx(playerIdx) then
			self:_updateMyPlayerCell(playerIdx)
		else
			self:_updateOtPlayerCell(playerIdx)
		end
	end
end

function FalGameScenceView:_onClearAllPlayerCell()
	for playerIdx, playerInfo in ipairs(self._playerInfoList) do
		if self:_isMeByPlayerIdx(playerIdx) then
			self:_clearMyPlayerCell(playerIdx)
		else
			self:_clearOtPlayerCell(playerIdx)
		end
	end

	self:_clearLandTagEff()
	self:_clearLandFlagEff()
	self:_clearAllFlyTagEff()
end

function FalGameScenceView:_updateMyPlayerCell(playerIdx)
	local cell = self:_getPlayerCell(playerIdx)
	local userId = self:_getPlayerUserId(playerIdx)
	local identity = self._falGameMo:getIdentity(userId)
	local headInfo = self._falGameMo:getHeadInfo(userId)
	local tokenScore = self._falGameMo:getTokenScore(userId)

	GameUtil.SetActive(self._selectInfo, false)

	local flagIdx = -1
	local state = self:_getState(playerIdx)

	if state == GameEnum.FalIdentity.Landlord then
		flagIdx = 0
	elseif state == GameEnum.FalIdentity.Farmer then
		flagIdx = 1
	end

	GameUtil.SetActive(cell._identityFlag._img, flagIdx ~= -1)
	GameUtil.setUIImageSpriteIdx(cell._identityFlag._img, flagIdx)
	GameUtil.SetActive(cell._identityFlag._eff, state == GameEnum.FalIdentity.Landlord)

	if state == GameEnum.FalIdentity.Landlord then
		GameUtil.SetActive(cell._identityFlag._img, false)
		self:_playLandFlagEff(cell._identityFlag._eff, playerIdx)
	else
		self:_stopLandFlagEff(playerIdx)
	end

	local tagIdx = 0

	if identity == GameEnum.FalIdentity.Landlord then
		tagIdx = 1
	elseif identity == GameEnum.FalIdentity.Farmer then
		tagIdx = 0
	end

	GameUtil.setUIImageSpriteIdx(cell._identityTag._img, tagIdx)
	GameUtil.SetActive(cell._identityTag._img, identity ~= GameEnum.FalIdentity.Nothing)
	GameUtil.SetActive(cell._identityTag._eff, identity == GameEnum.FalIdentity.Landlord)

	if identity == GameEnum.FalIdentity.Landlord then
		GameUtil.SetActive(cell._identityTag._img, false)
		self:_playLandTagEff(cell._identityTag._eff, playerIdx)
	else
		self:_stopLandTagEff(playerIdx)
	end

	HeadItemController.instance:setHeadCellByInfo(cell._headIcon, headInfo)

	cell._name.text = headInfo.userName
	cell._txtGoldNum.text = tokenScore
end

function FalGameScenceView:_clearMyPlayerCell(playerIdx)
	local cell = self:_getPlayerCell(playerIdx)

	HeadItemController.instance:resetHeadCell(cell._headIcon)
end

function FalGameScenceView:_updateOtPlayerCell(playerIdx)
	local cell = self:_getPlayerCell(playerIdx)
	local userId = self:_getPlayerUserId(playerIdx)
	local identity = self._falGameMo:getIdentity(userId)
	local headInfo = self._falGameMo:getHeadInfo(userId)
	local tokenScore = self._falGameMo:getTokenScore(userId)
	local flagIdx = -1
	local state = self:_getState(playerIdx)

	if state == GameEnum.FalIdentity.Landlord then
		flagIdx = 0
	elseif state == GameEnum.FalIdentity.Farmer then
		flagIdx = 1
	end

	GameUtil.SetActive(cell._identityFlag._img, flagIdx ~= -1)
	GameUtil.setUIImageSpriteIdx(cell._identityFlag._img, flagIdx)
	GameUtil.SetActive(cell._identityFlag._eff, state == GameEnum.FalIdentity.Landlord)

	if state == GameEnum.FalIdentity.Landlord then
		GameUtil.SetActive(cell._identityFlag._img, false)
		self:_playLandFlagEff(cell._identityFlag._eff, playerIdx)
	else
		self:_stopLandFlagEff(playerIdx)
	end

	local tagIdx = 0

	if identity == GameEnum.FalIdentity.Landlord then
		tagIdx = 1
	elseif identity == GameEnum.FalIdentity.Farmer then
		tagIdx = 0
	end

	GameUtil.setUIImageSpriteIdx(cell._identityTag._img, tagIdx)
	GameUtil.SetActive(cell._identityTag._img, identity ~= GameEnum.FalIdentity.Nothing)
	GameUtil.SetActive(cell._identityTag._eff, identity == GameEnum.FalIdentity.Landlord)

	if identity == GameEnum.FalIdentity.Landlord then
		GameUtil.SetActive(cell._identityTag._img, false)
		self:_playLandTagEff(cell._identityTag._eff, playerIdx)
	else
		self:_stopLandTagEff(playerIdx)
	end

	HeadItemController.instance:setHeadCellByInfo(cell._headIcon, headInfo)

	cell._name.text = headInfo.userName
	cell._txtGoldNum.text = tokenScore
end

function FalGameScenceView:_clearOtPlayerCell(playerIdx)
	local cell = self:_getPlayerCell(playerIdx)

	HeadItemController.instance:resetHeadCell(cell._headIcon)
end

function FalGameScenceView:_playLandTagEff(mainGo, playerIdx)
	local effParent = mainGo
	local pathName = "20230210/doudizhu1/fx_ui_doudizhu_lingzhu"

	if effParent and not string.nilorempty(pathName) then
		local path = pathName .. ".prefab"

		local function finishHandler(handlerTarget, eff)
			self:_stopLandTagEff(playerIdx)
		end

		local function loadedHandler(handlerTarget, eff)
			eff:setParent(effParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true
		end

		local handlerTarget

		if self._tagEffList == nil then
			self._tagEffList = {}
		end

		if self._tagEffList[playerIdx] == nil then
			self._tagEffList[playerIdx] = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, true, false, finishHandler, loadedHandler, handlerTarget)
		end
	end
end

function FalGameScenceView:_stopLandTagEff(playerIdx)
	if self._tagEffList then
		UIEffectManager.instance:stopEffect(self._tagEffList[playerIdx])

		self._tagEffList[playerIdx] = nil
	end
end

function FalGameScenceView:_clearLandTagEff()
	if self._tagEffList == nil then
		return
	end

	for _, eff in pairs(self._tagEffList) do
		UIEffectManager.instance:stopEffect(eff)
	end

	table.clear(self._tagEffList)
end

function FalGameScenceView:_playLandFlagEff(mainGo, playerIdx)
	local effParent = mainGo
	local pathName = "20230210/doudizhu/fx_ui_doudizhu_qiang"

	if effParent and not string.nilorempty(pathName) then
		local path = pathName .. ".prefab"

		local function finishHandler(handlerTarget, eff)
			self:_stopLandFlagEff(playerIdx)
		end

		local function loadedHandler(handlerTarget, eff)
			eff:setParent(effParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true
		end

		local handlerTarget

		if self._flagEffList == nil then
			self._flagEffList = {}
		end

		if self._flagEffList[playerIdx] == nil then
			self._flagEffList[playerIdx] = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, true, false, finishHandler, loadedHandler, handlerTarget)
		end
	end
end

function FalGameScenceView:_stopLandFlagEff(playerIdx)
	if self._flagEffList then
		UIEffectManager.instance:stopEffect(self._flagEffList[playerIdx])

		self._flagEffList[playerIdx] = nil
	end
end

function FalGameScenceView:_clearLandFlagEff()
	if self._flagEffList == nil then
		return
	end

	for _, eff in pairs(self._flagEffList) do
		UIEffectManager.instance:stopEffect(eff)
	end

	table.clear(self._flagEffList)
end

function FalGameScenceView:_startPlayerClock(playerIdx)
	self:_stopPlayerClock()
	self:_stopLandFlagEff(playerIdx)

	self._startPlayerClockTime = UnityEngine.Time.realtimeSinceStartup
	self._waitSecondInAck = self:_getWaitSecondInAck(playerIdx)

	if self:_isMeByPlayerIdx(playerIdx) then
		self:_startMyPlayerClock(playerIdx)
	else
		self:_startOtPlayerClock(playerIdx)
	end
end

function FalGameScenceView:_stopPlayerClock()
	self:_stopMyPlayerClock()
	self:_stopOtPlayerClock()
end

function FalGameScenceView:_startOtPlayerClock(playerIdx)
	self._otPlayerCellInClock = self:_getPlayerCell(playerIdx)

	GameUtil.SetActive(self._otPlayerCellInClock._clock, true)
	settimer(0, self._otPlayerCountDowning, self)
end

function FalGameScenceView:_stopOtPlayerClock()
	removetimer(self._otPlayerCountDowning, self)

	for playerIdx = 1, self:_getPlayerCount() do
		if self:_getPlayerUserId(playerIdx) ~= self._myUserId then
			local cell = self:_getPlayerCell(playerIdx)

			GameUtil.SetActive(cell._clock, false)
		end
	end

	self._otPlayerCellInClock = nil
end

function FalGameScenceView:_otPlayerCountDowning()
	self._leftSecond = self._waitSecondInAck - (UnityEngine.Time.realtimeSinceStartup - self._startPlayerClockTime)
	self._otPlayerCellInClock._txtClock.text = GameUtil.FormatTimeSymbol(self._leftSecond)

	if self._leftSecond <= 0 then
		self:_stopOtPlayerClock()
	end
end

function FalGameScenceView:_startMyPlayerClock(playerIdx)
	self._otPlayerCellInClock = self:_getPlayerCell(playerIdx)

	GameUtil.SetActive(self._selectInfo, true)
	GameUtil.SetActive(self._clock, true)
	GameUtil.SetActive(self._clockEffRoot, false)
	self:_stopLandFlagEff(playerIdx)
	settimer(0, self._myPlayerCountDowning, self)
end

function FalGameScenceView:_stopMyPlayerClock()
	self:_stopMyPlayerClockCountDowning()
	self:_stopMyClockEff()
end

function FalGameScenceView:_myPlayerCountDowning()
	self._leftSecondInMy = self._waitSecondInAck - (UnityEngine.Time.realtimeSinceStartup - self._startPlayerClockTime)
	self._txtClock.text = GameUtil.FormatTimeSymbol(self._leftSecondInMy)

	if self._leftSecondInMy <= 6 then
		self:_stopMyPlayerClockCountDowning()
		self:_playMyClockEff()
	end
end

function FalGameScenceView:_stopMyPlayerClockCountDowning()
	removetimer(self._myPlayerCountDowning, self)
	GameUtil.SetActive(self._selectInfo, false)
end

function FalGameScenceView:_onClickBtnInSel(isToBeLandlords)
	self:_stopMyPlayerClock()
	FightAgainstLandlordsController.instance:sendPM_LandlordsPKLandlordReq(isToBeLandlords)
end

function FalGameScenceView:_playMyClockEff()
	GameUtil.SetActive(self._selectInfo, true)
	GameUtil.SetActive(self._clock, false)
	GameUtil.SetActive(self._clockEffRoot, true)

	local effParent = self._clockEffRoot
	local pathName = "20230210/doudizhu/fx_ui_doudizhu_shizhong"

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

function FalGameScenceView:_stopMyClockEff()
	GameUtil.SetActive(self._clockEffRoot, false)
	UIEffectManager.instance:stopEffect(self._myClockEff)
end

function FalGameScenceView:_updateScoreInfo()
	local gameData = FightAgainstLandlordsConfig.instance:getFalGameData(self._activityId, self._gameId)
	local curRateValue = self._falGameMo:getRateValue()

	if curRateValue ~= self._lastRateValue then
		self:_playEffRate(curRateValue)

		self._lastRateValue = curRateValue
	end

	if self._imgScore then
		self._imgScore:SetNum(gameData.initialScore * curRateValue)
	end
end

function FalGameScenceView:_playEffRate(value)
	local effParent = self._effRateRoot
	local pathName = "20230210/doudizhu/fx_ui_doudizhu_fanbei"

	self:_stopEffRate()

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

			local txt = goutil.findChildTextComponent(eff.effGo, "an1/txt")
			local txt1 = goutil.findChildTextComponent(eff.effGo, "an/txt1")

			txt.text = string.format("x%s", value)
			txt1.text = string.format("x%s", value)
		end

		local handlerTarget

		self._effRate = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, false, false, finishHandler, loadedHandler, handlerTarget)
	end
end

function FalGameScenceView:_stopEffRate()
	UIEffectManager.instance:stopEffect(self._effRate)

	self._effRate = nil
end

function FalGameScenceView:_updateMyPetCol()
	self:_onUpdateMyPetColData()
	self:_onUpdateMyPetColUI()
end

function FalGameScenceView:_onUpdateMyPetColData()
	self._myPetInfoList = {}

	local creepsIds = self._falGameMo:getBagCreepsIdsAsUser(self._myUserId)

	for _, v in ipairs(creepsIds) do
		local info = {}

		info.petMo = FightAgainstLandlordsModel.instance:getPetMoAsFal(v)
		info.data = data

		table.insert(self._myPetInfoList, info)
	end
end

function FalGameScenceView:_onUpdateMyPetColUI()
	self._myPetScrollList:reloadData(self._myPetInfoList)
end

function FalGameScenceView:_updateMyPetCell(view, cell, info, tag)
	local petMo = info.petMo
	local mainGo = cell.gameObject
	local con = goutil.findChild(mainGo, "mask/con")
	local qualitybg = goutil.findChild(mainGo, "qualitybg")
	local attr = goutil.findChild(mainGo, "attr")
	local txtPower = goutil.findChildTextComponent(mainGo, "txtPower")
	local imgCp = goutil.findChild(mainGo, "imgCp")
	local petId = petMo:getPetId()
	local skinId = petMo.curFaceId
	local modelCo = CharacterConfig.instance:getModelCo(skinId)

	uGuiUtil.setSpriteToImage(con, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))

	local rare = petMo:getRare()

	GameUtil.setUIImageSpriteIdx(qualitybg, rare)
	GameUtil.setUIImageColorIdx(qualitybg, rare)

	local attrIdx = PetSkinConfig.instance:getFisrtEleAttrIdx(skinId)

	attrIdx = attrIdx % 10 - 1

	GameUtil.setUIImageSpriteIdx(attr, attrIdx)

	txtPower.text = petMo:getFightingPower()

	GameUtil.SetActive(imgCp, false)
	GameUtil.addClickHandler(mainGo, function()
		CommonTipsMgr.instance:showPetTips(petMo, false)
	end, self)
end

function FalGameScenceView:_clearMyPetCell(cell)
	local mainGo = cell.gameObject
	local con = goutil.findChild(mainGo, "mask/con")

	uGuiUtil.clearImage(con)
	GameUtil.rmClickHandler(mainGo)
end

function FalGameScenceView:_playMyPetColAnim()
	GameUtil.playSliderAnimation(self._myPetScrollerview:GetComponent(ComponentType.ScrollRect), nil)
end

function FalGameScenceView:_updateLandPetCol()
	self:_onUpdateLandPetColData()
	self:_onUpdateLandPetColUI()
	self:_onUpdateLandBuffUI()
end

function FalGameScenceView:_onUpdateLandPetColData()
	self._landPetInfoList = {}

	local landlordsCards = self._cofirmMsg and self._cofirmMsg.landlordsCards or FightAgainstLandlordsModel.instance:getLandlordsCardsInDealCard()

	if landlordsCards then
		for _, v in ipairs(landlordsCards) do
			local info = {}

			info.petMo = FightAgainstLandlordsModel.instance:getPetMoAsFal(v)

			table.insert(self._landPetInfoList, info)
		end
	end
end

function FalGameScenceView:_onUpdateLandPetColUI()
	GameUtil.SetActive(self._empty, #self._landPetInfoList == 0)
	self._landPetScrollList:reloadData(self._landPetInfoList)
	GameUtil.playSliderAnimation(self._landPetScrollerview:GetComponent(ComponentType.ScrollRect), nil)
end

function FalGameScenceView:_updateLandPetCell(view, cell, info, tag)
	local petMo = info.petMo
	local mainGo = cell.gameObject
	local con = goutil.findChild(mainGo, "con")
	local imgCp = goutil.findChild(mainGo, "imgCp")
	local petId = petMo:getPetId()
	local skinId = petMo.curFaceId
	local proxy = MaterialMgr.setCell(MatType.Pet, skinId, con)

	if proxy then
		proxy.binder:setClickCallBack(function()
			CommonTipsMgr.instance:showPetTips(petMo, false)
		end)
	end

	GameUtil.SetActive(imgCp, false)
end

function FalGameScenceView:_clearLandPetCell(cell)
	local mainGo = cell.gameObject
	local con = goutil.findChild(mainGo, "mask/con")

	MaterialMgr.resetAll(con)
end

function FalGameScenceView:_onUpdateLandBuffUI()
	local buffIdList = FightAgainstLandlordsModel.instance:getLandlordsBuffsInDealCard()

	if not buffIdList[1] then
		local buffId = 0
		local buffData = FightAgainstLandlordsConfig.instance:getFalBuffData(self._activityId, buffId)

		if buffData == nil then
			buffData = {}
		end

		local path = buffData.iconPath
		local bgGo = self._landBuffIcon

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

		if not string.nilorempty(buffData.name) then
			self._txtBuffNameInLand.text = buffData.name
		end

		if not string.nilorempty(buffData.desc) then
			self._txtBuffDescInLand.text = buffData.desc
		end
	end
end

function FalGameScenceView:_startEnterChallenge(waitSecond)
	self._waitSecondInCofirm = waitSecond
	self._startPlayerClockTime = UnityEngine.Time.realtimeSinceStartup

	settimer(0.1, self._tickingInEnterchallenge, self)
end

function FalGameScenceView:_stopEnterChallenge()
	removetimer(self._tickingInEnterchallenge, self)
end

function FalGameScenceView:_tickingInEnterchallenge()
	self._leftTimeInEC = self._waitSecondInCofirm - (UnityEngine.Time.realtimeSinceStartup - self._startPlayerClockTime)

	if self._leftTimeInEC <= 0 then
		self:_stopEnterChallenge()
		self:close()
		UIJumper.instance:pushOneStack(ViewName.FightAgainstLandlordsMainView, nil)
		FightAgainstLandlordsController.instance:enterBattleAsFal(self._activityId)
	end
end

function FalGameScenceView:_onUpdateChatColUI()
	local dataList = {}
	local cfg = FightAgainstLandlordsConfig.instance:getFalChatCfg()
	local chatScence = 1
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

function FalGameScenceView:_onClearChatColUI()
	self._chatScrollList:dispose()
end

function FalGameScenceView:_updateChatCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")

	txtName.text = data.value

	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._clickChatCell, self, mainGo, data.chatId))
end

function FalGameScenceView:_clearChatCell(cell)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)
end

function FalGameScenceView:_clickChatCell(mainGo, chatId)
	FightAgainstLandlordsController.instance:sendPM_LandlordsPKChatReq(chatId)
	self:_onClickBtnChat(false)
end

function FalGameScenceView:_onClickBtnChat(hover)
	if not hover then
		GameUtil.SetActive(self._chatList, not GameUtil.GetActive(self._chatList))
	end
end

function FalGameScenceView:_handleNotifyChatRes(msg)
	local chatScence = 1
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

function FalGameScenceView:_stopBubbleTimer()
	removetimer(self._bubbleTicking, self)
end

function FalGameScenceView:_bubbleTicking()
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

function FalGameScenceView:_showBubble(userId, chatId)
	local cell = self:_getPlayerCell(self:_getPlayerIdxByUserId(userId))

	GameUtil.SetActive(cell._bubble, true)

	local data = FightAgainstLandlordsConfig.instance:getFalChatData(chatId)

	if data then
		cell._txtBubble.text = data.value
	end
end

function FalGameScenceView:_hideBubble(userId)
	local cell = self:_getPlayerCell(self:_getPlayerIdxByUserId(userId))

	GameUtil.SetActive(cell._bubble, false)
end

function FalGameScenceView:_onClickBtnTip()
	FloatWordMgr.instance:show("Tip")
end

function FalGameScenceView:_forceShowPets()
	UIStateManager.instance:push(ViewName.FalgamespetshowView, true)
end

function FalGameScenceView:_onClickbtnCheck()
	UIStateManager.instance:push(ViewName.FalgamespetshowView)
end

return FalGameScenceView
