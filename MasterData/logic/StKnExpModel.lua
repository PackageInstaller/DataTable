-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stknexp/model/StKnExpModel.lua

module("logic.extensions.stknexp.model.StKnExpModel", package.seeall)

local StKnExpModel = class("StKnExpModel", BaseModel)

function StKnExpModel:onInit()
	self:onReset()
end

function StKnExpModel:onReset()
	self._subMoPool = self._subMoPool or {}

	for key, subMo in pairs(self._subMoPool) do
		subMo:dispose()

		self._subMoPool[key] = nil
	end

	self._stageFmtMo = nil
	self._bossFmtMo = nil
end

function StKnExpModel:getSubMo(activityId)
	if self._subMoPool[activityId] == nil then
		self._subMoPool[activityId] = StKnExpSubMo.New(activityId)
	end

	return self._subMoPool[activityId]
end

function StKnExpModel:getStageFmtMo()
	if self._stageFmtMo == nil then
		self._stageFmtMo = StKnExpStageFmtMo.New()
	end

	return self._stageFmtMo
end

function StKnExpModel:getBossFmtMo()
	if self._bossFmtMo == nil then
		self._bossFmtMo = StKnExpBossFmtMo.New()
	end

	return self._bossFmtMo
end

StKnExpModel.instance = StKnExpModel.New()

return StKnExpModel
