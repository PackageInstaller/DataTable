-- chunkname: @modules/logic/versionactivity3_5/common/VersionActivity3_5JumpHandleFunc.lua

module("modules.logic.versionactivity3_5.common.VersionActivity3_5JumpHandleFunc", package.seeall)

local VersionActivity3_5JumpHandleFunc = class("VersionActivity3_5JumpHandleFunc")

function VersionActivity3_5JumpHandleFunc:jumpTo13502(paramsList)
	local actId = paramsList[2]
	local episodeId = paramsList[3]
	local mapLevelViewName = VersionActivityFixedHelper.getVersionActivityDungeonMapLevelViewName()

	table.insert(self.waitOpenViewNames, ViewName.VersionActivity3_5EnterView)
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

function VersionActivity3_5JumpHandleFunc:jumpTo13503(paramsList)
	local dungeonController = VersionActivityFixedHelper.getVersionActivityDungeonController()

	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(dungeonController.openStoreView, dungeonController.instance, VersionActivityFixedHelper.getVersionActivityEnum().ActivityId.Dungeon, true)

	return JumpEnum.JumpResult.Success
end

function VersionActivity3_5JumpHandleFunc:jumpTo13505(paramsList)
	local episodeId = paramsList and paramsList[3]

	table.insert(self.waitOpenViewNames, VersionActivityFixedHelper.getVersionActivityEnterViewName())
	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
		VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(nil, nil, VersionActivity3_5Enum.ActivityId.Lamona, true)
		LamonaController.instance:enterEpisodeLevelView(episodeId)
	end)

	return JumpEnum.JumpResult.Success
end

function VersionActivity3_5JumpHandleFunc:jumpTo13511(paramsList)
	local actId = paramsList[2]

	table.insert(self.waitOpenViewNames, VersionActivityFixedHelper.getVersionActivityEnterViewName())
	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
		AutoChessController.instance:enterMainView(actId)
	end, nil, actId, true)

	return JumpEnum.JumpResult.Success
end

function VersionActivity3_5JumpHandleFunc:jumpTo12706(paramsList)
	local actId = paramsList[2]
	local episodeId = paramsList[3]

	table.insert(self.waitOpenViewNames, ViewName.VersionActivity3_5EnterView)
	table.insert(self.closeViewNames, ViewName.VersionActivity2_7DungeonMapLevelView)

	local enterController = VersionActivityFixedHelper.getVersionActivityEnterController(3, 5)
	local dungeonController = VersionActivityFixedHelper.getVersionActivityDungeonController(2, 7)

	if episodeId then
		enterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			dungeonController.instance:openVersionActivityReactivityDungeonMapView(2, 7, nil, episodeId, function()
				ViewMgr.instance:openView(ViewName.VersionActivity2_7DungeonMapLevelView, {
					isJump = true,
					episodeId = episodeId
				})
			end)
		end, nil, actId, true)
	else
		enterController.instance:openVersionActivityEnterViewIfNotOpened(dungeonController.openVersionActivityReactivityDungeonMapView, dungeonController.instance, actId, true)
	end

	return JumpEnum.JumpResult.Success
end

function VersionActivity3_5JumpHandleFunc:jumpTo13504(paramsList)
	table.insert(self.waitOpenViewNames, VersionActivityFixedHelper.getVersionActivityEnterViewName())
	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(self.waitOpenViewNames, ViewName.ReactivityStoreView)
		ReactivityController.instance:openReactivityStoreView(VersionActivity3_5Enum.ActivityId.Reactivity)
	end)

	return JumpEnum.JumpResult.Success
end

return VersionActivity3_5JumpHandleFunc
