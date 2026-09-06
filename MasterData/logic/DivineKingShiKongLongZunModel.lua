-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingshikongllongzun/model/DivineKingShiKongLongZunModel.lua

module("logic.extensions.divinekingshikongllongzun.model.DivineKingShiKongLongZunModel", package.seeall)

local DivineKingShiKongLongZunModel = class("DivineKingShiKongLongZunModel", BaseModel)

DivineKingShiKongLongZunModel.FLOOR_TOTAL_CHALLENGE_NUM = 2

function DivineKingShiKongLongZunModel:onInit()
	self:onReset()
end

function DivineKingShiKongLongZunModel:onReset()
	self._infos = {}
	self._customFmtMoPool = {}
	self._customSecondFmtMoPool = {}
end

function DivineKingShiKongLongZunModel:getInfo(activityId)
	return self._infos[activityId]
end

function DivineKingShiKongLongZunModel:getFmtMo(activityId)
	if self._customFmtMoPool[activityId] == nil then
		self._customFmtMoPool[activityId] = DivineKingShiKongLongZunFmtMo.New()
	end

	return self._customFmtMoPool[activityId]
end

function DivineKingShiKongLongZunModel:getSecondFmtMo(activityId)
	if self._customSecondFmtMoPool[activityId] == nil then
		self._customSecondFmtMoPool[activityId] = DivineKingShiKongLongZunSecondFmtMo.New()
	end

	return self._customSecondFmtMoPool[activityId]
end

function DivineKingShiKongLongZunModel:handlePM_DivineKingSpaceDragonInfoRes(msg)
	self._infos[msg.activityId] = GameUtil.pbToTable(msg)
end

function DivineKingShiKongLongZunModel:handlePM_DivineKingSpaceDragonNotifyChallengeRes(msg)
	local info = self._infos[msg.activityId]
	local floorInfo = info.floorInfos[msg.floorId]

	floorInfo.maxPassStageId = msg.stageId
end

function DivineKingShiKongLongZunModel:handlePM_DivineKingSpaceDragonResetFloorRes(msg)
	local info = self._infos[msg.activityId]
	local floorInfo = info.floorInfos[msg.floorId]

	floorInfo.maxPassStageId = 0
	floorInfo.positionAndHpRatio = nil
end

function DivineKingShiKongLongZunModel:hasFirstPass(activityId)
	local info = self:getInfo(activityId)

	if info then
		for _, floorInfo in ipairs(info.floorInfos) do
			if not floorInfo.isPassFloor then
				return false
			end
		end

		return true
	end

	return false
end

function DivineKingShiKongLongZunModel:floorIsPass(activityId, floorId)
	local info = self:getInfo(activityId)

	if info and info.floorInfos then
		local floorInfo = info.floorInfos[floorId]

		return floorInfo.maxPassStageId >= DivineKingShiKongLongZunModel.FLOOR_TOTAL_CHALLENGE_NUM
	end

	return false
end

function DivineKingShiKongLongZunModel:getCurPassFloor(activityId)
	local info = self:getInfo(activityId)
	local passFloor = 0

	for i, floorInfo in pairs(info.floorInfos) do
		if floorInfo.maxPassStageId >= DivineKingShiKongLongZunModel.FLOOR_TOTAL_CHALLENGE_NUM then
			passFloor = floorInfo.floorId
		end
	end

	return passFloor
end

DivineKingShiKongLongZunModel.instance = DivineKingShiKongLongZunModel.New()

return DivineKingShiKongLongZunModel
