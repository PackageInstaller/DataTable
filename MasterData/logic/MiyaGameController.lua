-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/controller/MiyaGameController.lua

module("logic.extensions.timelimitedchallenge.controller.MiyaGameController", package.seeall)

local MiyaGameController = class("MiyaGameController", BaseController)

function MiyaGameController:ctor()
	return
end

function MiyaGameController:onInit()
	TimedChallengeMiYaAgent.instance:addHandler(TimedChallengeMiYaAgent.PM_TimedChallengeMiYaBuyAwakenGoodsRes, self._onBuyGoodRes, self)
end

function MiyaGameController:onReset()
	return
end

function MiyaGameController:getRecommendZdl(difficulty)
	local worldZdl = MiyaGameModel.instance:getWorldZdl()
	local difficultyCfg = MiyaGameConfig.instance:getDifficultyCfg(difficulty)

	return math.max(math.floor(difficultyCfg.recommendDynamicParam / 10000 * worldZdl), difficultyCfg.recommendZdl)
end

function MiyaGameController:randomModeReq(difficulty, handler, handlerObj, ignoreCost)
	local difficultyCfg = MiyaGameConfig.instance:getDifficultyCfg(difficulty)

	print("ignoreCost = " .. tostring(ig))

	if ignoreCost ~= true and not MaterialMgr.getMatEnough(difficultyCfg.costMaterial) then
		local matType, id, matNum = MaterialMgr.getMatParams(difficultyCfg.costMaterial)
		local cfg = MaterialMgr.getMatCfg(matType, id)

		if cfg ~= nil then
			FloatWordMgr.instance:show(MaterialMgr.getMaterialsName(matType, id) .. "不足")
		end

		return
	end

	self._difficulty, self._handler, self._handlerObj = difficulty, handler, handlerObj

	TimedChallengeMiYaAgent.instance:sendPM_TimedChallengeMiYaRandomModeReq(difficulty, self._onRandomModeRes, self)
end

function MiyaGameController:_onRandomModeRes(msg)
	MiyaGameModel.instance:setCurDifficulty(self._difficulty)
	MiyaGameModel.instance:setCurModeId(msg.curModeId)
	MiyaGameModel.instance:setRivalId(0)
	GameUtil.callBack(self._handler, self._handlerObj)
end

function MiyaGameController:startGameReq(handler, handlerObj)
	self._handler, self._handlerObj = handler, handlerObj

	local curModeId = MiyaGameModel.instance:getCurModeId()
	local clientKey

	TimedChallengeMiYaAgent.instance:sendPM_TimedChallengeMiYaProcessModeReq(1, (curModeId == GameEnum.MiyaModeType.FIND_DIFFERENCE or curModeId == GameEnum.MiyaModeType.ANSWER_QUIZ or nil) and MiyaGameModel.instance:randomClientKey(), nil, nil, {}, {}, self._onStartGameRes, self)
end

function MiyaGameController:_onStartGameRes(msg)
	MiyaGameModel.instance:setRivalId(msg.rivalId)
	MiyaGameModel.instance:setServerKey(msg.serverKey)
	GameUtil.callBack(self._handler, self._handlerObj)
end

function MiyaGameController:endGameReq(isWin, handler, handlerObj, differentNum, questionIds, answerIds)
	self._isWin, self._handler, self._handlerObj = isWin, handler, handlerObj

	local encryptedKey

	encryptedKey = curModeId == GameEnum.MiyaModeType.FIND_DIFFERENCE and MiyaGameModel.instance:getEncryptedKey(differentNum) or (curModeId ~= GameEnum.MiyaModeType.ANSWER_QUIZ or true) and encryptedKey
	self._needOpenResult = true

	TimedChallengeMiYaAgent.instance:sendPM_TimedChallengeMiYaProcessModeReq(3, nil, encryptedKey, differentNum, questionIds or {}, answerIds or {})
end

function MiyaGameController:onFightFinishRes(msg)
	if self._needOpenResult then
		self._needOpenResult = false

		UIStateManager.instance:push(ViewName.TLCBattleResultView, self._closeView, self)
	end
end

function MiyaGameController:_closeView()
	UIStateManager.instance:popByName(ViewName.MiyaDetailView)
	UIStateManager.instance:popByName(ViewName.MiyaQuizGameView)
	UIStateManager.instance:popByName(ViewName.MiyaFindFaultView)
end

function MiyaGameController:_onBuyGoodRes(msg)
	local buyProcess = MiyaGameModel.instance:getBuyProcess()

	MiyaGameModel.instance:setBuyProcess(buyProcess + 1)
	GlobalDispatcher:dispatch(GlobalNotify.MiyaBuyGoodSuccess)
end

function MiyaGameController:getModeBubbleParams(modeId)
	local difficulty = MiyaGameModel.instance:getCurDifficulty()

	if modeId == GameEnum.MiyaModeType.FIND_DIFFERENCE then
		local findFaultCfg = MiyaGameConfig.instance:getRandomFindfaultCfg(difficulty)

		return findFaultCfg.gameTime, findFaultCfg.passNeedNum
	elseif modeId == GameEnum.MiyaModeType.ANSWER_QUIZ then
		local quizCfg = MiyaGameConfig.instance:getRandomQuizCfg(difficulty)

		return quizCfg.gameTime, quizCfg.passNeedNum
	elseif modeId == GameEnum.MiyaModeType.BOSS_MONSTER then
		local monsterCfgs = MiyaGameConfig.instance:getBossMonsterCfgList()
		local a, b, c, d = 0, 0, 0, 0

		for _, v in ipairs(monsterCfgs) do
			if v.difficulty == difficulty then
				d = v.damageFloorUnit
				c = v.upperDamageHp
				b = v.baseDamgeHp
				a = v.damageHpFactor

				break
			end
		end

		local worldZdl = MiyaGameModel.instance:getWorldZdl()

		print("worldZdl = " .. worldZdl .. "a = " .. a .. "b = " .. b .. "c = " .. c .. "d = " .. d)

		local temp = math.min(c, math.max(b, worldZdl * a))

		print("temp = " .. temp .. "final temp = " .. (temp - temp) % d)

		return temp - temp % d
	end
end

MiyaGameController.instance = MiyaGameController.New()

return MiyaGameController
