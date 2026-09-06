-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/freescuffle/model/FreeScuffleModel.lua

module("logic.extensions.freescuffle.model.FreeScuffleModel", package.seeall)

local FreeScuffleModel = class("FreeScuffleModel", BaseModel)

function FreeScuffleModel:onInit()
	self:onReset()
end

function FreeScuffleModel:onReset()
	self._moPool = self._moPool or {}

	for key, mo in pairs(self._moPool) do
		mo:dispose()

		self._moPool[key] = nil
	end

	self._pkFmtMo = nil
	self._formationCustomFmtMo = nil
end

function FreeScuffleModel:getSubMo(activityId)
	self._moPool[activityId] = self._moPool[activityId] or FreeScuffleSubMo.New(activityId)

	return self._moPool[activityId]
end

function FreeScuffleModel:getPkFmtMo()
	self._pkFmtMo = self._pkFmtMo or FreeScuffleFmtMo.New()

	return self._pkFmtMo
end

function FreeScuffleModel:getFormationCustomFmtMo()
	if self._formationCustomFmtMo == nil then
		self._formationCustomFmtMo = FreeScuffleFormationFmtMo.New()
	end

	return self._formationCustomFmtMo
end

FreeScuffleModel.instance = FreeScuffleModel.New()

return FreeScuffleModel
