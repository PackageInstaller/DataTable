-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalcity/model/EternalCityModel.lua

module("logic.extensions.eternalcity.model.EternalCityModel", package.seeall)

local EternalCityModel = class("EternalCityModel", BaseModel)

function EternalCityModel:onInit()
	self:onReset()
end

function EternalCityModel:onReset()
	self._moPool = self._moPool or {}

	for key, mo in pairs(self._moPool) do
		mo:dispose()

		self._moPool[key] = nil
	end

	self._stageClgFmtMo = nil
	self._bossClgFmtMo = nil
	self._isNotShowTipsWin = false
end

function EternalCityModel:getSubMo(activityId)
	if self._moPool[activityId] == nil then
		self._moPool[activityId] = EternalCitySubMo.New(activityId)
	end

	return self._moPool[activityId]
end

function EternalCityModel:getStageClgFmtMo()
	if self._stageClgFmtMo == nil then
		self._stageClgFmtMo = EternalCityStageClgFmtMo.New()
	end

	return self._stageClgFmtMo
end

function EternalCityModel:getBossClgFmtMo()
	if self._bossClgFmtMo == nil then
		self._bossClgFmtMo = EternalCityBossClgFmtMo.New()
	end

	return self._bossClgFmtMo
end

function EternalCityModel:setIsNotShowTipsWin(isNotShowTipsWin)
	self._isNotShowTipsWin = isNotShowTipsWin
end

function EternalCityModel:isNotShowTipsWin()
	return self._isNotShowTipsWin
end

EternalCityModel.instance = EternalCityModel.New()

return EternalCityModel
