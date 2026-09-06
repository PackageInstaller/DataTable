-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holydragontemple/model/HolyDragonTempleModel.lua

module("logic.extensions.holydragontemple.model.HolyDragonTempleModel", package.seeall)

local HolyDragonTempleModel = class("HolyDragonTempleModel", BaseModel)

function HolyDragonTempleModel:onInit()
	self:onReset()
end

function HolyDragonTempleModel:onReset()
	self._moPool = self._moPool or {}
	self._goldFmtMoPool = self._goldFmtMoPool or {}
	self._lightFmtMoPool = self._lightFmtMoPool or {}

	for activityId, mo in pairs(self._moPool) do
		mo:dispose()

		self._moPool[activityId] = nil
	end

	for activityId, _ in pairs(self._goldFmtMoPool) do
		self._goldFmtMoPool[activityId] = nil
	end

	for activityId, _ in pairs(self._lightFmtMoPool) do
		self._lightFmtMoPool[activityId] = nil
	end
end

function HolyDragonTempleModel:getSubMo(activityId)
	if self._moPool[activityId] == nil then
		self._moPool[activityId] = HolyDragonTempleSubMo.New(activityId)
	end

	return self._moPool[activityId]
end

function HolyDragonTempleModel:getGoldFmtMo(activityId)
	activityId = checknumber(activityId)

	if self._goldFmtMoPool[activityId] == nil then
		self._goldFmtMoPool[activityId] = HolyDragonTempleGoldFmtMo.New()
	end

	return self._goldFmtMoPool[activityId]
end

function HolyDragonTempleModel:getLightFmtMo(activityId)
	activityId = checknumber(activityId)

	if self._lightFmtMoPool[activityId] == nil then
		self._lightFmtMoPool[activityId] = HolyDragonTempleLightFmtMo.New()
	end

	return self._lightFmtMoPool[activityId]
end

HolyDragonTempleModel.instance = HolyDragonTempleModel.New()

return HolyDragonTempleModel
