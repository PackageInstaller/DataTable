-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingmengmengclg/model/OriginKingMengMengClgModel.lua

module("logic.extensions.originkingmengmengclg.model.OriginKingMengMengClgModel", package.seeall)

local OriginKingMengMengClgModel = class("OriginKingMengMengClgModel", BaseModel)

function OriginKingMengMengClgModel:onInit()
	self:onReset()
end

function OriginKingMengMengClgModel:onReset()
	self._moPool = self._moPool or {}

	for key, mo in pairs(self._moPool) do
		mo:dispose()

		self._moPool[key] = nil
	end

	self._normalFmtMos = {}
	self._normalBossFmtMos = {}
	self._extremeFmtMos = {}
	self._bossFmtMos = {}
end

function OriginKingMengMengClgModel:getSubMo(activityId)
	if self._moPool[activityId] == nil then
		self._moPool[activityId] = OriginKingMengMengClgSubMo.New(activityId)
	end

	return self._moPool[activityId]
end

function OriginKingMengMengClgModel:getNormalFmtMo(activityId)
	if self._normalFmtMos[activityId] == nil then
		self._normalFmtMos[activityId] = OriginKingMengMengClgNormalFmtMo.New()
	end

	return self._normalFmtMos[activityId]
end

function OriginKingMengMengClgModel:getNormalBossFmtMo(activityId)
	if self._normalBossFmtMos[activityId] == nil then
		self._normalBossFmtMos[activityId] = OriginKingMengMengClgNormalBossFmtMo.New()
	end

	return self._normalBossFmtMos[activityId]
end

function OriginKingMengMengClgModel:getExtremeFmtMo(activityId)
	if self._extremeFmtMos[activityId] == nil then
		self._extremeFmtMos[activityId] = OriginKingMengMengClgExtremeFmtMo.New()
	end

	return self._extremeFmtMos[activityId]
end

function OriginKingMengMengClgModel:getBossFmtMo(activityId)
	if self._bossFmtMos[activityId] == nil then
		self._bossFmtMos[activityId] = OriginKingMengMengClgBossFmtMo.New()
	end

	return self._bossFmtMos[activityId]
end

OriginKingMengMengClgModel.instance = OriginKingMengMengClgModel.New()

return OriginKingMengMengClgModel
