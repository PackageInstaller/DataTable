-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originweileita/model/OriginWeiLeiTaModel.lua

module("logic.extensions.originweileita.model.OriginWeiLeiTaModel", package.seeall)

local OriginWeiLeiTaModel = class("OriginWeiLeiTaModel", BaseModel)

function OriginWeiLeiTaModel:ctor()
	return
end

function OriginWeiLeiTaModel:onInit()
	self:onReset()
end

function OriginWeiLeiTaModel:onReset()
	self._msgInfos = {}
	self._fmtNorMo = OriginWeiLeiTaNorFmtMo.New()
	self._fmtExtMo = OriginWeiLeiTaExtFmtMo.New()
end

function OriginWeiLeiTaModel:setInfo(msg)
	self._msgInfos[msg.activityId] = GameUtil.pbToTable(msg)
	self._msgInfos[msg.activityId].extremeStages = self._msgInfos[msg.activityId].extremeStages or {}
end

function OriginWeiLeiTaModel:getInfo(activityId)
	return self._msgInfos[activityId]
end

function OriginWeiLeiTaModel:getNorFmtMo()
	return self._fmtNorMo
end

function OriginWeiLeiTaModel:getExtFmtMo()
	return self._fmtExtMo
end

function OriginWeiLeiTaModel:onNormalChallengeRes(msg)
	if msg.win then
		local activityId = msg.activityId
		local stageId = msg.stageId
		local info = self:getInfo(activityId)

		for i, v in ipairs(info.normalInfo.stages) do
			if v.stageId == stageId then
				v.todayMaxScore = math.max(msg.score, v.todayMaxScore)

				break
			end
		end

		info.normalInfo.totalScore = msg.totalScore
	end
end

function OriginWeiLeiTaModel:onExtremeChallengeRes(msg)
	if msg.stagePass then
		local activityId = msg.activityId
		local stageId = msg.stageId
		local info = self:getInfo(activityId)

		info.extremeStages = info.extremeStages or {}

		local isHit = false

		for i, v in ipairs(info.extremeStages) do
			if v.stageId == stageId then
				isHit = true
				v.lockRaceIds = GameUtil.pbToTable(msg.lockRaceIds) or {}

				break
			end
		end

		if not isHit then
			local var_9_0 = {}

			var_9_0.lockRaceIds = GameUtil.pbToTable(msg.lockRaceIds) or {}
			var_9_0.stageId = stageId

			table.insert(info.extremeStages, var_9_0)
		end
	end
end

function OriginWeiLeiTaModel:onGainNormalPrizeRes(msg)
	local activityId = msg.activityId
	local info = self:getInfo(activityId)

	if info and info.normalInfo then
		info.normalInfo.gainedPrizeIds = info.normalInfo.gainedPrizeIds or {}

		table.insert(info.normalInfo.gainedPrizeIds, msg.prizeId)
	end
end

function OriginWeiLeiTaModel:getExtStageInfo(activityId, stageId)
	local info = self:getInfo(activityId)

	if info and info.extremeStages then
		for i, v in ipairs(info.extremeStages) do
			if v.stageId == stageId then
				return v
			end
		end
	end
end

function OriginWeiLeiTaModel:onResetExtremeStageRes(activityId, stageId)
	local info = self:getInfo(activityId)

	if info and info.extremeStages then
		for i, v in ipairs(info.extremeStages) do
			if v.stageId == stageId then
				v.lockRaceIds = {}

				break
			end
		end
	end
end

function OriginWeiLeiTaModel:getNorPrizeIds(activityId)
	local info = self:getInfo(activityId)

	if info and info.normalInfo then
		return info.normalInfo.gainedPrizeIds or {}
	end

	return {}
end

function OriginWeiLeiTaModel:isAllNorStagePass(activityId)
	local prizeCfgs = OriginWeiLeiTaConfig.instance:getNorPrizeCfgs(activityId) or {}
	local prizeIds = self:getNorPrizeIds(activityId)

	return #prizeIds >= #prizeCfgs
end

function OriginWeiLeiTaModel:getExtLockRaceIdMap(activityId)
	local map = {}
	local info = self:getInfo(activityId)

	if info and info.extremeStages then
		for i, sinfo in ipairs(info.extremeStages) do
			if sinfo.lockRaceIds then
				for _, v in ipairs(sinfo.lockRaceIds) do
					map[v] = true
				end
			end
		end
	end

	return map
end

function OriginWeiLeiTaModel:getNorStageMaxScore(activityId, stageId)
	local info = self:getInfo(activityId)

	if info and info.normalInfo and info.normalInfo.stageInfo then
		for i, v in ipairs(info.normalInfo.stageInfo) do
			if v.stageId == stageId then
				return v.todayMaxScore or 0
			end
		end
	end

	return 0
end

function OriginWeiLeiTaModel:getTodayMaxScore(activityId)
	local info = self:getInfo(activityId)

	if info and info.normalInfo then
		return info.normalInfo.totalScore
	end

	return 0
end

OriginWeiLeiTaModel.instance = OriginWeiLeiTaModel.New()

return OriginWeiLeiTaModel
