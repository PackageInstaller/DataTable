-- chunkname: @modules/logic/versionactivity3_9/common/VersionActivity3_9JumpHandleFunc.lua

module("modules.logic.versionactivity3_9.common.VersionActivity3_9JumpHandleFunc", package.seeall)

local VersionActivity3_9JumpHandleFunc = class("VersionActivity3_9JumpHandleFunc")

function VersionActivity3_9JumpHandleFunc:jumpTo13923(paramsList)
	table.insert(self.waitOpenViewNames, VersionActivityFixedHelper.getVersionActivityEnterViewName())
	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(self.waitOpenViewNames, ViewName.ReactivityStoreView)
		ReactivityController.instance:openReactivityStoreView(VersionActivity3_9Enum.ActivityId.Reactivity)
	end)

	return JumpEnum.JumpResult.Success
end

function VersionActivity3_9JumpHandleFunc:jumpTo13902(paramsList)
	local actId = paramsList[2]
	local episodeId = paramsList[3]
	local mapLevelViewName = VersionActivityFixedHelper.getVersionActivityDungeonMapLevelViewName()

	table.insert(self.waitOpenViewNames, ViewName.VersionActivity3_9EnterView)
	table.insert(self.closeViewNames, mapLevelViewName)
	VersionActivityFixedDungeonModel.instance:setMapNeedTweenState(true)

	local dungeonController = VersionActivityFixedHelper.getVersionActivityDungeonController()

	if episodeId then
		VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
			dungeonController.instance:openVersionActivityDungeonMapView(nil, episodeId, function()
				ViewMgr.instance:openView(mapLevelViewName, {
					isJump = true,
					episodeId = episodeId
				})
			end)
		end, nil, actId, true)
	else
		VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(dungeonController.openVersionActivityDungeonMapView, dungeonController.instance, actId, true)
	end

	return JumpEnum.JumpResult.Success
end

function VersionActivity3_9JumpHandleFunc:jumpTo13903(paramsList)
	local dungeonController = VersionActivityFixedHelper.getVersionActivityDungeonController()

	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(dungeonController.openStoreView, dungeonController.instance, VersionActivityFixedHelper.getVersionActivityEnum().ActivityId.Dungeon, true)

	return JumpEnum.JumpResult.Success
end

return VersionActivity3_9JumpHandleFunc
