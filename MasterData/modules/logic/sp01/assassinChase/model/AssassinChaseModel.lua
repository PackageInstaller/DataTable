-- chunkname: @modules/logic/sp01/assassinChase/model/AssassinChaseModel.lua

module("modules.logic.sp01.assassinChase.model.AssassinChaseModel", package.seeall)

local AssassinChaseModel = class("AssassinChaseModel", BaseModel)

function AssassinChaseModel:onInit()
	self:reInit()
end

function AssassinChaseModel:reInit()
	self._curActivityId = nil
	self._curDirectionId = nil
	self._chaseInfoDic = {}
end

function AssassinChaseModel:setCurActivityId(activityId)
	self._curActivityId = activityId
end

function AssassinChaseModel:getCurActivityId()
	return self._curActivityId
end

function AssassinChaseModel:setCurDirectionId(directionId)
	self._curDirectionId = self._curDirectionId ~= directionId and directionId or nil

	AssassinChaseController.instance:dispatchEvent(AssassinChaseEvent.OnSelectDirection, self._curDirectionId)
end

function AssassinChaseModel:getCurDirectionId()
	return self._curDirectionId
end

function AssassinChaseModel:setActInfo(reply)
	local activityId = reply.activityId
	local mo

	if not self._chaseInfoDic[activityId] then
		mo = AssassinChaseInfoMo.New()
		self._chaseInfoDic[activityId] = mo
	else
		mo = self._chaseInfoDic[activityId]
	end

	mo:init(activityId, reply.hasChosenDirection, reply.chosenInfo, reply.optionDirections)
	self:setCurDirectionId(nil)
	AssassinChaseController.instance:dispatchEvent(AssassinChaseEvent.OnInfoUpdate, activityId)
end

function AssassinChaseModel:onActInfoPush(reply)
	local activityId = reply.activityId
	local mo

	if not self._chaseInfoDic[activityId] then
		mo = AssassinChaseInfoMo.New()
		self._chaseInfoDic[activityId] = mo
	else
		mo = self._chaseInfoDic[activityId]
	end

	mo:init(activityId, reply.hasChosenDirection, reply.chosenInfo, reply.optionDirections)
	self:setCurDirectionId(nil)
	AssassinChaseController.instance:dispatchEvent(AssassinChaseEvent.OnInfoUpdate, activityId)
end

function AssassinChaseModel:onSelectDirection(activityId, chosenInfo)
	local infoMo = self:getActInfo(activityId)

	if infoMo == nil then
		logError("奥德赛 下半活动 追逐游戏活动 信息不存在")

		return
	end

	infoMo.hasChosenDirection = true
	infoMo.chosenInfo = chosenInfo

	infoMo:refreshTime()
	self:setCurDirectionId(nil)
	AssassinChaseController.instance:dispatchEvent(AssassinChaseEvent.OnInfoUpdate, activityId)
end

function AssassinChaseModel:getActInfo(activityId)
	return self._chaseInfoDic[activityId]
end

function AssassinChaseModel:getCurInfoMo()
	return self:getActInfo(self._curActivityId)
end

function AssassinChaseModel:isCurActOpen(showToast)
	return self:isActOpen(self._curActivityId, showToast)
end

function AssassinChaseModel:isActOpen(activityId, showToast, realEnd)
	local actInfoMo = ActivityModel.instance:getActMO(activityId)

	if actInfoMo == nil then
		return false
	end

	local realEndTime = actInfoMo:getRealEndTimeStamp()
	local endTime = realEnd and realEndTime or AssassinChaseHelper.getActivityEndTimeStamp(realEndTime)
	local nowTime = ServerTime.now()

	if not actInfoMo:isOpen() or endTime <= nowTime then
		if showToast then
			GameFacade.showToast(ToastEnum.ActivityNotInOpenTime)
		end

		return false
	end

	return true
end

function AssassinChaseModel:isActHaveReward(activityId)
	local actInfoMo = ActivityModel.instance:getActMO(activityId)

	if actInfoMo == nil then
		return false
	end

	if not actInfoMo:isOpen() or actInfoMo:getRealEndTimeStamp() - ServerTime.now() <= 0 then
		return false
	end

	local infoMo = self:getActInfo(activityId)

	if infoMo == nil or infoMo.hasChosenDirection == false or infoMo.chosenInfo == nil then
		return false
	end

	return infoMo.chosenInfo.rewardId ~= nil and infoMo.chosenInfo.rewardId ~= 0
end

AssassinChaseModel.instance = AssassinChaseModel.New()

return AssassinChaseModel
