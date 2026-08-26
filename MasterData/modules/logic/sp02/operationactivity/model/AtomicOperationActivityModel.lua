-- chunkname: @modules/logic/sp02/operationactivity/model/AtomicOperationActivityModel.lua

module("modules.logic.sp02.operationactivity.model.AtomicOperationActivityModel", package.seeall)

local AtomicOperationActivityModel = class("AtomicOperationActivityModel", BaseModel)

function AtomicOperationActivityModel:onInit()
	self:reInit()
end

function AtomicOperationActivityModel:reInit()
	self._curActId = nil
	self._curGameId = nil
	self._curTaskId = nil
	self._infoMoDic = {}
end

function AtomicOperationActivityModel:setCurActId(actId)
	self._curActId = actId
end

function AtomicOperationActivityModel:getCurActId()
	return self._curActId
end

function AtomicOperationActivityModel:setCurGameId(actId)
	self._curGameId = actId
end

function AtomicOperationActivityModel:getCurGameId()
	return self._curGameId
end

function AtomicOperationActivityModel:setCurTaskId(actId)
	self._curTaskId = actId
end

function AtomicOperationActivityModel:getCurTaskId()
	return self._curTaskId
end

function AtomicOperationActivityModel:getCurInfoMo()
	return self._infoMoDic[self._curGameId]
end

function AtomicOperationActivityModel:isActivityOpen(actId)
	local actInfoMo = ActivityModel.instance:getActMO(actId)

	if not actInfoMo or not actInfoMo:isOnline() then
		return false
	end

	return true
end

function AtomicOperationActivityModel:updateSingleInfo(actId, infoNo)
	local infoMo

	if not self._infoMoDic[actId] then
		infoMo = AtomicOperationActivityInfoMo.New()
		self._infoMoDic[actId] = infoMo
	else
		infoMo = self._infoMoDic[actId]
	end

	infoMo:updateInfo(infoNo)
	AtomicOperationActivityController.instance:dispatchEvent(AtomicOperationActivityEvent.OnPreparationInfoUpdate)
end

function AtomicOperationActivityModel:getInfoMo(actId)
	if not self._infoMoDic then
		return nil
	end

	return self._infoMoDic[actId]
end

AtomicOperationActivityModel.instance = AtomicOperationActivityModel.New()

return AtomicOperationActivityModel
