-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingorderclg/model/OriginKingOrderClgModel.lua

module("logic.extensions.originkingorderclg.model.OriginKingOrderClgModel", package.seeall)

local OriginKingOrderClgModel = class("OriginKingOrderClgModel", BaseModel)

function OriginKingOrderClgModel:onInit()
	self:onReset()
end

function OriginKingOrderClgModel:onReset()
	self._moPool = self._moPool or {}

	for key, mo in pairs(self._moPool) do
		mo:dispose()

		self._moPool[key] = nil
	end

	self._fmtMoPool = {}
end

function OriginKingOrderClgModel:getSubMo(activityId)
	if self._moPool[activityId] == nil then
		self._moPool[activityId] = OriginKingOrderClgSubMo.New(activityId)
	end

	return self._moPool[activityId]
end

function OriginKingOrderClgModel:getFmtMo(activityId)
	if self._fmtMoPool[activityId] == nil then
		self._fmtMoPool[activityId] = OriginKingOrderClgFmtMo.New()
	end

	return self._fmtMoPool[activityId]
end

OriginKingOrderClgModel.instance = OriginKingOrderClgModel.New()

return OriginKingOrderClgModel
