-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/materialchallenge/config/MaterialChallengeConfig.lua

module("logic.extensions.materialchallenge.config.MaterialChallengeConfig", package.seeall)

local MaterialChallengeConfig = class("MaterialChallengeConfig", BaseConfig)

function MaterialChallengeConfig:onInit()
	MaterialChallengeConfig.super.onInit(self)

	self._matChallengeTypeCfg = nil
	self._matChallengeStageCfg = nil
	self._matChallengeTeamCfg = nil
	self._matChallengeCreepsCfg = nil
	self._matChallengeDailyTask = nil
	self._matChallengeEvaluate = nil
	self._matChallengeBuy = nil
	self._material_challenge_other = nil
end

function MaterialChallengeConfig:getNames()
	return {
		"material_challenge_type",
		"material_challenge_stage",
		"material_challenge_team",
		"material_challenge_creeps",
		"material_challenge_daily_task",
		"material_challenge_evaluate",
		"material_challenge_buy",
		"material_challenge_other"
	}
end

function MaterialChallengeConfig:handleConfig(name, content)
	if name == "material_challenge_type" then
		self._matChallengeTypeCfg = content
	elseif name == "material_challenge_stage" then
		self._matChallengeStageCfg = content
	elseif name == "material_challenge_team" then
		self._matChallengeTeamCfg = content
	elseif name == "material_challenge_creeps" then
		self._matChallengeCreepsCfg = content
	elseif name == "material_challenge_daily_task" then
		self._matChallengeDailyTask = content
	elseif name == "material_challenge_evaluate" then
		self._matChallengeEvaluate = content
	elseif name == "material_challenge_buy" then
		self._matChallengeBuy = content
	elseif name == "material_challenge_other" then
		self._material_challenge_other = content
	end
end

function MaterialChallengeConfig:getChapter(chapterId)
	return self._matChallengeTypeCfg[chapterId]
end

function MaterialChallengeConfig:getChapters()
	return self._matChallengeTypeCfg
end

function MaterialChallengeConfig:getDailyDoubleTimes()
	local timeList = string.split(self:getConstValue("MULTIPLY_TIME"), "#")

	if timeList and timeList[1] and timeList[2] and GameUtil.checkIsInTimePeriod(timeList[1], timeList[2]) then
		return checknumber(self:getConstValue("MULTIPLY_DAILY_DOUBLE_TIMES"))
	end

	return checknumber(self:getConstValue("DAILY_DOUBLE_TIMES"))
end

function MaterialChallengeConfig:getStages(chapterId)
	return self._matChallengeStageCfg[chapterId]
end

function MaterialChallengeConfig:getStageById(chapterId, stageId)
	if self._matChallengeStageCfg[chapterId] then
		return self._matChallengeStageCfg[chapterId][stageId]
	end

	return nil
end

function MaterialChallengeConfig:getTeamCfg(teamId)
	return self._matChallengeTeamCfg[teamId]
end

function MaterialChallengeConfig:getTeamPets(teamId)
	return self._matChallengeCreepsCfg[teamId]
end

function MaterialChallengeConfig:getProcessorSection(chapterId, progress, processorSection)
	if self._matChallengeDailyTask[chapterId] and self._matChallengeDailyTask[chapterId][progress] then
		return self._matChallengeDailyTask[chapterId][progress][processorSection]
	end

	return nil
end

function MaterialChallengeConfig:getProcessorSectionCfgs(chapterId, progress)
	if self._matChallengeDailyTask[chapterId] then
		local sortList = {}
		local defaultList = self._matChallengeDailyTask[chapterId][progress]

		for k, v in pairs(defaultList) do
			table.insert(sortList, v)
		end

		table.sort(sortList, function(a, b)
			return a.processorSection < b.processorSection
		end)

		return sortList
	end

	return nil
end

function MaterialChallengeConfig:getEvaluateCfg(id, evaluate)
	if self._matChallengeEvaluate[id] then
		return self._matChallengeEvaluate[id][evaluate]
	end

	return nil
end

function MaterialChallengeConfig:getEvaluateCfgs(id)
	local sortList = {}
	local evaluateList = self._matChallengeEvaluate[id]

	for k, v in pairs(evaluateList) do
		table.insert(sortList, v)
	end

	table.sort(sortList, function(a, b)
		return a.processorSection < b.processorSection
	end)

	return sortList
end

function MaterialChallengeConfig:getChallengeBuyCfg(chapterId, times)
	if self._matChallengeBuy[chapterId] then
		return self._matChallengeBuy[chapterId][times]
	end

	return nil
end

function MaterialChallengeConfig:getConstValue(key)
	if self._material_challenge_other[key] then
		return self._material_challenge_other[key].value
	end

	return ""
end

MaterialChallengeConfig.instance = MaterialChallengeConfig.New()

return MaterialChallengeConfig
