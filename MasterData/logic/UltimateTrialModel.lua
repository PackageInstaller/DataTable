-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ultimatetrial/model/UltimateTrialModel.lua

module("logic.extensions.ultimatetrial.model.UltimateTrialModel", package.seeall)

local UltimateTrialModel = class("UltimateTrialModel", BaseModel)

function UltimateTrialModel:onInit()
	self:onReset()
end

function UltimateTrialModel:onReset()
	self._moPool = self._moPool or {}

	for key, mo in pairs(self._moPool) do
		mo:dispose()

		self._moPool[key] = nil
	end
end

function UltimateTrialModel:getTrialMo(activityId)
	if self._moPool[activityId] == nil then
		self._moPool[activityId] = UltimateTrialMo.New(activityId)
	end

	return self._moPool[activityId]
end

UltimateTrialModel.instance = UltimateTrialModel.New()

return UltimateTrialModel
