-- chunkname: @IQIGame\\Module\\ActivityDungeon\\ActivityDungeonModule.lua

ActivityDungeonModule = {}

local this = ActivityDungeonModule

function this.GetCfgActivityStageDataArray(chapterId)
	local array = {}

	for _, v in pairsCfg(CfgActivityStageTable) do
		if v.ChapterId == chapterId then
			table.insert(array, v)
		end
	end

	table.sort(array, function(a, b)
		return a.Id < b.Id
	end)

	return array
end

function this.CheckChapterIsEnabled(chapterId)
	local dupPod = PlayerModule.GetActivityDup()

	for _, v in pairs(dupPod) do
		if v.chapterId == chapterId then
			return true
		end
	end

	return false
end

function this.CheckChapterIsPerfectPass(activityChapterPOD)
	local currentProgress, maxProgress = this.GetChapterProgress(activityChapterPOD)

	return currentProgress == maxProgress
end

function this.GetChapterProgress(activityChapterPOD)
	local stageData = this.GetCfgActivityStageDataArray(activityChapterPOD.chapterId)
	local len = #stageData
	local currentProgress = 0
	local maxProgress = 0

	for i = 1, len do
		maxProgress = maxProgress + #stageData[i].ChallengeDesc

		if activityChapterPOD.passStar[stageData[i].Id] and activityChapterPOD.passStar[stageData[i].Id].conditionIds then
			currentProgress = currentProgress + #activityChapterPOD.passStar[stageData[i].Id].conditionIds
		end
	end

	return currentProgress, maxProgress
end

function this.GetStageIsPass(stageId)
	local cfgStage = CfgUtil.GetCfgActivityStageDataWithID(stageId)
	local dupPod = PlayerModule.GetActivityDup()

	for _, v in pairs(dupPod) do
		if v.chapterId == cfgStage.ChapterId then
			return v.passStar[stageId] ~= nil and #v.passStar[stageId].conditionIds > 0
		end
	end

	return false
end
