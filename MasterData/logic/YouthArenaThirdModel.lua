-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/model/YouthArenaThirdModel.lua

module("logic.extensions.youtharenathird.model.YouthArenaThirdModel", package.seeall)

local YouthArenaThirdModel = class("YouthArenaThirdModel", BaseModel)

function YouthArenaThirdModel:onInit()
	self:onReset()
end

function YouthArenaThirdModel:onReset()
	self._moPool = self._moPool or {}
	self._matchAttackFmtMoMap = self._matchAttackFmtMoMap or {}
	self._defenseFmtMoMap = self._defenseFmtMoMap or {}
	self._defenseReadyStateMap = {}

	for activityId, mo in pairs(self._moPool) do
		mo:dispose()

		self._moPool[activityId] = nil
	end

	for activityId, _ in pairs(self._matchAttackFmtMoMap) do
		self._matchAttackFmtMoMap[activityId] = nil
	end

	for activityId, _ in pairs(self._defenseFmtMoMap) do
		self._defenseFmtMoMap[activityId] = nil
	end
end

function YouthArenaThirdModel:getSubMo(activityId)
	if self._moPool[activityId] == nil then
		self._moPool[activityId] = YouthArenaThirdSubMo.New(activityId)
	end

	return self._moPool[activityId]
end

function YouthArenaThirdModel:getMatchAttackFmtMo(activityId)
	if self._matchAttackFmtMoMap[activityId] == nil then
		self._matchAttackFmtMoMap[activityId] = YouthArenaThirdMatchAttackFmtMo.New()
	end

	return self._matchAttackFmtMoMap[activityId]
end

function YouthArenaThirdModel:getDefenseFmtMo(activityId)
	if self._defenseFmtMoMap[activityId] == nil then
		self._defenseFmtMoMap[activityId] = YouthArenaThirdDefenseFmtMo.New()
	end

	return self._defenseFmtMoMap[activityId]
end

function YouthArenaThirdModel:getDefenseReadyState(activityId, isFun, mode)
	activityId = checknumber(activityId)
	mode = checknumber(mode)

	local activityMap = self._defenseReadyStateMap[activityId]
	local funMap = activityMap and activityMap[checkbool(isFun) and 1 or 0]

	return funMap and funMap[mode]
end

function YouthArenaThirdModel:setDefenseReadyState(activityId, isFun, mode, isReady)
	activityId = checknumber(activityId)
	mode = checknumber(mode)

	if activityId <= 0 or mode <= 0 or type(isReady) ~= "boolean" then
		return
	end

	local funKey = checkbool(isFun) and 1 or 0

	self._defenseReadyStateMap[activityId] = self._defenseReadyStateMap[activityId] or {}
	self._defenseReadyStateMap[activityId][funKey] = self._defenseReadyStateMap[activityId][funKey] or {}
	self._defenseReadyStateMap[activityId][funKey][mode] = isReady
end

function YouthArenaThirdModel:clearDefenseReadyState(activityId)
	self._defenseReadyStateMap[checknumber(activityId)] = nil
end

function YouthArenaThirdModel:clearAllDefenseReadyStates()
	self._defenseReadyStateMap = {}
end

YouthArenaThirdModel.instance = YouthArenaThirdModel.New()

return YouthArenaThirdModel
