-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originan/model/OriginAnModel.lua

module("logic.extensions.originan.model.OriginAnModel", package.seeall)

local OriginAnModel = class("OriginAnModel", BaseModel)

function OriginAnModel:onInit()
	self:onReset()
end

function OriginAnModel:onReset()
	self._moPool = self._moPool or {}

	for key, mo in pairs(self._moPool) do
		mo:dispose()

		self._moPool[key] = nil
	end

	self._normalFmtMos = {}
	self._extremeFmtMos = {}
end

function OriginAnModel:getSubMo(activityId)
	if self._moPool[activityId] == nil then
		self._moPool[activityId] = OriginAnSubMo.New(activityId)
	end

	return self._moPool[activityId]
end

function OriginAnModel:getNormalFmtMo(activityId)
	if self._normalFmtMos[activityId] == nil then
		self._normalFmtMos[activityId] = OriginAnNormalFmtMo.New()
	end

	return self._normalFmtMos[activityId]
end

function OriginAnModel:getExtremeFmtMo(activityId)
	if self._extremeFmtMos[activityId] == nil then
		self._extremeFmtMos[activityId] = OriginAnExtremeFmtMo.New()
	end

	return self._extremeFmtMos[activityId]
end

OriginAnModel.instance = OriginAnModel.New()

return OriginAnModel
