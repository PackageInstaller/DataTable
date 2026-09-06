-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magicschoolpvp/model/MagicSchoolPvPModel.lua

module("logic.extensions.magicschoolpvp.model.MagicSchoolPvPModel", package.seeall)

local MagicSchoolPvPModel = class("MagicSchoolPvPModel", BaseModel)

function MagicSchoolPvPModel:onInit()
	self:onReset()
end

function MagicSchoolPvPModel:onReset()
	self._moPool = self._moPool or {}

	for key, mo in pairs(self._moPool) do
		mo:dispose()

		self._moPool[key] = nil
	end

	self._formationCustomFmtMo = nil
end

function MagicSchoolPvPModel:getSubMo(activityId)
	if self._moPool[activityId] == nil then
		self._moPool[activityId] = MagicSchoolPvPSubMo.New(activityId)
	end

	return self._moPool[activityId]
end

function MagicSchoolPvPModel:getFormationCustomFmtMo()
	if self._formationCustomFmtMo == nil then
		self._formationCustomFmtMo = MagicSchoolPvPFormationFmtMo.New()
	end

	return self._formationCustomFmtMo
end

MagicSchoolPvPModel.instance = MagicSchoolPvPModel.New()

return MagicSchoolPvPModel
