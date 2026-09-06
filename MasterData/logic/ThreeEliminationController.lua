-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/threeelimination/controller/ThreeEliminationController.lua

module("logic.extensions.threeelimination.controller.ThreeEliminationController", package.seeall)

local ThreeEliminationController = class("ThreeEliminationController", BaseController)

function ThreeEliminationController:ctor()
	return
end

function ThreeEliminationController:onInit()
	self._stateFsm = SxGameStateFSM.New()

	self._stateFsm:onInit()
	self:onReset()
end

function ThreeEliminationController:onReset()
	self.sxGameInfo = nil
end

function ThreeEliminationController:loadThreeEliminationGame()
	local activityId = ThreeEliminationOtherModel.instance:getCurrActId()

	activityId = checknumber(activityId)

	if activityId <= 0 then
		return
	end

	ThreeEliminationGameAgent.instance:sendPM_ThreeEliminationGameOpenFuncReq(activityId)
end

function ThreeEliminationController:initMapData()
	return
end

function ThreeEliminationController:add2Queue()
	self._stateFsm:swicthState("ThreeEliminationAdd2Queue")
end

function ThreeEliminationController:findScore()
	self._stateFsm:swicthState("ThreeEliminationFindScore")
end

function ThreeEliminationController:scoreAction()
	self._stateFsm:swicthState("ThreeEliminationScoreAction")
end

function ThreeEliminationController:viewSwap()
	self._stateFsm:swicthState("ThreeEliminationViewSwap")
end

function ThreeEliminationController:viewSwapBack()
	self._stateFsm:swicthState("ThreeEliminationViewSwapBack")
end

function ThreeEliminationController:continueFindScore()
	self._stateFsm:swicthState("ThreeEliminationContinueFindScore")
end

function ThreeEliminationController:continueRemove()
	self._stateFsm:swicthState("ThreeEliminationContinueRemove")
end

function ThreeEliminationController:defaultState()
	self._stateFsm:swicthState("ThreeEliminationDefaultState")
end

function ThreeEliminationController:addAction(actionData)
	GlobalDispatcher:dispatch(GlobalNotify.ThreeMathesTryDoAction)

	if (self._stateFsm:getCurStateName() == "ThreeEliminationAdd2Queue" or self._stateFsm:getCurStateName() == "ThreeEliminationDefaultState") and not ThreeEliminationModel.instance:isWaitingMoveRes() then
		local secuss = ThreeEliminationModel.instance:addAction(actionData)

		if secuss then
			self:add2Queue()
		end

		return secuss
	end

	return false
end

function ThreeEliminationController:getCurrStateName()
	return self._stateFsm:getCurStateName()
end

function ThreeEliminationController:playNormalEffect()
	return
end

function ThreeEliminationController:playSpecialEffect()
	return
end

function ThreeEliminationController:isCanDoAction()
	if self._stateFsm:getCurStateName() == "ThreeEliminationAdd2Queue" or self._stateFsm:getCurStateName() == "ThreeEliminationDefaultState" and not ThreeEliminationModel.instance:isWaitingMoveRes() then
		return true
	end

	return false
end

function ThreeEliminationController:getInfo(callback)
	if SxGameModel.instance:getRemainCnt() == nil then
		SxGameAgent.instance:sendUserSiteInfoReq(callback)
	else
		GameUtil.callBack(callback)

		callback = nil
	end
end

function ThreeEliminationController:sendGetActInfo()
	SxGameAgent.instance:sendAncientFossilSiteGetInfoReq()
end

function ThreeEliminationController:onGetActInfo(msg)
	self.sxGameInfo = GameUtil.pbToTable(msg)
	self.sxGameInfo.gainPrizeIds = self.sxGameInfo.gainPrizeIds or {}

	GlobalDispatcher:dispatch(GlobalNotify.SxActInfoUpdate, self)
end

function ThreeEliminationController:sendGetProgressPrize(periodId, prizeId)
	SxGameAgent.instance:sendGainScorePrizeReq(periodId, prizeId)
end

function ThreeEliminationController:onGetProgressPrize(msg)
	if self.sxGameInfo then
		table.insert(self.sxGameInfo.gainPrizeIds, msg.prizeId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.SxActInfoUpdate, self)
end

function ThreeEliminationController:getGainPrizeIds()
	if self.sxGameInfo then
		return self.sxGameInfo.gainPrizeIds
	end

	return {}
end

function ThreeEliminationController:getResiduePlayTimes()
	if self.sxGameInfo then
		local hasPlayTimes = self.sxGameInfo.hasPlayTimes
		local total = checknumber(MiniGameCollectionConfig.instance:getParamValueByKey("SX_DAILY_MAX_TIMES"))

		return total - hasPlayTimes
	end

	return 0
end

function ThreeEliminationController:getActScore()
	if self.sxGameInfo then
		return self.sxGameInfo.score
	end

	return 0
end

function ThreeEliminationController:sendPM_ThreeEliminationGetInfo4RedPointReqOnLoginIn()
	local activityId = ThreeEliminationOtherModel.instance:getCurrActId()

	if activityId then
		ThreeEliminationGameAgent.instance:sendPM_ThreeEliminationGetInfo4RedPointReq(activityId)
	else
		ThreeEliminationOtherModel.instance:setLevelUpRedPoint()
	end
end

function ThreeEliminationController:handlePM_ThreeEliminationGetInfo4RedPointRes(msg)
	ThreeEliminationOtherModel.instance:setInfoByGetRedPoont(msg)
	ThreeEliminationOtherModel.instance:setLevelUpRedPoint()
	GlobalDispatcher:dispatch(GlobalNotify.PM_ThreeEliminationGetInfo4RedPointRes)
end

function ThreeEliminationController:handlePM_ThreeEliminationGameOpenFuncRes(msg)
	ThreeEliminationOtherModel.instance:saveInfo(msg)
	ThreeEliminationModel.instance:saveInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_ThreeEliminationGameOpenFuncRes)
end

function ThreeEliminationController:handlePM_ThreeEliminationGameCloseFuncRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_ThreeEliminationGameCloseFuncRes)
end

function ThreeEliminationController:handlePM_ThreeEliminationGameLvlUpPlayerRes(msg)
	ThreeEliminationOtherModel.instance:setPlayerLv(msg.playerLvl)
	ThreeEliminationOtherModel.instance:setLevelUpRedPoint()
	GlobalDispatcher:dispatch(GlobalNotify.PM_ThreeEliminationGameLvlUpPlayerRes)
end

function ThreeEliminationController:handlePM_ThreeEliminationGameUnLockBuffRes(msg)
	ThreeEliminationOtherModel.instance:setInfoByUnlockBuff(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_ThreeEliminationGameUnLockBuffRes)
end

function ThreeEliminationController:handlePM_ThreeEliminationGameSetBuffUsingRes(msg)
	ThreeEliminationOtherModel.instance:setInfoByUseBuff(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_ThreeEliminationGameSetBuffUsingRes)
end

function ThreeEliminationController:handlePM_ThreeEliminationGameGainHangUpPrizeRes(msg)
	ThreeEliminationOtherModel.instance:setHangUpInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_ThreeEliminationGameGainHangUpPrizeRes)
end

function ThreeEliminationController:handlePM_ThreeEliminationGameGetRankRes(msg)
	ThreeEliminationOtherModel.instance:saveRankInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_ThreeEliminationGameGetRankRes)
end

function ThreeEliminationController:sendPM_ThreeEliminationGameMoveOneStepReq(activityId, newGainPet, mapInfo)
	local gainList = {}

	for i, v in pairs(newGainPet) do
		if v > 0 then
			for j = 1, v do
				table.insert(gainList, i)
			end
		end
	end

	self:sendPM_ThreeEliminationGameMoveStepReq(activityId, 1, gainList, mapInfo)
end

function ThreeEliminationController:sendPM_ThreeEliminationGameMoveStepReq(activityId, moveStep, newGainPet, mapInfo)
	ThreeEliminationOtherModel.instance:moveStep(moveStep)
	ThreeEliminationGameAgent.instance:sendPM_ThreeEliminationGameMoveStepReq(activityId, moveStep, newGainPet, mapInfo)
end

function ThreeEliminationController:handlePM_ThreeEliminationGameMoveStepRes(msg)
	ThreeEliminationOtherModel.instance:removeTempRemoveByStep()
	GlobalDispatcher:dispatch(GlobalNotify.PM_ThreeEliminationGameMoveStepRes)
end

function ThreeEliminationController:handlePM_ThreeEliminationGameFightRes(msg)
	ThreeEliminationOtherModel.instance:saveFightInfo(msg)

	if msg.changeSetId then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	end

	UIStateManager.instance:push(ViewName.ThreeEliminationBattleView, msg.activityId, msg.from.left, msg.from.right)
	GlobalDispatcher:dispatch(GlobalNotify.PM_ThreeEliminationGameFightRes)
end

function ThreeEliminationController:checkMoveStateAndTip(isUseTip)
	local isCanMove = true
	local activityId = ThreeEliminationModel.instance:getActivityId()
	local activityCfg = ThreeEliminationConfig.instance:getActivityCfg(activityId)

	if activityCfg.maxStepPerRound <= ThreeEliminationOtherModel.instance:getStepCount() then
		if isUseTip == true then
			FloatWordMgr.instance:show(lang("步数用完啦，快去出击吧！"))
		end

		isCanMove = false
	end

	if ThreeEliminationOtherModel.instance:getAttackValue() <= 0 then
		if isUseTip == true then
			FloatWordMgr.instance:show(lang("暂无出击次数"))
		end

		isCanMove = false
	end

	local bestGroup = ThreeEliminationOtherModel.instance:getBestBattleGroup()
	local bestStage = ThreeEliminationOtherModel.instance:getBestBattleStage()
	local groupCfg = ThreeEliminationConfig.instance:getAllGroupCfg(activityId)

	if bestGroup >= #groupCfg and bestStage >= #groupCfg[#groupCfg] then
		if isUseTip == true then
			FloatWordMgr.instance:show(lang("已通关"))
		end

		isCanMove = false
	end

	return isCanMove
end

ThreeEliminationController.instance = ThreeEliminationController.New()

return ThreeEliminationController
