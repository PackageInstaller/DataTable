-- chunkname: @modules/logic/act236/model/Act236Model.lua

module("modules.logic.act236.model.Act236Model", package.seeall)

local Act236Model = class("Act236Model", BaseModel)

function Act236Model:onInit()
	self:reInit()
end

function Act236Model:reInit()
	self._infoMoDic = {}
end

function Act236Model:getInfoMo(actId)
	if not self._infoMoDic then
		return nil
	end

	return self._infoMoDic[actId]
end

function Act236Model:setCurActId(actId)
	self._curActId = actId
end

function Act236Model:getCurActId()
	return self._curActId
end

function Act236Model:updateInfo(infoNo)
	local mo
	local actId = infoNo.activityId

	if not self._infoMoDic[actId] then
		mo = Act236InfoMo.New()
		self._infoMoDic[actId] = mo
	else
		mo = self._infoMoDic[actId]
	end

	mo:updateInfo(infoNo)
	Act236Controller.instance:dispatchEvent(Act236Event.OnInfoUpdate, actId)
end

function Act236Model:onAutoGainReward(actId, gainRewardList)
	local mo

	if not self._infoMoDic[actId] then
		mo = Act236InfoMo.New()
		self._infoMoDic[actId] = mo
	else
		mo = self._infoMoDic[actId]
	end

	mo:updateReward(gainRewardList)
	Act236Controller.instance:dispatchEvent(Act236Event.OnGainReward, actId)
end

Act236Model.instance = Act236Model.New()

return Act236Model
