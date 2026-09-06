-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/relationpower/model/RelationPowerModel.lua

module("logic.extensions.relationpower.model.RelationPowerModel", package.seeall)

local RelationPowerModel = class("RelationPowerModel", BaseModel)

function RelationPowerModel:ctor()
	return
end

function RelationPowerModel:onInit()
	self:onReset()
end

function RelationPowerModel:onReset()
	self._finishTaskIds = {}
	self._gainedTaskIds = {}
	self._curGainTaskId = nil
	self._fmtCustomFmtMos = nil
	self._curVerifyFormZdl = 0
	self._curVerifyFormOverPercent = 0
	self._curVerifyFormPass = false
end

function RelationPowerModel:onGetInfo(msg)
	self._finishTaskIds = msg.finishTaskIds
	self._gainedTaskIds = msg.gainedTaskIds
end

function RelationPowerModel:onVerifyPower(msg)
	self._curVerifyFormZdl = msg.formZdl
	self._curVerifyFormOverPercent = msg.overPercent
	self._curVerifyFormPass = msg.isPassVerify
end

function RelationPowerModel:onGainPrize(msg)
	self._gainedTaskIds = self._gainedTaskIds or {}

	table.insert(self._gainedTaskIds, self._curGainTaskId)

	self._curGainTaskId = nil
end

function RelationPowerModel:gainTaskPrize(id)
	self._curGainTaskId = id
end

function RelationPowerModel:getTaskIsFinish(taskId)
	if self._finishTaskIds then
		return table.indexof(self._finishTaskIds, taskId)
	end

	return false
end

function RelationPowerModel:getPrizeIsGain(taskId)
	if self._gainedTaskIds then
		return table.indexof(self._gainedTaskIds, taskId)
	end

	return false
end

function RelationPowerModel:getFmtCustomFmtMo(formId)
	if self._fmtCustomFmtMos == nil then
		self._fmtCustomFmtMos = {}
	end

	if self._fmtCustomFmtMos[formId] == nil then
		self._fmtCustomFmtMos[formId] = RelationPowerFormationCustomFmtMo.New()
	end

	return self._fmtCustomFmtMos[formId]
end

function RelationPowerModel:getCurVerifyFormZdl()
	return self._curVerifyFormZdl
end

function RelationPowerModel:getCurVerifyFormOverPercent()
	return self._curVerifyFormOverPercent
end

RelationPowerModel.instance = RelationPowerModel.New()

return RelationPowerModel
