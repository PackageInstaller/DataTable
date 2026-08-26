-- chunkname: @modules/logic/sp02/paomian/guessme/model/Sp02_GuessMeModel.lua

module("modules.logic.sp02.paomian.guessme.model.Sp02_GuessMeModel", package.seeall)

local Sp02_GuessMeModel = class("Sp02_GuessMeModel", BaseModel)

function Sp02_GuessMeModel:initInfo(rpcInfo)
	self._activityId = rpcInfo.activityId
	self._signInfoMap = {}

	if rpcInfo.signs then
		for _, signMsg in ipairs(rpcInfo.signs) do
			self:_updateSingleSignInfo(self._activityId, signMsg)
		end
	end

	Sp02_PaoMianController.instance:dispatchEvent(Sp02_GuessMeEvent.OnUpdateGuessMe)
end

function Sp02_GuessMeModel:onGetSingleSignInfo(activityId, signMsg)
	self:_updateSingleSignInfo(activityId, signMsg)
	Sp02_PaoMianController.instance:dispatchEvent(Sp02_GuessMeEvent.OnUpdateGuessMe)
end

function Sp02_GuessMeModel:_updateSingleSignInfo(activityId, signMsg)
	local signInfo = self:getSignInfo(activityId, signMsg.id)

	if not signInfo then
		signInfo = Sp02_GuessMeSignInfoMO.New()
		self._signInfoMap[signMsg.id] = signInfo
	end

	signInfo:init(signMsg)
end

function Sp02_GuessMeModel:getSignInfo(actId, taskId)
	if actId ~= self._activityId then
		return
	end

	return self._signInfoMap and self._signInfoMap[taskId]
end

function Sp02_GuessMeModel:getStatus(actId, taskId)
	local signInfo = self:getSignInfo(actId, taskId)

	return signInfo and signInfo:getStatus() or Sp02_GuessMeEnum.TaskStatus.Lock
end

Sp02_GuessMeModel.instance = Sp02_GuessMeModel.New()

return Sp02_GuessMeModel
