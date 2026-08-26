-- chunkname: @modules/logic/versionactivity2_2/common/VersionActivity2_2JumpHandleFunc.lua

module("modules.logic.versionactivity2_2.common.VersionActivity2_2JumpHandleFunc", package.seeall)

local VersionActivity2_2JumpHandleFunc = class("VersionActivity2_2JumpHandleFunc")

function VersionActivity2_2JumpHandleFunc:jumpTo12201()
	VersionActivity2_2EnterController.instance:openVersionActivityEnterView()

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_2JumpHandleFunc:jumpTo12202(paramsList)
	local actId = paramsList[2]

	VersionActivity2_2EnterController.instance:openVersionActivityEnterView(nil, nil, actId)

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_2JumpHandleFunc:jumpTo12210(paramsList)
	local actId = paramsList[2]

	VersionActivity2_2EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, actId, true)

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_2JumpHandleFunc:jumpTo12203(paramsList)
	local actId = paramsList[2]

	if ActivityHelper.getActivityStatus(actId) == ActivityEnum.ActivityStatus.Normal then
		local actConfig = ActivityConfig.instance:getActivityCo(actId)
		local episodeId = actConfig.tryoutEpisode

		if episodeId <= 0 then
			logError("没有配置对应的试用关卡")

			return
		end

		local config = DungeonConfig.instance:getEpisodeCO(episodeId)

		DungeonFightController.instance:enterFight(config.chapterId, episodeId)
	end
end

function VersionActivity2_2JumpHandleFunc:jumpTo12204(paramsList)
	local actId = paramsList[2]

	if ActivityHelper.getActivityStatus(actId) == ActivityEnum.ActivityStatus.Normal then
		local actConfig = ActivityConfig.instance:getActivityCo(actId)
		local episodeId = actConfig.tryoutEpisode

		if episodeId <= 0 then
			logError("没有配置对应的试用关卡")

			return
		end

		local config = DungeonConfig.instance:getEpisodeCO(episodeId)

		DungeonFightController.instance:enterFight(config.chapterId, episodeId)
	end
end

return VersionActivity2_2JumpHandleFunc
