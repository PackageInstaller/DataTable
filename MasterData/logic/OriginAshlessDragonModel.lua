-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originashlessdragon/model/OriginAshlessDragonModel.lua

module("logic.extensions.originashlessdragon.model.OriginAshlessDragonModel", package.seeall)

local OriginAshlessDragonModel = class("OriginAshlessDragonModel", BaseModel)

function OriginAshlessDragonModel:onInit()
	self:onReset()
end

function OriginAshlessDragonModel:onReset()
	self._moPool = self._moPool or {}

	for key, mo in pairs(self._moPool) do
		mo:dispose()

		self._moPool[key] = nil
	end

	self._fmtMoPool = {}
end

function OriginAshlessDragonModel:getSubMo(activityId)
	if self._moPool[activityId] == nil then
		self._moPool[activityId] = OriginAshlessDragonSubMo.New(activityId)
	end

	return self._moPool[activityId]
end

function OriginAshlessDragonModel:getFmtMo(activityId)
	if self._fmtMoPool[activityId] == nil then
		self._fmtMoPool[activityId] = OriginAshlessDragonFmtMo.New()
	end

	return self._fmtMoPool[activityId]
end

OriginAshlessDragonModel.instance = OriginAshlessDragonModel.New()

return OriginAshlessDragonModel
