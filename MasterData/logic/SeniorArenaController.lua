-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/seniorarena/controller/SeniorArenaController.lua

module("logic.extensions.seniorarena.controller.SeniorArenaController", package.seeall)

local SeniorArenaController = class("SeniorArenaController", BaseController)

function SeniorArenaController:ctor()
	return
end

function SeniorArenaController:onInit()
	self:onReset()
end

function SeniorArenaController:onReset()
	self._canClickNext = true
	self._formMap = {}
end

function SeniorArenaController:setCanClickNext(boo)
	self._canClickNext = boo
end

function SeniorArenaController:getCanClickNext()
	return self._canClickNext
end

function SeniorArenaController:openOtherDefendFormsView(userId, playerMo)
	local function func(uid)
		local formMos = SeniorArenaModel.instance:getOppenentDefendForms(uid)
		local isDefend = true

		UIStateManager.instance:open(ViewName.SeniorFormsView, formMos, isDefend, playerMo)
	end

	if SeniorArenaModel.instance:getOppenentDefendForms(userId) == nil then
		self:reqOtherFormation(userId, function()
			func(userId)
		end)
	else
		func(userId)
	end
end

function SeniorArenaController:openBattleResultView()
	local leftPlayerInfo = self:getMyPlayerInfo()
	local leftFormMos = SeniorArenaModel.instance:getMyAttackFormMos()
	local rightFormMos = self._battlePlayerFormMos
	local twoFormMos = {}

	for k, v in ipairs(self._btlResults) do
		local twoFormMo = {}
		local leftFormMo = leftFormMos[k]
		local rightFormMo = rightFormMos[k]

		twoFormMo.formId = k
		twoFormMo.isChallengerWin = v.activityWinner == 0
		twoFormMo.challengeZdl = leftFormMo:getTotalPower()
		twoFormMo.beChallengeZdl = rightFormMo:getTotalPower()
		twoFormMo.challengePets = leftFormMo:getPets()
		twoFormMo.beChallengePets = rightFormMo:getPets()

		table.insert(twoFormMos, twoFormMo)
	end

	ViewMgr.instance:open(ViewName.SeniorBattleSettlementView, leftPlayerInfo, self._battlePlayerInfo, twoFormMos)
end

function SeniorArenaController:openAllFormsView()
	local leftPlayerInfo = self:getMyPlayerInfo()
	local rightPlayerInfo = self:getCurOpponentInfo()
	local leftFormMos = self:getMyCacheFormMos()
	local rightFormMos = self:getCurOpponentFormMos()

	UIStateManager.instance:open(ViewName.SeniorAllFormsView, leftPlayerInfo, rightPlayerInfo, leftFormMos, rightFormMos)
end

function SeniorArenaController:getMyPlayerInfo()
	local mo = {}

	mo.userName = RoleModel.instance:getUserName()
	mo.headIconId = RoleModel.instance:getHeadIconId()
	mo.headFrameId = RoleModel.instance:getHeadFrameId()
	mo.isMyInfo = true

	return mo
end

function SeniorArenaController:getMyCacheFormMos()
	local formMos = {}

	if self._cacheForms then
		for _, v in ipairs(self._cacheForms) do
			local playerFormMo = PlayerFormMo.New()
			local fmtMo = self._formMap[v.formId]

			playerFormMo:initWithCacheForm(v, fmtMo)

			formMos[v.formId] = playerFormMo
		end
	end

	return formMos
end

function SeniorArenaController:getShowTotalNum()
	local interval = ServerTime.now() - SeniorArenaModel.instance:getLastProduceTime()
	local accumulateValue = SeniorArenaModel.instance:getAccumulateValue()
	local addPerTime = SeniorArenaModel.instance:getAddPerTime()
	local hangUpTime = SeniorArenaConfig.instance:getCommonValue("HANG_UP_TIME", true)
	local maxNum = SeniorArenaConfig.instance:getCommonValue("HANG_UP_UPPER_LIMIT", true)
	local num = math.floor(accumulateValue + math.floor(interval / hangUpTime) * addPerTime)

	if num < 0 then
		num = 0
	end

	if maxNum < num then
		num = maxNum
	end

	return num
end

function SeniorArenaController:popBuyTicketWindow()
	local buyTicketTime = SeniorArenaModel.instance:getBuyTicketTime()
	local maxBuyTicketTime = SeniorArenaConfig.instance:getMaxBuyTicketTime()
	local leftBuyTime = maxBuyTicketTime - buyTicketTime

	if leftBuyTime <= 0 then
		FloatWordMgr.instance:show("今日购买次数已用完")

		return
	end

	local isEnough = self:checkMatEnough(buyTicketTime + 1, buyTicketTime + 1, true)

	if not isEnough then
		return
	end

	local descTxt

	local function sureCallBack(view)
		local times = view:getCurTimes()

		if self:checkMatEnough(buyTicketTime + 1, buyTicketTime + times, true) then
			SeniorArenaController.instance:reqBuyTicket(times)
		end
	end

	local cancelCallBack, otherCallBack

	local function updateCoinTxtCallBack(view)
		view:getTxtCoin().text = ""
	end

	local function updateDescTxtCallBack(view)
		local times = view:getCurTimes()
		local cosMats = SeniorArenaConfig.instance:getCostMatsWithBuyTimes(buyTicketTime + 1, buyTicketTime + times)
		local names = ""
		local index = 1

		for matKey, matNum in pairs(cosMats) do
			local matName = MaterialMgr.getMaterialsNameByCfg(matKey)

			names = index > 1 and names .. string.format(", <color=#eb4624>%s%s</color>", matNum, matName) or string.format("<color=#eb4624>%s%s</color>", matNum, matName)
			index = index + 1
		end

		view:getTxtDesc().text = string.format("确定花费%s购买挑战次数吗？\n<size=24>每天最多可购买%s次，还能购买%s次</size>", names, maxBuyTicketTime, leftBuyTime)
	end

	TipsFacade.instance:openPopupCommonCostPopView(leftBuyTime, 1, "提示", "确定", "取消", descTxt, sureCallBack, cancelCallBack, otherCallBack, updateCoinTxtCallBack, updateDescTxtCallBack)
end

function SeniorArenaController:checkMatEnough(startTimes, endTimes, isAutoOpenSource)
	local matArray = SeniorArenaConfig.instance:getCostMatsWithBuyTimes(startTimes, endTimes)

	for matKey, matNum in pairs(matArray) do
		local matType, matId, _ = MaterialMgr.getMatParams(matKey)

		if not MaterialFacade.instance:checkMatEnough(matType, matId, matNum, nil, isAutoOpenSource) then
			return false
		end
	end

	return true
end

function SeniorArenaController:getCurFormTab()
	return math.max(1, checknumber(self._curFormTab))
end

function SeniorArenaController:setCurFormTab(value)
	self._curFormTab = value
end

function SeniorArenaController:setCurOpponentId(value)
	self._curOpponentId = value
end

function SeniorArenaController:getCurOpponentId()
	return self._curOpponentId
end

function SeniorArenaController:getCurOpponentInfo()
	local userId = self:getCurOpponentId()

	return SeniorArenaModel.instance:getTargetByUserId(userId)
end

function SeniorArenaController:getCurOpponentFormMos()
	local opponentId = self:getCurOpponentId()

	return SeniorArenaModel.instance:getOppenentDefendForms(opponentId)
end

function SeniorArenaController:getCurTabOpponentFormMo()
	local curTab = self:getCurFormTab()
	local formMos = self:getCurOpponentFormMos()

	return formMos[curTab]
end

function SeniorArenaController:_callback(...)
	local handler = self._handler
	local handlerObj = self._handlerTarget

	self._handler = nil
	self._handlerTarget = nil

	if handler then
		if handlerObj then
			self._handler(handlerObj, ...)
		else
			handler(...)
		end
	end
end

function SeniorArenaController:clearHandler()
	self._handler = nil
	self._handlerTarget = nil
end

function SeniorArenaController:_errorCall(status)
	self._handler = nil
	self._handlerTarget = nil

	GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
end

function SeniorArenaController:getCurZoneInfo(handler, handlerObj)
	if not SeniorArenaController.instance:getIsOpen(false) then
		return
	end

	Arena3v3Agent.instance:sendArena3v3CurZoneInReq(function(msg)
		forcePrint("=====RoleDataRequestor:_loadSeniorRankZone===back")
		self:_onCurZoneInfoRes(msg, handler, handlerObj)
	end)
end

function SeniorArenaController:_onCurZoneInfoRes(msg, handler, handlerObj)
	SeniorArenaModel.instance:setCurZoneId(msg.zoneId)
	GameUtil.callBack(handler, handlerObj)
end

function SeniorArenaController:reqRankData()
	if not SeniorArenaController.instance:getIsOpen(true) then
		return
	end

	local curZoneId = SeniorArenaModel.instance:getCurZoneId()

	if curZoneId > 0 then
		self:_realReqRankData()
	else
		self.getCurZoneInfo(self, self._realReqRankData, self)
	end
end

function SeniorArenaController:_realReqRankData()
	Arena3v3Agent.instance:sendArena3v3TopDetailReq(self._onRankDataRes, self, self._errorCall)
end

function SeniorArenaController:_onRankDataRes(msg)
	local rankMo = {}

	rankMo.myRank = msg.myRank
	rankMo.rankList = msg.topInfos

	RankModel.instance:setRankData(rankMo, GameEnum.RankType.SeniorArena, 0)
	GlobalDispatcher:dispatch(GlobalNotify.RankDataGet)
end

function SeniorArenaController:reqPrizeInfo(handler, handlerTarget)
	if not SeniorArenaController.instance:getIsOpen(true) then
		return
	end

	self._handler = handler
	self._handlerTarget = handlerTarget

	Arena3v3Agent.instance:sendArena3v3AchievePrizeInfoReq(self._onAchievePrizeInfoRes, self, self._errorCall)
end

function SeniorArenaController:_onAchievePrizeInfoRes(msg)
	SeniorArenaModel.instance:setGainBit(msg.gainBit)
	SeniorArenaModel.instance:setMaxTopGroupId(msg.maxTopGroupId)
	self:_callback()
end

function SeniorArenaController:reqReceivePrize(groupId)
	if not SeniorArenaController.instance:getIsOpen(true) then
		return
	end

	Arena3v3Agent.instance:sendArena3v3GainAchievePrizeReq(self._onGainPrizeRes, self, self._errorCall)
end

function SeniorArenaController:_onGainPrizeRes(msg)
	for _, groupId in ipairs(msg.groupId or {}) do
		SeniorArenaModel.instance:setBitGained(groupId, true)
	end

	GlobalDispatcher:dispatch(GlobalNotify.SeniorPrizeReceived)
end

function SeniorArenaController:reqArenaInfo(handler, handlerTarget)
	if not SeniorArenaController.instance:getIsOpen(true) then
		return
	end

	self._handler = handler
	self._handlerTarget = handlerTarget

	Arena3v3Agent.instance:sendArena3v3InfoReq(self._onArena3v3InfoRes, self)
end

function SeniorArenaController:_onArena3v3InfoRes(msg)
	SeniorArenaModel.instance:setArenaInfo(msg)
	SeniorArenaModel.instance:setAllTargets(msg.allTargets)
	self:_callback()
end

function SeniorArenaController:checkMyDefendForms(handler, handlerTarget)
	if not SeniorArenaController.instance:getIsOpen(true) then
		return
	end

	self._handler = handler
	self._handlerTarget = handlerTarget

	Arena3v3Agent.instance:sendArena3v3MyDefenseFormationReq(self._onMyDefendFormsGet, self, self._errorCall)
end

function SeniorArenaController:_onMyDefendFormsGet(msg)
	SeniorArenaModel.instance:setMyDefendForms(msg.formView.forms)

	local forms = SeniorArenaModel.instance:getMyDefendFormMos()

	for i, v in pairs(forms) do
		v._isMe = true
	end

	self:_callback()
end

function SeniorArenaController:reqGetMyAttackForm(handler, handlerTarget)
	if not SeniorArenaController.instance:getIsOpen(true) then
		return
	end

	self._handler = handler
	self._handlerTarget = handlerTarget

	Arena3v3Agent.instance:sendArena3v3MyAttackFormationReq(self._onMyAttackFormRes, self, self._errorCall)
end

function SeniorArenaController:_onMyAttackFormRes(msg)
	SeniorArenaModel.instance:setMyAttackForms(msg.formView.forms)
	GlobalDispatcher:dispatch(GlobalNotify.MyAttackFormGet)
	self:_callback()
end

function SeniorArenaController:reqChallenge(handler, handlerTarget, isXiaoNuoAssist)
	if not SeniorArenaController.instance:getIsOpen(true) then
		return
	end

	local info = SeniorArenaModel.instance:getArenaInfo()
	local targetUserId = self:getCurOpponentId()

	if not isXiaoNuoAssist then
		UIJumper.instance:pushOneStack(ViewName.SeniorArenaMainView, true)
	end

	Arena3v3Agent.instance:sendArena3v3ChallengeReq(info.seasonId, targetUserId, self._onChallengeRes, self, self._errorCall)
	printInfo("test SeniorArenaController:reqChallenge isXiaoNuoAssist", isXiaoNuoAssist)

	self._isXiaoNuoAssist = isXiaoNuoAssist
end

function SeniorArenaController:_onChallengeRes(msg)
	self._battleRank = SeniorArenaModel.instance:getMyRank()
	self._battlePlayerInfo = self:getCurOpponentInfo()
	self._battlePlayerFormMos = self:getCurOpponentFormMos()

	SeniorArenaModel.instance:setMyRank(msg.newRank)
	SeniorArenaModel.instance:setAllTargets(msg.allTargets)
	SeniorArenaModel.instance:setMyScore(msg.newScore)

	self._isWin = msg.isWin
	self._btlResults = msg.battleResult
	self._battleMsg = msg

	if not self._isXiaoNuoAssist then
		self:_startBattle()
	end

	GlobalDispatcher:dispatch(GlobalNotify.SeniorArenaInfoFresh)
end

function SeniorArenaController:getBattleMsg()
	return self._battleMsg
end

function SeniorArenaController:reqBuyTicket(wantBuyTimes)
	if not SeniorArenaController.instance:getIsOpen(true) then
		return
	end

	Arena3v3Agent.instance:sendArena3v3BuyChallengeItemReq(wantBuyTimes, self._onBuyTicketRes, self)
end

function SeniorArenaController:_onBuyTicketRes(msg)
	FloatWordMgr.instance:show("购买成功~")
	SeniorArenaModel.instance:setBuyTicketTime(msg.challengeBuyTime)
end

function SeniorArenaController:reqGainHangUpPrize(handler, handlerTarget)
	if not SeniorArenaController.instance:getIsOpen(true) then
		return
	end

	self._handler = handler
	self._handlerTarget = handlerTarget

	Arena3v3Agent.instance:sendArena3v3GainHangUpPrizeReq(self._onGainHangUpPrizeRes, self, self._errorCall)
end

function SeniorArenaController:_onGainHangUpPrizeRes(msg)
	SeniorArenaModel.instance:setHangUpInfo(msg.hangUpPrize)
	self:_callback()
end

function SeniorArenaController:reqRefreshOpponents(handler, handlerTarget)
	if not SeniorArenaController.instance:getIsOpen(true) then
		return
	end

	self._handler = handler
	self._handlerTarget = handlerTarget

	local info = SeniorArenaModel.instance:getArenaInfo()

	Arena3v3Agent.instance:sendArena3v3RefreshTargetsReq(info.seasonId, self._onRefreshOpponentsRes, self, self._errorCall)
end

function SeniorArenaController:_onRefreshOpponentsRes(msg)
	SeniorArenaModel.instance:setAllTargets(msg.allTargets)
	SeniorArenaModel.instance:setMyRank(msg.rank)
	SeniorArenaModel.instance:setHangUpInfo(msg.hangUpPrize)
	SeniorArenaModel.instance:setNextManualRefreshTime(msg.cd)
	self:_callback()
end

function SeniorArenaController:reqOtherFormation(userId, handler, handlerTarget)
	if not SeniorArenaController.instance:getIsOpen(true) then
		return
	end

	self._handler = handler
	self._handlerTarget = handlerTarget
	self._userId = userId

	Arena3v3Agent.instance:sendArena3v3OtherFormationReq(userId, self._onOtherFormationRes, self, self._errorCall)
end

function SeniorArenaController:_onOtherFormationRes(msg)
	SeniorArenaModel.instance:setOppenentDefendForms(self._userId, msg.formView.forms)
	self:_callback()
end

function SeniorArenaController:logCacheForms()
	do return end

	print("logCacheForms")
	print(debug.traceback())

	for _, v in ipairs(self._ca) do
		local str = ""

		str = str .. "tabId = " .. v.formId
		str = str .. " formId = " .. v.formationId
		str = str .. " heroSkillId = " .. v.heroSkillId
		str = str .. " formStrengthId = " .. v.formStrengthId
		str = str .. " psychicSkillId = " .. v.psychicSkillId
		str = str .. " formStrengthLv = " .. v.formStrengthLv
		str = str .. " pos = "

		for i = 1, 9 do
			if v.pos[i] > 0 then
				str = str .. v.pos[i]
			end
		end

		print(str)
	end
end

function SeniorArenaController:getCacheTabRedPointState(idx)
	local petIdDic = {}

	for i = 1, 3 do
		if i ~= idx then
			local form = self:getCacheForm(i)

			if form then
				for _, v in ipairs(form.pos) do
					if v > 0 then
						petIdDic[v] = true
					end
				end
			end
		end
	end

	local maxPetNum = 5
	local pets = BagModel.instance:getCullingBagPets(petIdDic)
	local totalNum = BagModel.instance:diffRacePetCount(pets)
	local curPetNum = self:getCacheFormPetNum(idx)

	print("idx == " .. idx .. " curPetNum = " .. curPetNum .. " totalNum = " .. totalNum .. " len = " .. #pets)

	if curPetNum == 0 then
		return 1
	elseif curPetNum < totalNum and curPetNum < maxPetNum then
		return 2
	else
		return 0
	end
end

function SeniorArenaController:initCacheForms(isAttack)
	self._cacheForms = {}
	self._formMap = {}

	local forms = isAttack == true and SeniorArenaModel.instance:getMyAttackFormMos() or SeniorArenaModel.instance:getMyDefendFormMos()

	for i = 1, 3 do
		local form = forms[i]
		local fmtMo = FormationMO.New()

		if form then
			fmtMo:SetData(form._curForm)
		end

		self._formMap[i] = fmtMo

		local cacheForm = {}

		if form then
			cacheForm._curForm = form._curForm or nil
		end

		cacheForm.formId = i
		cacheForm.formationId = 0
		cacheForm.heroSkillId = 0
		cacheForm.psychicSkillId = 0
		cacheForm.formStrengthId, cacheForm.formStrengthLv = 0, 0
		cacheForm.pos = {}

		for i = 1, 9 do
			table.insert(cacheForm.pos, 0)
		end

		if form then
			cacheForm.formId = i
			cacheForm.formationId = form:getFormationId()
			cacheForm.heroSkillId = form:getHeroSkillId()
			cacheForm.psychicSkillId = form:getPsychicedSkillId()
			cacheForm.formStrengthId, cacheForm.formStrengthLv = 0, 0

			local mid, pid = form:getElementPetId()

			cacheForm.elementalMasterId = mid
			cacheForm.elementalTargetId = pid
			cacheForm.cutePetId = form:GetCutePetId()
			cacheForm.cutePetRaceId = form:GetCutePetRaceId()
			cacheForm.cutePetQuality = form:GetCutePetQuality()
			cacheForm.pos = {}

			for i = 1, 9 do
				table.insert(cacheForm.pos, form:getPetIdByPos(i))
			end
		end

		table.insert(self._cacheForms, cacheForm)
	end

	self:logCacheForms()
end

function SeniorArenaController:swapCacheForms(idxs)
	if idxs == nil then
		return
	end

	if self._cacheForms then
		local newForms = {}

		for k, v in ipairs(idxs) do
			local form = self._cacheForms[v]

			form.formId = k

			table.insert(newForms, form)
		end

		self._cacheForms = newForms
	end

	GlobalDispatcher:dispatch(GlobalNotify.SeniorCacheFormsChanged, idxs)
end

function SeniorArenaController:getCacheFormPetNum(idx)
	local form = self:getCacheForm(idx)
	local num = 0

	if form then
		for _, v in ipairs(form.pos) do
			if v > 0 then
				num = num + 1
			end
		end
	end

	return num
end

function SeniorArenaController:getCacheForm(idx)
	if self._cacheForms then
		for _, v in ipairs(self._cacheForms) do
			if v.formId == idx then
				return v
			end
		end
	end
end

function SeniorArenaController:getTabIdx(petId)
	if self._cacheForms then
		for _, v in ipairs(self._cacheForms) do
			for _, v2 in ipairs(v.pos) do
				if v2 == petId then
					return v.formId
				end
			end
		end
	end

	return nil
end

function SeniorArenaController:getRaceIdTabIdx(raceId)
	if self._cacheForms then
		for _, v in ipairs(self._cacheForms) do
			for _, v2 in ipairs(v.pos) do
				if v2 > 0 then
					local petMo = BagPetsController.instance:getPet(v2)

					if petMo.raceId == raceId then
						return v.formId
					end
				end
			end
		end
	end

	return nil
end

function SeniorArenaController:isInOtherTab(petId)
	local curTab = self:getCurFormTab()
	local petMo = BagPetsController.instance:getPet(petId)

	if petMo then
		local tab = self:getRaceIdTabIdx(petMo.raceId)

		if tab ~= nil and curTab ~= tab then
			return tab
		end
	end

	local tabIdx = self:getTabIdx(petId)

	if tabIdx ~= nil and curTab ~= tabIdx then
		return tabIdx
	end

	return nil
end

function SeniorArenaController:isSameRaceIdInOtherTab(petId)
	local petMo = BagPetsController.instance:getPet(petId)

	if petMo == nil then
		return
	end

	local raceId = petMo.raceId
	local curTab = self:getCurFormTab()

	if self._cacheForms then
		for _, v in ipairs(self._cacheForms) do
			if v.formId ~= curTab then
				for _, v2 in ipairs(v.pos) do
					local curPetMo = BagPetsController.instance:getPet(v2)

					if curPetMo and curPetMo.raceId == raceId then
						return v.formId
					end
				end
			end
		end
	end
end

function SeniorArenaController:clearSameRaceIdInOtherTab(petId)
	local petMo = BagPetsController.instance:getPet(petId)

	if petMo == nil then
		return
	end

	local raceId = petMo.raceId
	local curTab = self:getCurFormTab()

	if self._cacheForms then
		for _, v in ipairs(self._cacheForms) do
			if v.formId ~= curTab then
				for k, v2 in ipairs(v.pos) do
					local curPetMo = BagPetsController.instance:getPet(v2)

					if curPetMo and curPetMo.raceId == raceId then
						v.pos[k] = 0
					end
				end
			end
		end
	end
end

function SeniorArenaController:setCurCacheForm(formInfo, formId)
	if self._cacheForms == nil then
		return
	end

	local curTab = self:getCurFormTab()
	local form = self:getCacheForm(curTab)
	local fmtMo = self._formMap[curTab]

	if fmtMo then
		fmtMo:Clone(formInfo, formInfo.summonedPetId)
	end

	if form == nil then
		form = {
			formId = curTab
		}

		table.insert(self._cacheForms, form)
	end

	form.formationId = formId

	local info = formInfo:GetFormStrengthInfo()

	if info then
		form.formStrengthId = checknumber(info.formStrengthId)
		form.formStrengthLv = checknumber(info.formStrengthLv)
	end

	form.elementalMasterId = formInfo:GetElementalMasterId()
	form.elementalTargetId = formInfo:GetElementalTargetId()
	form.cutePetId = formInfo:GetCutePetId()
	form.cutePetRaceId = formInfo:GetCutePetRaceId()
	form.cutePetQuality = formInfo:GetCutePetQuality()

	local positions = formInfo:GetPositions()

	form.pos = {}

	for i = 1, 9 do
		form.pos[i] = positions[i]
	end

	self:logCacheForms()
end

function SeniorArenaController:reqSaveMyForm(isAttack, handler, handlerTarget)
	if not SeniorArenaController.instance:getIsOpen(true) then
		return
	end

	local forms = {}

	for _, v in ipairs(self._cacheForms or {}) do
		local form = Arena3v3Extension_pb.Arena3v3SetFormNO()

		form.formId = v.formId

		local fmtMo = self._formMap[v.formId]

		if fmtMo then
			FormationFacade.createFormPb(form.simpleForm, fmtMo)
		end

		table.insert(forms, form)
	end

	self._handler = handler
	self._handlerTarget = handlerTarget
	self._isAttack = isAttack == true
	self._setForms = forms

	if self._isAttack then
		Arena3v3Agent.instance:sendArena3v3SetMyAttackFormationReq(forms, self._onSetMyFormRes, self, self._errorCall)
	else
		Arena3v3Agent.instance:sendArena3v3SetMyDefenseFormationReq(forms, self._onSetMyFormRes, self, self._errorCall)
	end
end

function SeniorArenaController:_onSetMyFormRes(msg)
	if self._isAttack then
		SeniorArenaModel.instance:setMyAttackForms(self._setForms, true)
	else
		FloatWordMgr.instance:show("保存守阵成功~")
		SeniorArenaModel.instance:setMyDefendForms(self._setForms, true)
	end

	self:_callback()
end

function SeniorArenaController:getCurBattleResultIdx()
	return self._curBtlResultIdx
end

function SeniorArenaController:getBtlResults()
	return self._btlResults or {}
end

function SeniorArenaController:getIsWin()
	return self._isWin == true
end

function SeniorArenaController:_startBattle()
	self._curBtlResultIdx = 1
	self._isReplaying = false

	local btlResult = self:getCloneBtlResult()

	if btlResult == nil then
		FloatWordMgr.instance:show("后端返回战斗结果为空")
	else
		BattleFacade.instance:startSeniorArena(btlResult, self._battlePlayerInfo.headInfo)
		BattleModel.instance:setOtherHeadInfo(self._battlePlayerInfo.headInfo)
		BattleController.instance:viewUserFightMonsterBtlResult(btlResult, false)
	end
end

function SeniorArenaController:tryNextBattle()
	if self._isReplaying then
		print("tryNextBattle _isReplaying")

		return false
	end

	self._curBtlResultIdx = self._curBtlResultIdx + 1

	local btlResult = self:getCloneBtlResult()

	print("tryNextBattle idx = " .. self._curBtlResultIdx .. "len = " .. #self._btlResults)

	if btlResult ~= nil then
		BattleFacade.instance:startSeniorArena()
		BattleController.instance:onBattleContinue(btlResult)

		return true
	end

	return false
end

function SeniorArenaController:getCloneBtlResult(idx)
	local btlResult = self._btlResults[self._curBtlResultIdx]

	if btlResult then
		local str = btlResult:SerializeToString()
		local msgClone = BattleExtension_pb.PM_BattleResult()

		msgClone:ParseFromString(str)

		return msgClone
	end
end

function SeniorArenaController:replayBattle(idx)
	self._isReplaying = true
	self._curBtlResultIdx = idx

	local btlResult = self:getCloneBtlResult()

	if btlResult ~= nil then
		BattleFacade.instance:startSeniorArena()
		BattleController.instance:onBattleContinue(btlResult)
	end
end

function SeniorArenaController:getIsOpen(isTips)
	return self:_checkDailyOpen(isTips) and self:_checkSeasonOpen(isTips)
end

function SeniorArenaController:_checkDailyOpen(isTips)
	local startTime = SeniorArenaConfig.instance:getCommonValue("SETTLE_BEGIN_TIME")
	local endTime = SeniorArenaConfig.instance:getCommonValue("SETTLE_END_TIME")
	local startHour, startMin = unpack(string.splitToNumber(startTime, ":"))
	local endHour, endMin = unpack(string.splitToNumber(endTime, ":"))
	local nowDate = ServerTime.nowDate()
	local nowSecs = nowDate.hour * 3600 + nowDate.min * 60 + nowDate.sec
	local isInTime = nowSecs > startHour * 3600 + startMin * 60 and nowSecs < endHour * 3600 + endMin * 60

	if isInTime then
		local text = string.format("高阶竞技场每天在%02d:%02d-%02d:%02d关闭并结算排名", startHour, startMin, endHour, endMin)

		if isTips == true then
			TipsFacade.instance:openTipWindow("提示", text, function()
				UIStateManager.instance:clear(true)
			end)
		elseif isTips == false then
			-- block empty
		else
			FloatWordMgr.instance:show(text)
		end
	end

	return not isInTime
end

function SeniorArenaController:_checkSeasonOpen(isTips)
	local cfgs = SeniorArenaConfig.instance:getSeasonCfgList()
	local now = ServerTime.now()

	for _, v in ipairs(cfgs) do
		local time = GameUtil.string2time(v.seasonBeginTime)
		local endTime = time + 18000
		local startTime = time - 7200

		if now < endTime then
			local isInTime = startTime < now

			if isInTime then
				local text = "今日22:00~明日5:00竞技场赛季结算，请之后再来吧！"

				if isTips then
					TipsFacade.instance:openTipWindow("提示", text, function()
						UIStateManager.instance:clear(true)
					end, "好的")
				elseif isTips == false then
					-- block empty
				else
					FloatWordMgr.instance:show(text)
				end
			end

			return not isInTime
		end
	end

	return true
end

SeniorArenaController.instance = SeniorArenaController.New()

return SeniorArenaController
