-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/plotcopy/config/CopyConfig.lua

module("logic.extensions.plotcopy.config.CopyConfig", package.seeall)

local CopyConfig = class("CopyConfig", BaseConfig)

function CopyConfig:onInit()
	CopyConfig.super.onInit(self)

	self._plotChallengeChapter = nil
	self._plotChallengeStage = nil
	self._plotStageExceptPure = nil
	self._plotChallengeTeam = nil
	self._plotChallengeCreeps = nil
	self._plotProgressRewardStrategy = nil
	self._plotArea = nil
	self._plotCommon = nil
	self._allChapters = {}
end

function CopyConfig:getNames()
	return {
		"plot_challenge_chapter",
		"plot_challenge_stage",
		"plot_challenge_team",
		"plot_challenge_creeps",
		"plot_progress_reward_strategy",
		"plot_area",
		"plot_common"
	}
end

function CopyConfig:handleConfig(name, content)
	if name == "plot_challenge_chapter" then
		self._plotChallengeChapter = content
	elseif name == "plot_challenge_stage" then
		self._plotStageExceptPure = self:_handleStagesExceptPurePlot(content)
		self._plotChallengeStage = content
	elseif name == "plot_challenge_team" then
		self._plotChallengeTeam = content
	elseif name == "plot_challenge_creeps" then
		self._plotChallengeCreeps = content
	elseif name == "plot_progress_reward_strategy" then
		self._plotProgressRewardStrategy = content
	elseif name == "plot_area" then
		self._plotArea = content
	elseif name == "plot_common" then
		self._plotCommon = content
	end
end

function CopyConfig:getChapters(chapterType)
	chapterType = checknumber(chapterType)

	if self._allChapters[chapterType] then
		return self._allChapters[chapterType]
	else
		local items = {}

		for k, v in pairs(self._plotChallengeChapter) do
			if v.chapterType == chapterType then
				table.insert(items, v)
			end
		end

		table.sort(items, function(cfg1, cfg2)
			return cfg1.chapterId < cfg2.chapterId
		end)

		self._allChapters[chapterType] = items

		return self._allChapters[chapterType]
	end
end

function CopyConfig:getChapter(id)
	return self._plotChallengeChapter[id]
end

function CopyConfig:getAllPlotChallengeState()
	return self._plotChallengeStage.dataList
end

function CopyConfig:getStages(chapterId)
	return self._plotChallengeStage[chapterId]
end

function CopyConfig:_handleStagesExceptPurePlot(content)
	local result = {}

	for chapterId, list in pairs(content) do
		result[chapterId] = {}

		for stageId, cfg in ipairs(list) do
			if not cfg.purePlot then
				table.insert(result[chapterId], cfg)
			end
		end
	end

	return result
end

function CopyConfig:getStagesExceptPurePlot(chapterId)
	return self._plotStageExceptPure[chapterId]
end

function CopyConfig:getStageById(chapterId, stageId)
	if self._plotChallengeStage[chapterId] then
		return self._plotChallengeStage[chapterId][stageId]
	end

	return nil
end

function CopyConfig:getTeamCfg(teamId)
	return self._plotChallengeTeam[teamId]
end

function CopyConfig:getFirstTeamTicket()
	if self._plotChallengeTeam.dataList[1] then
		return self._plotChallengeTeam.dataList[1].ticket
	end

	return ""
end

function CopyConfig:getTeamPets(teamId)
	return self._plotChallengeCreeps[teamId]
end

function CopyConfig:getTeamCfgById(chapterId, stageId)
	local cfg = self:getStageById(chapterId, stageId)

	if not cfg then
		return nil
	end

	if cfg.teamIds then
		return (self:getTeamCfg(cfg.teamIds))
	end

	return nil
end

function CopyConfig:getRewardStrategyDataList()
	return self._plotProgressRewardStrategy.dataList
end

function CopyConfig:getRewardStrategys(progressId)
	local results = {}

	if not self._plotProgressRewardStrategy[progressId] then
		return results
	end

	for k, v in pairs(self._plotProgressRewardStrategy[progressId]) do
		table.insert(results, v)
	end

	table.sort(results, function(cfg1, cfg2)
		return cfg1.condition < cfg2.condition
	end)

	return results
end

function CopyConfig:getRewardStrategyCondition(progressId, index)
	if not self._plotProgressRewardStrategy[progressId] then
		return 0
	end

	local curIndex = 1

	for k, v in pairs(self._plotProgressRewardStrategy) do
		if curIndex == index then
			return v.condition
		end
	end

	return 0
end

function CopyConfig:getPlotAreaCfgsCount()
	return #self._plotArea.dataList
end

function CopyConfig:getPlotAreaAllCfg()
	return self._plotArea
end

function CopyConfig:getPlotAreaCfg(id)
	return self._plotArea[id]
end

function CopyConfig:getCommonValue(key)
	if self._plotCommon[key] then
		return self._plotCommon[key].value
	end

	return ""
end

CopyConfig.instance = CopyConfig.New()

return CopyConfig
