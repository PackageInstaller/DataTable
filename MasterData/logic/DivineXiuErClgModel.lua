-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexiuerclg/model/DivineXiuErClgModel.lua

module("logic.extensions.divinexiuerclg.model.DivineXiuErClgModel", package.seeall)

local DivineXiuErClgModel = class("DivineXiuErClgModel", BaseModel)

function DivineXiuErClgModel:ctor()
	return
end

function DivineXiuErClgModel:onInit()
	self:onReset()
end

function DivineXiuErClgModel:onReset()
	self._dxecMoPool = self._dxecMoPool or {}

	table.clear(self._dxecMoPool)

	self._customFmtMoOfNorPool = self._customFmtMoOfNorPool or {}

	table.clear(self._customFmtMoOfNorPool)

	self._customFmtMoOfExtNpStagePool = self._customFmtMoOfExtNpStagePool or {}

	table.clear(self._customFmtMoOfExtNpStagePool)

	self._customFmtMoOfExtTfStagePool = self._customFmtMoOfExtTfStagePool or {}

	table.clear(self._customFmtMoOfExtTfStagePool)
end

function DivineXiuErClgModel:getDxecMo(activityId)
	if self._dxecMoPool[activityId] == nil then
		self._dxecMoPool[activityId] = DivineXiuErClgMo.New(activityId)
	end

	return self._dxecMoPool[activityId]
end

function DivineXiuErClgModel:getDxecCustomFmtMoOfNor(activityId)
	if self._customFmtMoOfNorPool[activityId] == nil then
		self._customFmtMoOfNorPool[activityId] = DivineXiuErClgCustomFmtMoOfNor.New()
	end

	return self._customFmtMoOfNorPool[activityId]
end

function DivineXiuErClgModel:getDxecCustomFmtMoOfExtNpStage(activityId)
	if self._customFmtMoOfExtNpStagePool[activityId] == nil then
		self._customFmtMoOfExtNpStagePool[activityId] = DivineXiuErClgCustomFmtMoOfExtNpStage.New()
	end

	return self._customFmtMoOfExtNpStagePool[activityId]
end

function DivineXiuErClgModel:getDxecCustomFmtMoOfExtTfStage(activityId)
	if self._customFmtMoOfExtTfStagePool[activityId] == nil then
		self._customFmtMoOfExtTfStagePool[activityId] = DivineXiuErClgCustomFmtMoOfExtTfStage.New()
	end

	return self._customFmtMoOfExtTfStagePool[activityId]
end

DivineXiuErClgModel.instance = DivineXiuErClgModel.New()

return DivineXiuErClgModel
