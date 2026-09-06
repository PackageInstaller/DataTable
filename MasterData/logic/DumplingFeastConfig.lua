-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dumplingfeast/config/DumplingFeastConfig.lua

module("logic.extensions.dumplingfeast.config.DumplingFeastConfig", package.seeall)

local DumplingFeastConfig = class("DumplingFeastConfig", BaseConfig)

function DumplingFeastConfig:getNames()
	return {
		"dumpling_feast_activity",
		"dumpling_feast_creeps",
		"dumpling_feast_damage_progress",
		"dumpling_feast_dough_score",
		"dumpling_feast_dumpling",
		"dumpling_feast_filling_score",
		"dumpling_feast_intimacy",
		"dumpling_feast_intimacy_progress",
		"dumpling_feast_master",
		"dumpling_feast_quality",
		"dumpling_feast_support_pet",
		"dumpling_feast_boil_score",
		"dumpling_feast_rank_prize"
	}
end

function DumplingFeastConfig:handleConfig(name, content)
	if name == "dumpling_feast_activity" then
		self._dumpling_feast_activity = content
	elseif name == "dumpling_feast_creeps" then
		self._dumpling_feast_creeps = content
	elseif name == "dumpling_feast_damage_progress" then
		self._dumpling_feast_damage_progress = content
	elseif name == "dumpling_feast_dough_score" then
		self._dumpling_feast_dough_score = content
	elseif name == "dumpling_feast_dumpling" then
		self._dumpling_feast_dumpling = content
	elseif name == "dumpling_feast_filling_score" then
		self._dumpling_feast_filling_score = content
	elseif name == "dumpling_feast_intimacy" then
		self._dumpling_feast_intimacy = content
	elseif name == "dumpling_feast_intimacy_progress" then
		self._dumpling_feast_intimacy_progress = content
	elseif name == "dumpling_feast_master" then
		self._dumpling_feast_master = content
	elseif name == "dumpling_feast_quality" then
		self._dumpling_feast_quality = content
	elseif name == "dumpling_feast_support_pet" then
		self._dumpling_feast_support_pet = content
	elseif name == "dumpling_feast_boil_score" then
		self._dumpling_feast_boil_score = content
	elseif name == "dumpling_feast_rank_prize" then
		self._dumpling_feast_rank_prize = content
	end
end

function DumplingFeastConfig:_safeGet(data, ...)
	local keys = {
		...
	}
	local current = data

	for i = 1, #keys do
		if current and type(current) == "table" then
			current = current[keys[i]]
		else
			current = nil

			break
		end
	end

	return current
end

function DumplingFeastConfig:getActivityData(activityId)
	return self:_safeGet(self._dumpling_feast_activity, activityId)
end

function DumplingFeastConfig:getCreepsDatas(creepsMasterId)
	return self:_safeGet(self._dumpling_feast_creeps, creepsMasterId)
end

function DumplingFeastConfig:getCreepsData(creepsMasterId, creepsId)
	return self:_safeGet(self._dumpling_feast_creeps, creepsMasterId, creepsId)
end

function DumplingFeastConfig:getDamageProgressDatas(activityId)
	return self:_safeGet(self._dumpling_feast_damage_progress, activityId)
end

function DumplingFeastConfig:getDamageProgressData(activityId, progressId)
	return self:_safeGet(self._dumpling_feast_damage_progress, activityId, progressId)
end

function DumplingFeastConfig:getDoughScoreDatas(activityId)
	return self:_safeGet(self._dumpling_feast_dough_score, activityId)
end

function DumplingFeastConfig:getDoughScoreData(activityId, seconds)
	return self:_safeGet(self._dumpling_feast_dough_score, activityId, seconds)
end

function DumplingFeastConfig:getDumplingDatas(activityId)
	return self:_safeGet(self._dumpling_feast_dumpling, activityId)
end

function DumplingFeastConfig:getDumplingData(activityId, dumplingId)
	return self:_safeGet(self._dumpling_feast_dumpling, activityId, dumplingId)
end

function DumplingFeastConfig:getFillingScoreDatas(activityId)
	return self:_safeGet(self._dumpling_feast_filling_score, activityId)
end

function DumplingFeastConfig:getFillingScoreData(activityId, seconds)
	return self:_safeGet(self._dumpling_feast_filling_score, activityId, seconds)
end

function DumplingFeastConfig:getIntimacyDatas(buffPlanId)
	return self:_safeGet(self._dumpling_feast_intimacy, buffPlanId)
end

function DumplingFeastConfig:getIntimacyDataByIntimacy(buffPlanId, intimacy)
	local datas = self:getIntimacyDatas(buffPlanId)

	return MmUtil.unorderedSearchInSingleKey(datas, "intimacy", intimacy)
end

function DumplingFeastConfig:getIntimacyProgressDatas(activityId)
	return self:_safeGet(self._dumpling_feast_intimacy_progress, activityId)
end

function DumplingFeastConfig:getIntimacyProgressData(activityId, progressId)
	return self:_safeGet(self._dumpling_feast_intimacy_progress, activityId, progressId)
end

function DumplingFeastConfig:getMasterData(creepsMasterId)
	return self:_safeGet(self._dumpling_feast_master, creepsMasterId)
end

function DumplingFeastConfig:getQualityDatas(activityId)
	return self:_safeGet(self._dumpling_feast_quality, activityId)
end

function DumplingFeastConfig:getQualityData(activityId, quality)
	return self:_safeGet(self._dumpling_feast_quality, activityId, quality)
end

function DumplingFeastConfig:getMaxQuality(activityId)
	local datas = self:getQualityDatas(activityId)
	local data = datas and datas[#datas]

	return (data or nil) and (data.quality or 0)
end

function DumplingFeastConfig:getSupportPetDatas(activityId)
	local data = self:getActivityData(activityId)

	if data then
		if not data.supportPetPlan then
			local supportPetPlan = 0

			return self:_safeGet(self._dumpling_feast_support_pet, supportPetPlan)
		end
	end
end

function DumplingFeastConfig:getSupportPetData(activityId, creepsId)
	local data = self:getActivityData(activityId)

	if data then
		if not data.supportPetPlan then
			local supportPetPlan = 0

			return self:_safeGet(self._dumpling_feast_support_pet, supportPetPlan, creepsId)
		end
	end
end

function DumplingFeastConfig:getSupportPetDataByRaceId(activityId, raceId)
	local datas = self:getSupportPetDatas(activityId)

	for i, v in pairs(datas) do
		if v.raceId == raceId then
			return v
		end
	end

	return nil
end

function DumplingFeastConfig:getBoilScoreDatas(activityId)
	return self:_safeGet(self._dumpling_feast_boil_score, activityId)
end

function DumplingFeastConfig:getBoilScoreData(activityId, seconds)
	return self:_safeGet(self._dumpling_feast_boil_score, activityId, seconds)
end

function DumplingFeastConfig:getRankPrizeDatas(activityId)
	return self:_safeGet(self._dumpling_feast_rank_prize, activityId)
end

function DumplingFeastConfig:getRankPrizeData(activityId, rank)
	local datas = self:getRankPrizeDatas(activityId)

	return MmUtil.unorderedSearchInArrayKey(datas, "rankRange", rank)
end

DumplingFeastConfig.instance = DumplingFeastConfig.New()

return DumplingFeastConfig
