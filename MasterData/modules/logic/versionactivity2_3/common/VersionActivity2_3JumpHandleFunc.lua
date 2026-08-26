-- chunkname: @modules/logic/versionactivity2_3/common/VersionActivity2_3JumpHandleFunc.lua

module("modules.logic.versionactivity2_3.common.VersionActivity2_3JumpHandleFunc", package.seeall)

local VersionActivity2_3JumpHandleFunc = class("VersionActivity2_3JumpHandleFunc")

function VersionActivity2_3JumpHandleFunc:jumpTo12301()
	VersionActivity2_3EnterController.instance:openVersionActivityEnterView()

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_3JumpHandleFunc:jumpTo12302(paramsList)
	local actId = paramsList[2]
	local episodeId = paramsList[3]

	table.insert(self.waitOpenViewNames, ViewName.VersionActivity2_3EnterView)
	table.insert(self.closeViewNames, ViewName.VersionActivity2_3DungeonMapLevelView)
	VersionActivity2_3DungeonModel.instance:setMapNeedTweenState(true)

	if episodeId then
		VersionActivity2_3EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			VersionActivity2_3DungeonController.instance:openVersionActivityDungeonMapView(nil, episodeId, function()
				ViewMgr.instance:openView(ViewName.VersionActivity2_3DungeonMapLevelView, {
					isJump = true,
					episodeId = episodeId
				})
			end)
		end, nil, actId, true)
	else
		VersionActivity2_3EnterController.instance:openVersionActivityEnterViewIfNotOpened(VersionActivity2_3DungeonController.openVersionActivityDungeonMapView, VersionActivity2_3DungeonController.instance, actId, true)
	end

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_3JumpHandleFunc:jumpTo12303(paramsList)
	VersionActivity2_3EnterController.instance:openVersionActivityEnterViewIfNotOpened(VersionActivity2_3DungeonController.openStoreView, VersionActivity2_3DungeonController.instance, VersionActivity2_3Enum.ActivityId.Dungeon, true)

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_3JumpHandleFunc:jumpTo12305(paramsList)
	table.insert(self.closeViewNames, ViewName.ActDuDuGuTaskView)
	table.insert(self.closeViewNames, ViewName.ActDuDuGuLevelView)

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

function VersionActivity2_3JumpHandleFunc:jumpTo12306(paramsList)
	table.insert(self.closeViewNames, ViewName.ZhiXinQuanErTaskView)
	table.insert(self.closeViewNames, ViewName.ZhiXinQuanErLevelView)

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

function VersionActivity2_3JumpHandleFunc:jumpTo12315(paramsList)
	local actId = paramsList[2]

	VersionActivity2_3EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, actId, true)

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_3JumpHandleFunc.enterRoleActivity(actId)
	RoleActivityController.instance:enterActivity(actId)
end

return VersionActivity2_3JumpHandleFunc
