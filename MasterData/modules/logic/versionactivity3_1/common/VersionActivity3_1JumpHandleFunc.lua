-- chunkname: @modules/logic/versionactivity3_1/common/VersionActivity3_1JumpHandleFunc.lua

module("modules.logic.versionactivity3_1.common.VersionActivity3_1JumpHandleFunc", package.seeall)

local VersionActivity3_1JumpHandleFunc = class("VersionActivity3_1JumpHandleFunc")

function VersionActivity3_1JumpHandleFunc:jumpTo12402(paramsList)
	local actId = paramsList[2]
	local episodeId = paramsList[3]

	table.insert(self.waitOpenViewNames, VersionActivityFixedHelper.getVersionActivityEnterViewName())
	table.insert(self.closeViewNames, ViewName.VersionActivity2_4DungeonMapLevelView)

	if episodeId then
		VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
			VersionActivity2_4DungeonController.instance:openVersionActivityDungeonMapView(nil, episodeId, function()
				ViewMgr.instance:openView(ViewName.VersionActivity2_4DungeonMapLevelView, {
					isJump = true,
					episodeId = episodeId
				})
			end)
		end, nil, actId, true)
	else
		VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(VersionActivity2_4DungeonController.openVersionActivityDungeonMapView, VersionActivity2_4DungeonController.instance, actId, true)
	end

	return JumpEnum.JumpResult.Success
end

function VersionActivity3_1JumpHandleFunc:jumpTo13114(paramsList)
	table.insert(self.waitOpenViewNames, VersionActivityFixedHelper.getVersionActivityEnterViewName())
	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(self.waitOpenViewNames, ViewName.ReactivityStoreView)
		ReactivityController.instance:openReactivityStoreView(VersionActivity3_1Enum.ActivityId.Reactivity)
	end)

	return JumpEnum.JumpResult.Success
end

function VersionActivity3_1JumpHandleFunc:jumpTo13103(paramsList)
	local actId = paramsList[2]
	local episodeId = paramsList[3]

	table.insert(self.waitOpenViewNames, ViewName.VersionActivity3_8EnterView)
	table.insert(self.closeViewNames, ViewName.VersionActivity3_1DungeonMapLevelView)

	local enterController = VersionActivityFixedHelper.getVersionActivityEnterController(3, 8)
	local dungeonController = VersionActivityFixedHelper.getVersionActivityDungeonController(3, 1)

	if episodeId then
		enterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			dungeonController.instance:openVersionActivityReactivityDungeonMapView(3, 1, nil, episodeId, function()
				ViewMgr.instance:openView(ViewName.VersionActivity3_1DungeonMapLevelView, {
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

function VersionActivity3_1JumpHandleFunc:jumpTo13104(paramsList)
	local dungeonController = VersionActivityFixedHelper.getVersionActivityDungeonController()
	local enterController = VersionActivityFixedHelper.getVersionActivityEnterController(3, 1)

	enterController.instance:openVersionActivityEnterViewIfNotOpened(dungeonController.openStoreView, dungeonController.instance, VersionActivityFixedHelper.getVersionActivityEnum().ActivityId.Dungeon, true)

	return JumpEnum.JumpResult.Success
end

function VersionActivity3_1JumpHandleFunc:jumpTo13117(paramsList)
	local episodeId = paramsList and paramsList[3]

	table.insert(self.waitOpenViewNames, VersionActivityFixedHelper.getVersionActivityEnterViewName())
	YeShuMeiController.instance:enterLevelView(episodeId)

	return JumpEnum.JumpResult.Success
end

function VersionActivity3_1JumpHandleFunc:jumpTo13106(paramsList)
	table.insert(self.waitOpenViewNames, VersionActivityFixedHelper.getVersionActivityEnterViewName())
	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
		VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(nil, nil, VersionActivity3_1Enum.ActivityId.Survival, true)
		SurvivalController.instance:openSurvivalView(nil)
	end)

	return JumpEnum.JumpResult.Success
end

function VersionActivity3_1JumpHandleFunc:jumpTo13105()
	local actId = Activity191Controller.instance:getActId()

	table.insert(self.waitOpenViewNames, VersionActivityFixedHelper.getVersionActivityEnterViewName())
	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(self.waitOpenViewNames, ViewName.Act191MainView)
		Activity191Controller.instance:enterActivity()
	end, nil, actId, true)

	return JumpEnum.JumpResult.Success
end

function VersionActivity3_1JumpHandleFunc:jumpTo13115()
	local actId = Activity191Controller.instance:getActId()

	table.insert(self.waitOpenViewNames, VersionActivityFixedHelper.getVersionActivityEnterViewName())
	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
		Activity191Controller.instance:enterActivity()
		Activity191Controller.instance:openStoreView()
	end, nil, actId, true)

	return JumpEnum.JumpResult.Success
end

return VersionActivity3_1JumpHandleFunc
