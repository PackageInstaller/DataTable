-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funarena/controller/FunArenaController.lua

module("logic.extensions.funarena.controller.FunArenaController", package.seeall)

local FunArenaController = class("FunArenaController", BaseController)

function FunArenaController:ctor()
	return
end

function FunArenaController:onInit()
	return
end

function FunArenaController:onReset()
	self.curTempBuffId = 0
end

function FunArenaController:onSendGetInfoReq()
	FunArenaAgent.instance:sendPM_BigCastChallengeGetInfoReq()
end

function FunArenaController:onHandleGetInfoRes(msg)
	FunArenaModel.instance:onHandleGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.FunArenaGetInfo)
end

function FunArenaController:onSendSetFormReq()
	FunArenaModel.instance:updateCurForm()

	local activityId = FunArenaModel.instance.activityId
	local form = FunArenaModel.instance:getCurForm()

	FunArenaAgent.instance:sendPM_BigCastChallengeSetFormReq(activityId, form)
end

function FunArenaController:onHandleSetFormRes(msg)
	FunArenaModel.instance:onHandleSetFormRes(msg)
end

function FunArenaController:onSendFightReq(activityId)
	BattleFacade.instance:registerResultHandler(self._handlerBattleEnd, nil)
	FunArenaAgent.instance:sendPM_BigCastChallengeFightReq(activityId)
end

function FunArenaController:onHandleFightRes(msg)
	FunArenaModel.instance:onHandleFightRes(msg)
end

function FunArenaController:_handlerBattleEnd()
	BattleFacade.instance:registerResultHandler(nil, nil)

	local function succHandler()
		UIJumper.instance:pushOneStack(ViewName.FunArenaView, true)

		local isHasOutLimitFail = FunArenaController.instance:isHasOutLimitFail()
		local isHasOutLimitChallenge = FunArenaController:isHasOutLimitChallenge()
		local isHasFinishOneRound = FunArenaController.instance:isHasFinishOneRound()

		if not isHasOutLimitFail and not isHasOutLimitChallenge and not isHasFinishOneRound then
			UIJumper.instance:pushOneStack(ViewName.FunArenaHallView, true)
		end

		BattleController.instance:endBattle()
	end

	local function failHandler()
		UIJumper.instance:pushOneStack(ViewName.FunArenaView, true)

		local isHasOutLimitFail = FunArenaController.instance:isHasOutLimitFail()
		local isHasOutLimitChallenge = FunArenaController:isHasOutLimitChallenge()
		local isHasFinishOneRound = FunArenaController.instance:isHasFinishOneRound()

		if not isHasOutLimitFail and not isHasOutLimitChallenge and not isHasFinishOneRound then
			UIJumper.instance:pushOneStack(ViewName.FunArenaHallView, true)
			UIJumper.instance:pushOneStack(ViewName.FunArenaBuffView, true)
		end

		BattleController.instance:endBattle()
	end

	if BattleModel.instance.battleResult == GameEnum.BattleResult.ExpSuccess then
		UIStateManager.instance:push(ViewName.FunArenaSuccessView, succHandler)
	elseif BattleModel.instance.battleResult == GameEnum.BattleResult.Success then
		UIStateManager.instance:push(ViewName.FunArenaSuccessView, succHandler)
	elseif BattleModel.instance.battleResult == GameEnum.BattleResult.DogFall then
		UIStateManager.instance:push(ViewName.FunArenaFailSimpleView, failHandler)
	elseif BattleModel.instance.battleResult == GameEnum.BattleResult.Failed then
		UIStateManager.instance:push(ViewName.FunArenaFailSimpleView, failHandler)
	end

	return true
end

function FunArenaController:onSendChooseBuffReq(activityId, buffId)
	self.curTempBuffId = buffId

	FunArenaAgent.instance:sendPM_BigCastChallengeChooseBuffReq(activityId, buffId)
end

function FunArenaController:onHandleChooseBuffRes(msg)
	local buffId = self.curTempBuffId
	local buffCfgs = FunArenaConfig.instance:getBuffCfgs()
	local data = buffCfgs[buffId]

	if data then
		local type = data.type

		if type == 1 then
			table.insert(FunArenaModel.instance._infoRes.propsBuffIds, buffId)
		elseif type == 2 then
			table.insert(FunArenaModel.instance._infoRes.funcBuffIds, buffId)
		end
	end

	FunArenaModel.instance._infoRes.canGainBuffIds = {}

	GlobalDispatcher:dispatch(GlobalNotify.FunArenaGetInfo)

	local fightRound = FunArenaModel.instance._infoRes.fightRound

	if fightRound == 0 then
		FunArenaController.instance:onSendFightReq(FunArenaModel.instance.activityId)
	end
end

function FunArenaController:onSendLotteryReq(activityId, handler, handlerObj, errHandler)
	FunArenaAgent.instance:sendPM_BigCastChallengeLotteryReq(activityId, handler, handlerObj, errHandler)
end

function FunArenaController:onHandleLotteryRes(msg)
	FunArenaModel.instance:onHandleLotteryRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.FunArenaGetInfo)
end

function FunArenaController:onSendGainWinStreakPrizeReq(activityId, winStreakTimes)
	FunArenaAgent.instance:sendPM_BigCastChallengeGainWinStreakPrizeReq(activityId, winStreakTimes)
end

function FunArenaController:onHandleGainWinStreakPrizeRes(msg)
	FunArenaModel.instance:onHandleGainWinStreakPrizeRes(msg)
	self:onSendGetInfoReq()
end

function FunArenaController:onSendViewRankReq(activityId)
	FunArenaAgent.instance:sendPM_BigCastChallengeViewRankReq(activityId)
end

function FunArenaController:onHandleViewRankRes(msg)
	FunArenaModel.instance:onHandleViewRankRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.FunArenaGetInfo)
end

function FunArenaController:getCurSuccessNum()
	local fightRound = FunArenaModel.instance._infoRes.fightRound
	local winState = FunArenaModel.instance._infoRes.winState
	local succNum = 0

	for i = 1, fightRound do
		local isSuccess = winState[i]

		if isSuccess == true then
			succNum = succNum + 1
		end
	end

	return succNum
end

function FunArenaController:getCurFailNum()
	local fightRound = FunArenaModel.instance._infoRes.fightRound
	local winState = FunArenaModel.instance._infoRes.winState
	local faliNum = 0

	for i = 1, fightRound do
		local isSuccess = winState[i]

		if not isSuccess then
			faliNum = faliNum + 1
		end
	end

	return faliNum
end

function FunArenaController:isHasOutLimitFail()
	local actId = FunArenaModel.instance.activityId
	local challengeCfg = FunArenaConfig.instance:getChallengeCfgById(actId)

	if challengeCfg then
		local failWhenLoseTimes = challengeCfg.failWhenLoseTimes
		local failNum = self:getCurFailNum()

		return failWhenLoseTimes <= failNum
	end

	return true
end

function FunArenaController:isHasOutLimitChallenge()
	local actId = FunArenaModel.instance.activityId
	local challengeCfg = FunArenaConfig.instance:getChallengeCfgById(actId)

	if challengeCfg then
		local fightTimes = challengeCfg.fightTimes
		local curFightTimes = FunArenaModel.instance._infoRes.fightTimes

		return fightTimes <= curFightTimes
	end

	return true
end

function FunArenaController:isHasFinishOneRound()
	local enemyList = FunArenaModel.instance._infoRes.enemyList
	local enemyNum = #enemyList
	local curFightRound = FunArenaModel.instance._infoRes.fightRound

	return enemyNum <= curFightRound
end

function FunArenaController:isCanLotter()
	local isCanLotter = false
	local activityId = FunArenaModel.instance.activityId
	local challengeCfg = FunArenaConfig.instance:getChallengeCfgById(activityId)

	if challengeCfg then
		local lotteryScore = FunArenaModel.instance._infoRes.lotteryScore
		local lotteryCost = checknumber(challengeCfg.lotteryCost)

		if lotteryCost <= lotteryScore then
			isCanLotter = true
		end
	end

	return isCanLotter
end

function FunArenaController:isCanGetSpecialReward()
	local isCanGetSpecialReward = false
	local activityId = FunArenaModel.instance.activityId
	local winStreakPrizeCfg = FunArenaConfig.instance:getWinStreakPrizeCfgsById(activityId)
	local winStreakPrizeGainState = FunArenaModel.instance._infoRes.winStreakPrizeGainState
	local bestWinStreakTimes = FunArenaModel.instance._infoRes.bestWinStreakTimes

	for _, data in pairs(winStreakPrizeCfg) do
		local isHasGain = false

		for i = 1, #winStreakPrizeGainState do
			if not winStreakPrizeGainState[i] then
				if winStreakPrizeGainState[i] == data.winStreakTimes then
					isHasGain = true
				end
			end
		end

		local isEnoughTimes = bestWinStreakTimes >= data.winStreakTimes
		local isCanGet = not isHasGain and isEnoughTimes

		if isCanGet == true then
			isCanGetSpecialReward = true

			break
		end
	end

	return isCanGetSpecialReward
end

FunArenaController.instance = FunArenaController.New()

return FunArenaController
