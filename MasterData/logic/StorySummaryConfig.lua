-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/storysummary/config/StorySummaryConfig.lua

module("logic.extensions.storysummary.config.StorySummaryConfig", package.seeall)

local StorySummaryConfig = class("StorySummaryConfig", BaseConfig)

function StorySummaryConfig:onInit()
	StorySummaryConfig.super.onInit(self)
end

function StorySummaryConfig:getNames()
	return {
		"story_summary",
		"story_summary_part",
		"story_summary_chapter",
		"story_summary_stage",
		"story_summary_support_pet",
		"story_summary_creeps"
	}
end

function StorySummaryConfig:handleConfig(name, content)
	if name == "story_summary" then
		self._ssCfg = content
	elseif name == "story_summary_part" then
		self._ssPartCfgs = content
		self._ssPartDataList = content.dataList
	elseif name == "story_summary_chapter" then
		self._ssChapterCfgs = content
		self._ssChapterDataList = content.dataList
	elseif name == "story_summary_stage" then
		self._ssStageCfgs = content
	elseif name == "story_summary_support_pet" then
		self._ssSupportCfgs = content
	elseif name == "story_summary_creeps" then
		self._ssCreepsCfgs = content
	end
end

function StorySummaryConfig:getSsCfg()
	return self._ssCfg or {}
end

function StorySummaryConfig:getSsData(storyPlanId)
	return self._ssCfg[storyPlanId] or {}
end

function StorySummaryConfig:getSsPartCfg(storyPlanId)
	return self._ssPartCfgs[storyPlanId] or {}
end

function StorySummaryConfig:getSsPartData(storyPlanId, partIdx)
	local ssPartCfg = self:getSsPartCfg(storyPlanId)

	return ssPartCfg[partIdx] or {}
end

function StorySummaryConfig:getSsPartDataByPId(partId)
	return self._ssPartDataList[partId]
end

function StorySummaryConfig:getSsChapterCfg(partId)
	return self._ssChapterCfgs[partId] or {}
end

function StorySummaryConfig:getSsChapterData(partId, chapterIdx)
	local ssChapterCfg = self:getSsChapterCfg(partId)

	return ssChapterCfg[chapterIdx] or {}
end

function StorySummaryConfig:getSsChapterDataByCId(chapterId)
	return self._ssChapterDataList[chapterId] or {}
end

function StorySummaryConfig:getSsStageCfg(chapterId)
	return self._ssStageCfgs[chapterId] or {}
end

function StorySummaryConfig:getSsStageData(chapterId, stageId)
	local ssStageCfg = self:getSsStageCfg(chapterId)

	return ssStageCfg[stageId] or {}
end

function StorySummaryConfig:getSsStageCfgByIdx(partId, chapterIdx)
	local ssChapterData = self:getSsChapterData(partId, chapterIdx)

	return self:getSsStageCfg(ssChapterData.chapterId)
end

function StorySummaryConfig:getSsSupportCfg(supportId)
	return self._ssSupportCfgs[supportId] or {}
end

function StorySummaryConfig:getSsSupportCfgByCSId(chapterId, stageId)
	local stageData = StorySummaryConfig.instance:getSsStageData(chapterId, stageId)

	return self:getSsSupportCfg(stageData.supportId)
end

function StorySummaryConfig:getSsCreepsCfg(creepsMasterId)
	return self._ssCreepsCfgs[creepsMasterId] or {}
end

function StorySummaryConfig:getSsCreepsCfgByCSId(chapterId, stageId)
	local stageData = StorySummaryConfig.instance:getSsStageData(chapterId, stageId)

	return self:getSsCreepsCfg(stageData.creepsMasterId)
end

StorySummaryConfig.instance = StorySummaryConfig.New()

return StorySummaryConfig
