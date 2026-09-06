-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonpsychicclg/model/DragonPsychicClgModel.lua

module("logic.extensions.dragonpsychicclg.model.DragonPsychicClgModel", package.seeall)

local DragonPsychicClgModel = class("DragonPsychicClgModel", BaseModel)

function DragonPsychicClgModel:ctor()
	return
end

function DragonPsychicClgModel:onInit()
	self:onReset()
end

function DragonPsychicClgModel:onReset()
	self._dpcMoPool = self._dpcMoPool or {}

	table.clear(self._dpcMoPool)

	self._customFmtMoPool = self._customFmtMoPool or {}

	table.clear(self._customFmtMoPool)

	self._extCustomFmtMoPool = self._extCustomFmtMoPool or {}

	table.clear(self._extCustomFmtMoPool)
end

function DragonPsychicClgModel:getDpcMo(activityId)
	if self._dpcMoPool[activityId] == nil then
		self._dpcMoPool[activityId] = DragonPsychicClgMo.New(activityId)
	end

	return self._dpcMoPool[activityId]
end

function DragonPsychicClgModel:getDpcCustomFmtMo(activityId)
	if self._customFmtMoPool[activityId] == nil then
		self._customFmtMoPool[activityId] = DragonPsychicClgCustomFmtMo.New()
	end

	return self._customFmtMoPool[activityId]
end

function DragonPsychicClgModel:getDpcExtCustomFmtMo(activityId)
	if self._extCustomFmtMoPool[activityId] == nil then
		self._extCustomFmtMoPool[activityId] = DragonPsychicClgExtCustomFmtMo.New()
	end

	return self._extCustomFmtMoPool[activityId]
end

DragonPsychicClgModel.instance = DragonPsychicClgModel.New()

return DragonPsychicClgModel
