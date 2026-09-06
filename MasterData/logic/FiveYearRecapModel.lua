-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fiveyearrecap/model/FiveYearRecapModel.lua

module("logic.extensions.fiveyearrecap.model.FiveYearRecapModel", package.seeall)

local FiveYearRecapModel = class("FiveYearRecapModel", BaseModel)

function FiveYearRecapModel:onInit()
	self:onReset()
end

function FiveYearRecapModel:onReset()
	self._moPool = self._moPool or {}

	for key, mo in pairs(self._moPool) do
		mo:dispose()

		self._moPool[key] = nil
	end
end

function FiveYearRecapModel:getSubMo(activityId)
	if self._moPool[activityId] == nil then
		self._moPool[activityId] = FiveYearRecapSubMo.New(activityId)
	end

	return self._moPool[activityId]
end

FiveYearRecapModel.instance = FiveYearRecapModel.New()

return FiveYearRecapModel
