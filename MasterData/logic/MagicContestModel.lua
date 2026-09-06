-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magiccontest/model/MagicContestModel.lua

module("logic.extensions.magiccontest.model.MagicContestModel", package.seeall)

local MagicContestModel = class("MagicContestModel", BaseModel)

function MagicContestModel:onInit()
	self:onReset()
end

function MagicContestModel:onReset()
	self._moPool = self._moPool or {}

	for key, mo in pairs(self._moPool) do
		mo:dispose()

		self._moPool[key] = nil
	end

	self._pkFmtMo = nil
	self._formationFmtMo = nil
end

function MagicContestModel:getSubMo(activityId)
	if self._moPool[activityId] == nil then
		self._moPool[activityId] = MagicContestSubMo.New(activityId)
	end

	return self._moPool[activityId]
end

function MagicContestModel:getPkFmtMo()
	self._pkFmtMo = self._pkFmtMo or MagicContestFmtMo.New()

	return self._pkFmtMo
end

function MagicContestModel:getFormationCustomFmtMo()
	if self._formationFmtMo == nil then
		self._formationFmtMo = MagicContestFormationFmtMo.New()
	end

	return self._formationFmtMo
end

MagicContestModel.instance = MagicContestModel.New()

return MagicContestModel
