-- chunkname: @modules/logic/seasonver/act123/utils/Season123ProgressUtils.lua

module("modules.logic.seasonver.act123.utils.Season123ProgressUtils", package.seeall)

local Season123ProgressUtils = class("Season123ProgressUtils")

function Season123ProgressUtils.isStageUnlock(actId, stageId)
	local seasonMO = Season123Model.instance:getActInfo(actId)

	if not seasonMO then
		return false
	end

	local stageCO = Season123Config.instance:getStageCo(actId, stageId)

	if not stageCO then
		return false
	end

	local unlockConditions = GameUtil.splitString2(stageCO.preCondition, true, "|", "#")

	if not unlockConditions then
		return true
	else
		for i, condition in ipairs(unlockConditions) do
			local rs, reason, value = Season123ProgressUtils.isConditionPass(actId, condition, stageId)

			if not rs then
				return false, reason, value
			end
		end

		return true
	end
end

function Season123ProgressUtils.isConditionPass(actId, condition, stageId)
	if #condition <= 1 then
		return true
	end

	local conditionType = condition[1]

	if conditionType == Activity123Enum.PreCondition.StagePass then
		local seasonMO = Season123Model.instance:getActInfo(actId)

		if not seasonMO then
			return false
		end

		local stageMO = seasonMO:getStageMO(stageId)

		if not stageMO then
			return false, Activity123Enum.PreCondition.StagePass
		end
	elseif conditionType == Activity123Enum.PreCondition.OpenTime then
		local actInfoMO = ActivityModel.instance:getActMO(actId)
		local startTime = actInfoMO:getRealStartTimeStamp()

		if startTime ~= 0 then
			local passTimeSec = ServerTime.now() - startTime
			local day = math.ceil(passTimeSec / TimeUtil.OneDaySecond)
			local openDay = tonumber(condition[2])
			local remainTimeSec = math.max(0, (openDay - 1) * TimeUtil.OneDaySecond - passTimeSec)

			return openDay ~= nil and openDay <= day, Activity123Enum.PreCondition.OpenTime, {
				day = openDay - day,
				remainTime = remainTimeSec,
				showSec = remainTimeSec < TimeUtil.OneDaySecond
			}
		end
	end

	return true
end

function Season123ProgressUtils.getStageProgressStep(actId, stage)
	local seasonMO = Season123Model.instance:getActInfo(actId)

	if not seasonMO then
		return 0, 0
	end

	local stageMO = seasonMO:getStageMO(stage)

	if not stageMO then
		return 0, 0
	end

	return seasonMO:getStageRewardCount(stage)
end

function Season123ProgressUtils.stageInChallenge(actId, stage)
	local seasonMO = Season123Model.instance:getActInfo(actId)

	if not seasonMO then
		return false
	end

	return seasonMO.stage == stage and not Season123ProgressUtils.checkStageIsFinish(actId, stage)
end

function Season123ProgressUtils.checkStageIsFinish(actId, stage)
	local seasonMO = Season123Model.instance:getActInfo(actId)
	local stageMO = seasonMO:getStageMO(stage)
	local episodeCOs = Season123Config.instance:getSeasonEpisodeByStage(actId, stage)

	if stageMO and episodeCOs and #episodeCOs > 0 then
		local lastEpisodeCO = episodeCOs[#episodeCOs]
		local lastEpisodeMO = stageMO.episodeMap[lastEpisodeCO.layer]

		if lastEpisodeMO then
			return lastEpisodeMO:isFinished()
		end
	end

	return false
end

function Season123ProgressUtils.getMaxLayer(actId, stage)
	local episodeCfgs = Season123Config.instance:getSeasonEpisodeStageCos(actId, stage)

	if not episodeCfgs then
		return 0
	end

	local maxLayer = 0

	for _, co in ipairs(episodeCfgs) do
		if maxLayer < co.layer then
			maxLayer = co.layer
		end
	end

	return maxLayer
end

function Season123ProgressUtils.getEmptyLayerName(index, actId)
	return string.format("v1a7_season_img_pic_empty_%s", index)
end

function Season123ProgressUtils.getResultBg(pic, actId)
	local url = "singlebg/%s_season_singlebg/level/%s.png"

	return Season123ViewHelper.getIconUrl(url, pic, actId)
end

function Season123ProgressUtils.isEpisodeUnlock(actId, stage, layer)
	local seasonMO = Season123Model.instance:getActInfo(actId)

	if not seasonMO then
		return false
	end

	local curStageMO = seasonMO:getStageMO(stage)

	if not curStageMO then
		return false
	end

	local episodeMO = curStageMO:getEpisodeMo(layer)
	local isFinished = episodeMO and episodeMO:isFinished()

	if isFinished then
		return true
	end

	if layer <= 1 then
		return true
	end

	local prevLayerMO = curStageMO:getEpisodeMo(layer - 1)

	if not prevLayerMO or not prevLayerMO:isFinished() then
		return false
	end

	return true
end

return Season123ProgressUtils
