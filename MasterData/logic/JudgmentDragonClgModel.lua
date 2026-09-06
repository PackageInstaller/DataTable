-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/judgmentdragonclg/model/JudgmentDragonClgModel.lua

module("logic.extensions.judgmentdragonclg.model.JudgmentDragonClgModel", package.seeall)

local JudgmentDragonClgModel = class("JudgmentDragonClgModel", BaseModel)

function JudgmentDragonClgModel:onInit()
	self:onReset()
end

function JudgmentDragonClgModel:onReset()
	self._moPool = self._moPool or {}

	for key, mo in pairs(self._moPool) do
		mo:dispose()

		self._moPool[key] = nil
	end

	self._fmtMo = nil
end

function JudgmentDragonClgModel:getClgMo(activityId)
	if self._moPool[activityId] == nil then
		self._moPool[activityId] = JudgmentDragonClgMo.New(activityId)
	end

	return self._moPool[activityId]
end

function JudgmentDragonClgModel:getFmtMo()
	if self._fmtMo == nil then
		self._fmtMo = JudgmentDragonClgFmtMo.New()
	end

	return self._fmtMo
end

JudgmentDragonClgModel.instance = JudgmentDragonClgModel.New()

return JudgmentDragonClgModel
