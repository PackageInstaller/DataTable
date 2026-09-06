-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamteam/controller/DreamTeamController.lua

module("logic.extensions.dreamteam.controller.DreamTeamController", package.seeall)

local DreamTeamController = class("DreamTeamController", BaseController)

function DreamTeamController:ctor()
	return
end

function DreamTeamController:onInit()
	GlobalDispatcher:addListener(FlipTouchAgent.PM_FlipTouchGetInfoRes, self._onGetInfoRes, self)
	GlobalDispatcher:addListener(FlipTouchAgent.PM_FlipTouchGainOutPrizeRes, self._onGainOutPrizeRes, self)
	GlobalDispatcher:addListener(FlipTouchAgent.PM_FlipTouchStartGameRes, self._onStartGameRes, self)
	GlobalDispatcher:addListener(FlipTouchAgent.PM_FlipTouchIntoNextStageRes, self._onIntoNextStageRes, self)
	GlobalDispatcher:addListener(FlipTouchAgent.PM_FlipTouchIncreaseStageTimeRes, self._onIncreaseStageTimeRes, self)
	GlobalDispatcher:addListener(FlipTouchAgent.PM_FlipTouchEndGameRes, self._onEndGameRes, self)
	GlobalDispatcher:addListener(FlipTouchAgent.PM_FlipTouchGainGlobalPrizeRes, self._onGainGlobalPrizeRes, self)
end

function DreamTeamController:onReset()
	return
end

function DreamTeamController:sendFlipTouchGainOutPrizeReq(activityId, id)
	self._tempOutPrizeId = id

	FlipTouchAgent.instance:sendPM_FlipTouchGainOutPrizeReq(activityId, id)
end

function DreamTeamController:sendFlipTouchGainGlobalPrizeReq(activityId, id)
	self._globalPrizeId = id

	FlipTouchAgent.instance:sendPM_FlipTouchGainGlobalPrizeReq(activityId, id)
end

function DreamTeamController:_onGetInfoRes(status, msg)
	if status == 0 then
		DreamTeamModel.instance:onGetInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.FlipTouchGetInfo)
	end
end

function DreamTeamController:_onGainOutPrizeRes(status, msg)
	if status == 0 and self._tempOutPrizeId then
		DreamTeamModel.instance:updateGainOutPrizeIds(self._tempOutPrizeId)

		self._tempOutPrizeId = nil
	end
end

function DreamTeamController:_onStartGameRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.FlipTouchStartGame, msg)
	end
end

function DreamTeamController:_onIntoNextStageRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.FlipTouchIntoNextStage)
	end
end

function DreamTeamController:_onIncreaseStageTimeRes(status, msg)
	local isSuccess = status == 0

	GlobalDispatcher:dispatch(GlobalNotify.FlipTouchIncreaseStageTime, isSuccess)
end

function DreamTeamController:_onEndGameRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.FlipTouchEndGame, msg)
	end
end

function DreamTeamController:_onGainGlobalPrizeRes(status, msg)
	if status == 0 then
		if self._globalPrizeId then
			DreamTeamModel.instance:updateGlobalPrizeIds(self._globalPrizeId)

			self._globalPrizeId = nil
		end

		GlobalDispatcher:dispatch(GlobalNotify.FlipTouchGainGlobalPrize)
	end
end

function DreamTeamController:getLeftDay(activityId)
	local startTimestamp, endTimestamp = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.DreamTeam, activityId)
	local curTimeDate = GameUtil.time2date(ServerTime.now())

	if curTimeDate.hour < 5 then
		curTimeDate.day = curTimeDate.day - 1
	end

	curTimeDate.hour = 5
	curTimeDate.min = 0
	curTimeDate.sec = 0

	local curTimestamp = os.time(curTimeDate)

	if curTimestamp < startTimestamp then
		return math.round((endTimestamp - startTimestamp) / 60 / 60 / 24)
	elseif startTimestamp <= curTimestamp and curTimestamp <= endTimestamp then
		return math.round((endTimestamp - curTimestamp) / 60 / 60 / 24)
	else
		return 0
	end
end

function DreamTeamController:getEnergyList(planId, oldEnergy, newEnergy)
	local energyList = {}

	for i = 1, 5 do
		energyList[i] = {}
		energyList[i].oldEnergy = 0
		energyList[i].newEnergy = 0
	end

	printInfo("test 老的总能量：新的总能量", oldEnergy, newEnergy)

	local cfgPrizes = DreamTeamConfig.instance:getOutPrizeCfgs(planId)

	if cfgPrizes then
		for i, cfg in ipairs(cfgPrizes) do
			if energyList[i] then
				energyList[i].oldEnergy = 0

				if oldEnergy <= cfg.energy then
					energyList[i].oldEnergy = oldEnergy
					oldEnergy = 0
				else
					energyList[i].oldEnergy = cfg.energy
					oldEnergy = oldEnergy - cfg.energy
				end

				energyList[i].newEnergy = 0

				if newEnergy <= cfg.energy then
					energyList[i].newEnergy = newEnergy
					newEnergy = 0
				else
					energyList[i].newEnergy = cfg.energy
					newEnergy = newEnergy - cfg.energy
				end
			end
		end
	end

	for i, v in ipairs(energyList) do
		printInfo("test 单个能量", i, v.oldEnergy, v.newEnergy)
	end

	return energyList
end

function DreamTeamController:isEnoughTimesOfPlayGame(activityId)
	return self:getLeftUseTimes(activityId) > 0
end

function DreamTeamController:getLeftUseTimes(activityId)
	activityId = checknumber(activityId)

	local usedTimes = DreamTeamModel.instance:getUsedTimes()
	local data = DreamTeamConfig.instance:getActivityCfgById(activityId)

	if data then
		if not data.dailyTimes then
			local totalTimes = 0

			return Mathf.Max(totalTimes - usedTimes, 0)
		end
	end
end

function DreamTeamController:isInActTimeOfPlayGame(activityId)
	return ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.DreamTeam, checknumber(activityId))
end

function DreamTeamController:getTryPlayGameOfResultAndTips(activityId)
	activityId = checknumber(activityId)

	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInActTimeOfPlayGame(activityId) then
		result = GameEnum.ResultCode.NotInTime
		tips = "不在活动时间范围内"
	elseif not self:isEnoughTimesOfPlayGame(activityId) then
		result = GameEnum.ResultCode.NotEnoughTimes
		tips = "游戏次数不足"
	end

	return result, tips
end

DreamTeamController.instance = DreamTeamController.New()

return DreamTeamController
