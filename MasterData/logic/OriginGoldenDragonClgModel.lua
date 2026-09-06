-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origingoldendragonclg/model/OriginGoldenDragonClgModel.lua

module("logic.extensions.origingoldendragonclg.model.OriginGoldenDragonClgModel", package.seeall)

local OriginGoldenDragonClgModel = class("OriginGoldenDragonClgModel", BaseModel)

function OriginGoldenDragonClgModel:onInit()
	self:onReset()
end

function OriginGoldenDragonClgModel:onReset()
	self._infoMap = {}
end

function OriginGoldenDragonClgModel:onGetInfo(msg)
	local data = GameUtil.pbToTable(msg)
	local activityId = data.activityId
	local stageInfoMap = {}

	if data.stageInfos then
		for _, stageInfo in ipairs(data.stageInfos) do
			stageInfoMap[stageInfo.stageId] = stageInfo
		end
	end

	local gainPrizeIdMap = {}

	if data.gainPrizeIds then
		for _, prizeId in ipairs(data.gainPrizeIds) do
			gainPrizeIdMap[prizeId] = true
		end
	end

	data.stageInfoMap = stageInfoMap
	data.gainPrizeIdMap = gainPrizeIdMap
	self._infoMap[activityId] = data
end

function OriginGoldenDragonClgModel:onGainPrize(msg)
	local data = GameUtil.pbToTable(msg)
	local info = self._infoMap[data.activityId]

	if info then
		if not info.gainPrizeIdMap then
			info.gainPrizeIdMap[data.prizeId] = true
			info.gainPrizeIdMap = info.gainPrizeIdMap
		end
	end
end

function OriginGoldenDragonClgModel:onResetChallenge(msg)
	local data = GameUtil.pbToTable(msg)
	local info = self._infoMap[data.activityId]

	if info then
		info.stageInfos = {}
		info.stageInfoMap = {}
	end
end

function OriginGoldenDragonClgModel:onNotifyStageResult(msg)
	local data = GameUtil.pbToTable(msg)
	local info = self._infoMap[data.activityId]

	if info then
		info.lastStageResult = data
	end
end

function OriginGoldenDragonClgModel:onConfirmResult(msg)
	local data = GameUtil.pbToTable(msg)
	local info = self._infoMap[data.activityId]

	if info and data.save and data.stageInfo then
		if not info.stageInfoMap then
			info.stageInfoMap[data.stageInfo.stageId] = data.stageInfo
			info.stageInfoMap = info.stageInfoMap
		end
	end
end

function OriginGoldenDragonClgModel:getInfo(activityId)
	return self._infoMap[activityId]
end

function OriginGoldenDragonClgModel:getStageInfo(activityId, stageId)
	local info = self._infoMap[activityId]

	if info and info.stageInfoMap then
		return info.stageInfoMap[stageId]
	end
end

function OriginGoldenDragonClgModel:hasGainPrize(activityId, prizeId)
	local info = self._infoMap[activityId]

	if info and info.gainPrizeIdMap then
		return info.gainPrizeIdMap[prizeId] == true
	end

	return false
end

function OriginGoldenDragonClgModel:getTotalScore(activityId)
	local info = self._infoMap[activityId]

	if info and info.stageInfoMap then
		local totalScore = 0

		for _, stageInfo in pairs(info.stageInfoMap) do
			totalScore = totalScore + (stageInfo.score or 0)
		end

		return totalScore
	end

	return 0
end

function OriginGoldenDragonClgModel:hasProphecy(activityId, prophecyId)
	local info = self._infoMap[activityId]

	if info and info.stageInfoMap then
		for _, stageInfo in pairs(info.stageInfoMap) do
			if stageInfo.prophecyId == prophecyId then
				return true
			end
		end
	end

	return false
end

function OriginGoldenDragonClgModel:getLastStageClgResult(activityId)
	local info = self._infoMap[activityId]

	if info then
		return info.lastStageResult
	end
end

OriginGoldenDragonClgModel.instance = OriginGoldenDragonClgModel.New()

return OriginGoldenDragonClgModel
