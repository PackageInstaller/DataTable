-- chunkname: @modules/logic/versionactivity3_8/common/VersionActivity3_8JumpHandleFunc.lua

module("modules.logic.versionactivity3_8.common.VersionActivity3_8JumpHandleFunc", package.seeall)

local VersionActivity3_8JumpHandleFunc = class("VersionActivity3_8JumpHandleFunc")

function VersionActivity3_8JumpHandleFunc:jumpTo13802(paramsList)
	local actId = paramsList[2]
	local episodeId = paramsList[3]
	local mapLevelViewName = VersionActivityFixedHelper.getVersionActivityDungeonMapLevelViewName()

	table.insert(self.waitOpenViewNames, ViewName.VersionActivity3_8EnterView)
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

function VersionActivity3_8JumpHandleFunc:jumpTo13803(paramsList)
	local dungeonController = VersionActivityFixedHelper.getVersionActivityDungeonController()

	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(dungeonController.openStoreView, dungeonController.instance, VersionActivityFixedHelper.getVersionActivityEnum().ActivityId.Dungeon, true)

	return JumpEnum.JumpResult.Success
end

function VersionActivity3_8JumpHandleFunc:jumpTo13812(paramsList)
	table.insert(self.waitOpenViewNames, VersionActivityFixedHelper.getVersionActivityEnterViewName())
	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(nil, nil, VersionActivity3_8Enum.ActivityId.DianJiShi, true)

	return JumpEnum.JumpResult.Success
end

function VersionActivity3_8JumpHandleFunc:jumpTo13808()
	local actId = Activity191Controller.instance:getActId()

	table.insert(self.waitOpenViewNames, VersionActivityFixedHelper.getVersionActivityEnterViewName())
	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(self.waitOpenViewNames, ViewName.Act191MainView)
		Activity191Controller.instance:enterActivity()
	end, nil, actId, true)

	return JumpEnum.JumpResult.Success
end

function VersionActivity3_8JumpHandleFunc:jumpTo13819()
	local actId = Activity191Controller.instance:getActId()

	table.insert(self.waitOpenViewNames, VersionActivityFixedHelper.getVersionActivityEnterViewName())
	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
		Activity191Controller.instance:enterActivity()
		Activity191Controller.instance:openStoreView()
	end, nil, actId, true)

	return JumpEnum.JumpResult.Success
end

function VersionActivity3_8JumpHandleFunc:jumpTo13810(paramsList)
	table.insert(self.closeViewNames, ViewName.AbyssTaskView)
	table.insert(self.waitOpenViewNames, VersionActivityFixedHelper.getVersionActivityEnterViewName())
	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
		AbyssController.instance:openMainView(VersionActivity3_8Enum.ActivityId.Abyss)
	end, nil, VersionActivity3_8Enum.ActivityId.Abyss, true)

	return JumpEnum.JumpResult.Success
end

function VersionActivity3_8JumpHandleFunc:jumpTo13804(paramsList)
	table.insert(self.waitOpenViewNames, VersionActivityFixedHelper.getVersionActivityEnterViewName())
	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(self.waitOpenViewNames, ViewName.ReactivityStoreView)
		ReactivityController.instance:openReactivityStoreView(VersionActivity3_8Enum.ActivityId.Reactivity)
	end)

	return JumpEnum.JumpResult.Success
end

return VersionActivity3_8JumpHandleFunc
