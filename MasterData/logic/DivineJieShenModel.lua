-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinejieshen/model/DivineJieShenModel.lua

module("logic.extensions.divinejieshen.model.DivineJieShenModel", package.seeall)

local DivineJieShenModel = class("DivineJieShenModel", BaseModel)

function DivineJieShenModel:ctor()
	return
end

function DivineJieShenModel:onInit()
	self:onReset()
end

function DivineJieShenModel:onReset()
	self._moPool = {}
	self._extCustomFmtMoPool = {}
	self._norStageCustomFmtMoPool = {}
	self._norBossCustomFmtMoPool = {}
end

function DivineJieShenModel:getDivineJieShenMo(activityId)
	if self._moPool[activityId] == nil then
		self._moPool[activityId] = DivineJieShenMo.New(activityId)
	end

	return self._moPool[activityId]
end

function DivineJieShenModel:getExtCustomFmtMo(activityId)
	if self._extCustomFmtMoPool[activityId] == nil then
		self._extCustomFmtMoPool[activityId] = DivineJieShenExtCustomFmtMo.New()
	end

	return self._extCustomFmtMoPool[activityId]
end

function DivineJieShenModel:getNorStageCustomFmtMo(activityId)
	if self._norStageCustomFmtMoPool[activityId] == nil then
		self._norStageCustomFmtMoPool[activityId] = DivineJieShenNorStageCustomFmtMo.New()
	end

	return self._norStageCustomFmtMoPool[activityId]
end

function DivineJieShenModel:getNorBossCustomFmtMo(activityId)
	if self._norBossCustomFmtMoPool[activityId] == nil then
		self._norBossCustomFmtMoPool[activityId] = DivineJieShenNorBossCustomFmtMo.New()
	end

	return self._norBossCustomFmtMoPool[activityId]
end

DivineJieShenModel.instance = DivineJieShenModel.New()

return DivineJieShenModel
