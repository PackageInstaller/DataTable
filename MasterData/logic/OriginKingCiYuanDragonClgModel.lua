-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingciyuandragonclg/model/OriginKingCiYuanDragonClgModel.lua

module("logic.extensions.originkingciyuandragonclg.model.OriginKingCiYuanDragonClgModel", package.seeall)

local OriginKingCiYuanDragonClgModel = class("OriginKingCiYuanDragonClgModel", BaseModel)

function OriginKingCiYuanDragonClgModel:onInit()
	self:onReset()
end

function OriginKingCiYuanDragonClgModel:onReset()
	self._moPool = self._moPool or {}

	for key, mo in pairs(self._moPool) do
		mo:dispose()

		self._moPool[key] = nil
	end

	self._fmtMoPool = {}
end

function OriginKingCiYuanDragonClgModel:getSubMo(activityId)
	if self._moPool[activityId] == nil then
		self._moPool[activityId] = OriginKingCiYuanDragonClgSubMo.New(activityId)
	end

	return self._moPool[activityId]
end

function OriginKingCiYuanDragonClgModel:getFmtMo(activityId)
	if self._fmtMoPool[activityId] == nil then
		self._fmtMoPool[activityId] = OriginKingCiYuanDragonClgFmtMo.New()
	end

	return self._fmtMoPool[activityId]
end

OriginKingCiYuanDragonClgModel.instance = OriginKingCiYuanDragonClgModel.New()

return OriginKingCiYuanDragonClgModel
