-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonking/model/DragonKingChallengeModel.lua

module("logic.extensions.dragonking.model.DragonKingChallengeModel", package.seeall)

local DragonKingChallengeModel = class("DragonKingChallengeModel", BaseModel)

function DragonKingChallengeModel:onInit()
	self:onReset()
end

function DragonKingChallengeModel:onReset()
	self._infoMap = {}
	self._stageInfoMap = {}
	self.myRank = 0
	self.rankInfos = {}
	self.selectStageId = 1
end

function DragonKingChallengeModel:getInfo(activityId)
	return self._infoMap[activityId]
end

function DragonKingChallengeModel:handlePM_DragonKingClgGetInfoRes(msg)
	local activityId = msg.activityId
	local tb = GameUtil.pbToTable(msg)

	self._infoMap[activityId] = tb

	for i, v in ipairs(tb.stageInfo or {}) do
		self._stageInfoMap[activityId] = self._stageInfoMap[activityId] or {}
		self._stageInfoMap[activityId][v.stageId] = v
	end
end

function DragonKingChallengeModel:handlePM_DragonKingClgGainProgressPrizeRes(msg)
	local activityId = msg.activityId
	local tb = self._infoMap[activityId]

	if tb then
		tb.prizeGainedBitId = tb.prizeGainedBitId or {}

		table.insert(tb.prizeGainedBitId, msg.dataBitId)
	end
end

function DragonKingChallengeModel:getStageInfo(activityId, stageId)
	if self._stageInfoMap[activityId] then
		return self._stageInfoMap[activityId][stageId]
	end
end

function DragonKingChallengeModel:handlePM_DragonKingClgGetRankRes(msg)
	self.myRank = msg.myRank
	self.rankInfos = msg.rankInfos
end

function DragonKingChallengeModel:updateStageInfo(msg)
	local activityId = msg.activityId
	local stageInfo = GameUtil.pbToTable(msg.stageInfo)
	local tb = self._infoMap[activityId]

	if tb then
		if self._stageInfoMap[activityId] == nil then
			tb.stageInfo = tb.stageInfo or {}

			table.insert(tb.stageInfo, stageInfo)
		end

		self._stageInfoMap[activityId] = stageInfo
	end
end

DragonKingChallengeModel.instance = DragonKingChallengeModel.New()

return DragonKingChallengeModel
