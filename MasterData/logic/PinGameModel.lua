-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pingame/model/PinGameModel.lua

module("logic.extensions.pingame.model.PinGameModel", package.seeall)

local PinGameModel = class("PinGameModel", BaseModel)

function PinGameModel:onInit()
	self:onReset()
end

function PinGameModel:onReset()
	self._agentList = {}
end

function PinGameModel:getAgentInfo(activityId)
	self._agentList[activityId] = self._agentList[activityId] or {}

	return self._agentList[activityId]
end

function PinGameModel:onPinGameInfoRes(msg)
	local info = self:getAgentInfo(msg.activityId)

	info.score = msg.score
	info.gainPrizeIds = GameUtil.pbToTable(msg.gainPrizeIds) or {}
	info.todayGameTimes = msg.todayGameTimes
	info.sweepableMode = msg.sweepableMode
end

function PinGameModel:onPinGameStartGameRes(msg)
	local info = self:getAgentInfo(msg.activityId)

	info.startGameMode = msg.mode
	info.startGameStageId = msg.stageId
	info.serverKey = msg.serverKey
end

function PinGameModel:onPinGameEndGameRes(msg)
	local info = self:getAgentInfo(msg.activityId)

	info.endGameMode = msg.mode
	info.endGameStageId = msg.stageId
	info.isPass = msg.isPass

	if info.isPass then
		info.addScore = msg:HasField("addScore") and msg.addScore or 0

		if msg:HasField("totalScore") then
			info.score = msg.totalScore
		end

		info.todayGameTimes = info.todayGameTimes + 1
		info.sweepableMode = info.sweepableMode or {}

		if table.indexof(info.sweepableMode, msg.mode) == false then
			table.insert(info.sweepableMode, msg.mode)
		end
	end
end

function PinGameModel:onPinGameRecoverRes(msg)
	return
end

function PinGameModel:onPinGameGainPrizeRes(msg)
	local info = self:getAgentInfo(msg.activityId)

	if not TableUtil.isHad(info.gainPrizeIds, msg.prizeId) then
		table.insert(info.gainPrizeIds, msg.prizeId)
	end
end

function PinGameModel:handlePM_PinGameSweepRes(msg)
	local info = self:getAgentInfo(msg.activityId)

	info.todayGameTimes = msg.todayGameTimes
	info.score = msg.totalScore
	info.addScore = msg.addScore
end

function PinGameModel:getActivityId()
	return checknumber(PinGameConfig.instance:getCommonValue("CUR_ACTID"))
end

function PinGameModel:getActivityType()
	return GameEnum.ActivityType.PinGame
end

function PinGameModel:getWorldProgressActId()
	return checknumber(PinGameConfig.instance:getCommonValue("WORLD_PROGRESS_ACTID"))
end

function PinGameModel:getTodayGameTimes(activityId)
	local info = self:getAgentInfo(activityId)

	return info.todayGameTimes
end

function PinGameModel:setClientKey(activityId)
	local clientKey = math.random(1, 100000000)
	local info = self:getAgentInfo(activityId)

	info._clientKey = clientKey

	printInfo("test 随机数", clientKey)

	return clientKey
end

function PinGameModel:getClientKey(activityId)
	return self:getAgentInfo(activityId)._clientKey
end

function PinGameModel:getServerKey(activityId)
	return self:getAgentInfo(activityId).serverKey
end

function PinGameModel:getStartGameMode(activityId)
	return self:getAgentInfo(activityId).startGameMode
end

function PinGameModel:getStartGameStageId(activityId)
	return self:getAgentInfo(activityId).startGameStageId
end

function PinGameModel:isGetedPrize(activityId, prizeId)
	local info = self:getAgentInfo(activityId)

	return TableUtil.isHad(info.gainPrizeIds, prizeId)
end

function PinGameModel:isCanGetPrize(activityId, needScore)
	local info = self:getAgentInfo(activityId)

	return info.score and needScore <= info.score
end

function PinGameModel:isAnyCanGetPrize(activityId)
	local cfgs = PinGameConfig.instance:getScorePrizeList(activityId)

	for i, v in ipairs(cfgs) do
		local isGetedPrize = self:isGetedPrize(activityId, v.prizeId)
		local isCanGetPrize = self:isCanGetPrize(activityId, v.needScore)

		if not isGetedPrize and isCanGetPrize then
			return true
		end
	end

	return false
end

function PinGameModel:getScore(activityId)
	local info = self:getAgentInfo(activityId)

	return info.score
end

function PinGameModel:isSweepable(activityId, mode)
	local info = self:getAgentInfo(activityId)

	if info.sweepableMode then
		return table.indexof(info.sweepableMode, mode) ~= false
	end

	return false
end

PinGameModel.instance = PinGameModel.New()

return PinGameModel
