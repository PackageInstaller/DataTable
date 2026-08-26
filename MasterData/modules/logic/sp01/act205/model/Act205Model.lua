-- chunkname: @modules/logic/sp01/act205/model/Act205Model.lua

module("modules.logic.sp01.act205.model.Act205Model", package.seeall)

local Act205Model = class("Act205Model", BaseModel)

function Act205Model:onInit()
	self:reInit()
end

function Act205Model:reInit()
	self.gameInfoMap = {}
end

function Act205Model:getAct205Id()
	return Act205Enum.ActId
end

function Act205Model:setGameStageId(stageId)
	self.curStageId = stageId
end

function Act205Model:getGameStageId()
	return self.curStageId
end

function Act205Model:isAct205Open(isToast)
	local result = false
	local actId = self:getAct205Id()
	local status, toastId, paramList = ActivityHelper.getActivityStatusAndToast(actId)

	if status == ActivityEnum.ActivityStatus.Normal then
		result = true
	elseif toastId and isToast then
		GameFacade.showToastWithTableParam(toastId, paramList)
	end

	return result
end

function Act205Model:isGameStageOpen(gameStageId, isToast)
	local actId = self:getAct205Id()
	local gameInfoMo = self:getGameInfoMo(actId, gameStageId)
	local isGameTimeOpen = self:isGameTimeOpen(gameStageId)
	local result = isGameTimeOpen and gameInfoMo

	if not result and isToast then
		GameFacade.showToast(ToastEnum.ActivityNotOpen)
	end

	return result
end

function Act205Model:isGameTimeOpen(gameStageId)
	local isActOpen = self:isAct205Open(true)

	if not isActOpen then
		return false
	end

	local actId = self:getAct205Id()
	local nowTime = ServerTime.now()
	local openTime = Act205Config.instance:getGameStageOpenTimeStamp(actId, gameStageId)
	local endTime = Act205Config.instance:getGameStageEndTimeStamp(actId, gameStageId)

	return openTime <= nowTime and nowTime < endTime
end

function Act205Model:getCurOpenGameStageId()
	for index, stageId in pairs(Act205Enum.GameStageId) do
		if self:isGameStageOpen(stageId) then
			return stageId
		end
	end
end

function Act205Model:setAct205Info(info)
	self.gameInfoMap = {}

	local actInfo = self.gameInfoMap[info.activityId]

	if not actInfo then
		actInfo = {}
		self.gameInfoMap[info.activityId] = actInfo
	end

	local gameInfoMo = actInfo[info.gameType]

	if not gameInfoMo then
		gameInfoMo = Act205GameInfoMo.New()

		gameInfoMo:init(info.activityId, info.gameType)

		actInfo[info.gameType] = gameInfoMo
	end

	gameInfoMo:updateInfo(info)
end

function Act205Model:setAct205GameInfo(info)
	if self.gameInfoMap[info.activityId] then
		if not self.gameInfoMap[info.activityId] then
			return
		end

		self.gameInfoMap[info.activityId]:setGameInfo(info.gameInfo)
	end
end

function Act205Model:updateGameInfo(info)
	if self.gameInfoMap[info.activityId] then
		if not self.gameInfoMap[info.activityId] then
			return
		end

		self.gameInfoMap[info.activityId]:updateInfo(info)
	end
end

function Act205Model:getGameInfoMo(activityId, gameType)
	return self.gameInfoMap[activityId] and self.gameInfoMap[activityId][gameType]
end

Act205Model.instance = Act205Model.New()

return Act205Model
