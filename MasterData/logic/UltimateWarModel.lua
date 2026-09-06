-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ultimatewar/model/UltimateWarModel.lua

module("logic.extensions.ultimatewar.model.UltimateWarModel", package.seeall)

local UltimateWarModel = class("UltimateWarModel", BaseModel)

function UltimateWarModel:ctor()
	return
end

function UltimateWarModel:onInit()
	self:onReset()
end

function UltimateWarModel:onReset()
	self._moPool = self._moPool or {}

	for key, mo in pairs(self._moPool) do
		mo:dispose()

		self._moPool[key] = nil
	end

	self._customFmtMoInTowerStage = nil
	self._customFmtMoInTowerBoss = nil
	self._customFmtMoInFinalBoss = nil
	self._clickCount = 0
end

function UltimateWarModel:getUltimateWarMo(activityId)
	if self._moPool[activityId] == nil then
		self._moPool[activityId] = UltimateWarMo.New(activityId)
	end

	return self._moPool[activityId]
end

function UltimateWarModel:getTowerStageFmtMo()
	if self._customFmtMoInTowerStage == nil then
		self._customFmtMoInTowerStage = UltimateWarTowerStageFmtMo.New()
	end

	return self._customFmtMoInTowerStage
end

function UltimateWarModel:getTowerBossFmtMo()
	if self._customFmtMoInTowerBoss == nil then
		self._customFmtMoInTowerBoss = UltimateWarTowerBossFmtMo.New()
	end

	return self._customFmtMoInTowerBoss
end

function UltimateWarModel:getFinalBossFmtMo()
	if self._customFmtMoInFinalBoss == nil then
		self._customFmtMoInFinalBoss = UltimateWarFinalBossFmtMo.New()
	end

	return self._customFmtMoInFinalBoss
end

function UltimateWarModel:setClickCount(value)
	self._clickCount = value
end

function UltimateWarModel:getClickCount()
	return self._clickCount
end

UltimateWarModel.instance = UltimateWarModel.New()

return UltimateWarModel
