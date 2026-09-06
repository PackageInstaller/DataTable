-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originxiuer/model/OriginXiuErModel.lua

module("logic.extensions.originxiuer.model.OriginXiuErModel", package.seeall)

local OriginXiuErModel = class("OriginXiuErModel", BaseModel)

function OriginXiuErModel:onInit()
	self:onReset()
end

function OriginXiuErModel:onReset()
	self._curAddRaceIdNum = 0
	self._infos = {}
	self._raceIdMaps = {}
	self._customFmtMoPool = {}
end

function OriginXiuErModel:getInfo(activityId)
	return self._infos[activityId]
end

function OriginXiuErModel:getFmtMo(activityId)
	if self._customFmtMoPool[activityId] == nil then
		self._customFmtMoPool[activityId] = OriginXiuErFmtMo.New()
	end

	return self._customFmtMoPool[activityId]
end

function OriginXiuErModel:getRaceIdMap(activityId)
	return self._raceIdMaps[activityId]
end

function OriginXiuErModel:handlePM_OriginXiuErInfoRes(msg)
	self._infos[msg.activityId] = GameUtil.pbToTable(msg)
	self._raceIdMaps[msg.activityId] = self._raceIdMaps[msg.activityId] or {}

	local raceIdMap = self._raceIdMaps[msg.activityId]
	local info = self._infos[msg.activityId]

	info.raceIdToMarkNum = msg.raceIdToMarkNum or {}
	info.hasGainPrize = msg.hasGainPrize or {}

	for i, v in ipairs(info.raceIdToMarkNum) do
		raceIdMap[v.left] = v.right
	end
end

function OriginXiuErModel:handlePM_OriginXiuErResetRes(msg)
	local info = self._infos[msg.activityId]

	self._raceIdMaps[msg.activityId] = {}
	info.maxPassStageId = 0
	info.raceIdToMarkNum = msg.raceIdToMarkNum or {}
end

OriginXiuErModel.instance = OriginXiuErModel.New()

return OriginXiuErModel
