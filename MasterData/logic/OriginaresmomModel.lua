-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originaresmom/model/OriginaresmomModel.lua

module("logic.extensions.originaresmom.view.OriginaresmomModel", package.seeall)

local OriginaresmomModel = class("OriginaresmomModel", BaseModel)

function OriginaresmomModel:ctor()
	return
end

function OriginaresmomModel:onInit()
	self:onReset()
end

function OriginaresmomModel:onReset()
	self._msgInfos = {}
	self._fmtNorMo = OriginaresmomNorFmtMo.New()
	self._fmtExtMo = OriginaresmomExtFmtMo.New()
end

function OriginaresmomModel:setInfo(msg)
	self._msgInfos[msg.activityId] = GameUtil.pbToTable(msg)
	self._msgInfos[msg.activityId].extremeStages = self._msgInfos[msg.activityId].extremeStages or {}
	self._msgInfos[msg.activityId].normalGainedPrizeIds = self._msgInfos[msg.activityId].normalGainedPrizeIds or {}
	self._msgInfos[msg.activityId].normalDailyMaxScores = self._msgInfos[msg.activityId].normalDailyMaxScores or {}
end

function OriginaresmomModel:getInfo(activityId)
	return self._msgInfos[activityId]
end

function OriginaresmomModel:getNorFmtMo()
	return self._fmtNorMo
end

function OriginaresmomModel:getExtFmtMo()
	return self._fmtExtMo
end

function OriginaresmomModel:getNormalDailyMaxScore(activityId, teamIdx)
	local info = self:getInfo(activityId)

	return info.normalDailyMaxScores[teamIdx] or 0
end

function OriginaresmomModel:onNormalChallengeRes(msg)
	if msg.win then
		local activityId = msg.activityId
		local info = self:getInfo(activityId)

		info.normalDailyMaxScores[msg.teamId] = info.normalDailyMaxScores[msg.teamId] or 0

		if msg.dailyMax > info.normalDailyMaxScores[msg.teamId] then
			info.normalDailyMaxScores[msg.teamId] = msg.dailyMax
		end

		info.normalProgress = msg.normalProgress
	end
end

function OriginaresmomModel:onExtremeChallengeRes(msg)
	if msg.win then
		local activityId = msg.activityId
		local info = self:getInfo(activityId)
		local isHit = false

		for i, v in ipairs(info.extremeStages) do
			if v.stageId == msg.stageId then
				local t = GameUtil.pbToTable(msg.stageInfo)

				v.score = t.score
				v.lockRaceIds = t.lockRaceIds
				isHit = true

				break
			end
		end

		if not isHit then
			local t = GameUtil.pbToTable(msg.stageInfo)

			table.insert(info.extremeStages, {
				score = t.score,
				lockRaceIds = t.lockRaceIds,
				stageId = msg.stageId
			})
		end
	end
end

function OriginaresmomModel:onGainNormalPrizeRes(msg)
	local activityId = msg.activityId
	local info = self:getInfo(activityId)

	table.insert(info.normalGainedPrizeIds, msg.prizeId)
end

function OriginaresmomModel:getExtStageInfo(activityId, stageId)
	local info = self:getInfo(activityId)

	for i, v in ipairs(info.extremeStages) do
		if v.stageId == stageId then
			return v
		end
	end
end

function OriginaresmomModel:onResetExtremeStageRes(msg)
	local activityId = msg.activityId
	local info = self:getInfo(activityId)

	for i, v in ipairs(info.extremeStages) do
		if v.stageId == msg.stageId then
			v.score = 0
			v.lockRaceIds = {}

			break
		end
	end
end

function OriginaresmomModel:isAllNorStagePass(activityId)
	local prizeCfgs = OriginaresmomConfig.instance:getNorPrizeCfgs(activityId)
	local info = self:getInfo(activityId)

	return #info.normalGainedPrizeIds >= #prizeCfgs
end

function OriginaresmomModel:getExtStageTotalScore(activityId)
	local info = self:getInfo(activityId)
	local totalScore = 0

	for i, v in ipairs(info.extremeStages) do
		totalScore = totalScore + v.score
	end

	return totalScore
end

function OriginaresmomModel:getExtLockRaceIdMap(activityId)
	local map = {}
	local info = self:getInfo(activityId)

	for i, sinfo in ipairs(info.extremeStages) do
		for _, v in ipairs(sinfo.lockRaceIds) do
			map[v] = true
		end
	end

	return map
end

OriginaresmomModel.instance = OriginaresmomModel.New()

return OriginaresmomModel
