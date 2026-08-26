-- chunkname: @modules/logic/versionactivity3_0/common/VersionActivity3_0JumpHandleFunc.lua

module("modules.logic.versionactivity3_0.common.VersionActivity3_0JumpHandleFunc", package.seeall)

local VersionActivity3_0JumpHandleFunc = class("VersionActivity3_0JumpHandleFunc")

function VersionActivity3_0JumpHandleFunc:jumpTo12102(paramsList)
	local actId = paramsList[2]
	local episodeId = paramsList[3]

	table.insert(self.waitOpenViewNames, ViewName.VersionActivity3_0EnterView)
	table.insert(self.closeViewNames, ViewName.VersionActivity2_1DungeonMapLevelView)
	VersionActivity2_1DungeonModel.instance:setMapNeedTweenState(true)

	if episodeId then
		VersionActivityFixedHelper.getVersionActivityEnterController(3, 0).instance:openVersionActivityEnterViewIfNotOpened(function()
			VersionActivity2_1DungeonController.instance:openVersionActivityDungeonMapView(nil, episodeId, function()
				ViewMgr.instance:openView(ViewName.VersionActivity2_1DungeonMapLevelView, {
					isJump = true,
					episodeId = episodeId
				})
			end)
		end, nil, actId, true)
	else
		VersionActivityFixedHelper.getVersionActivityEnterController(3, 0).instance:openVersionActivityEnterViewIfNotOpened(VersionActivity2_1DungeonController.openVersionActivityDungeonMapView, VersionActivity2_1DungeonController.instance, actId, true)
	end

	return JumpEnum.JumpResult.Success
end

function VersionActivity3_0JumpHandleFunc:jumpTo13010(paramsList)
	table.insert(self.waitOpenViewNames, ViewName.VersionActivity3_0EnterView)
	VersionActivityFixedHelper.getVersionActivityEnterController(3, 0).instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(self.waitOpenViewNames, ViewName.ReactivityStoreView)
		ReactivityController.instance:openReactivityStoreView(VersionActivity3_0Enum.ActivityId.Reactivity)
	end)

	return JumpEnum.JumpResult.Success
end

function VersionActivity3_0JumpHandleFunc:jumpTo12104(paramsList)
	local actId = paramsList[2]

	VersionActivityFixedHelper.getVersionActivityEnterController(3, 0).instance:openVersionActivityEnterViewIfNotOpened(function()
		VersionActivity2_1DungeonController.instance:openVersionActivityDungeonMapView(nil, nil, function()
			Activity165Controller.instance:openActivity165EnterView()
		end)
	end, nil, actId)

	return JumpEnum.JumpResult.Success
end

function VersionActivity3_0JumpHandleFunc:jumpTo13008(paramsList)
	VersionActivity3_0DungeonController.instance:openStoreView()

	return JumpEnum.JumpResult.Success
end

function VersionActivity3_0JumpHandleFunc:jumpTo13011(paramsList)
	local actId = paramsList[2]
	local isTrial = paramsList[3]

	table.insert(self.closeViewNames, ViewName.Activity201MaLiAnNaTaskView)

	if isTrial and isTrial == 1 then
		if ActivityHelper.getActivityStatus(actId) == ActivityEnum.ActivityStatus.Normal then
			local actco = ActivityConfig.instance:getActivityCo(actId)
			local episodeId = actco.tryoutEpisode

			if episodeId <= 0 then
				logError("没有配置对应的试用关卡")

				return JumpEnum.JumpResult.Fail
			end

			local config = DungeonConfig.instance:getEpisodeCO(episodeId)

			DungeonFightController.instance:enterFight(config.chapterId, episodeId)

			return JumpEnum.JumpResult.Success
		else
			local toastId, toastParamList = OpenHelper.getToastIdAndParam(self.actCo.openId)

			if toastId and toastId ~= 0 then
				GameFacade.showToast(toastId)

				return JumpEnum.JumpResult.Fail
			end

			return JumpEnum.JumpResult.Success
		end
	else
		Activity201MaLiAnNaController.instance:enterLevelView()

		return JumpEnum.JumpResult.Success
	end
end

function VersionActivity3_0JumpHandleFunc:jumpTo13000(paramsList)
	local actId = paramsList[2]

	VersionActivity3_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		Activity104Controller.instance:openSeasonMainView()
	end, nil, actId, true)

	return JumpEnum.JumpResult.Success
end

function VersionActivity3_0JumpHandleFunc:jumpTo13015(paramsList)
	table.insert(self.closeViewNames, ViewName.KaRongTaskView)
	table.insert(self.closeViewNames, ViewName.KaRongLevelView)

	return JumpEnum.JumpResult.Success
end

return VersionActivity3_0JumpHandleFunc
