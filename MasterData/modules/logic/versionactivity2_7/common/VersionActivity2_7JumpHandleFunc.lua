-- chunkname: @modules/logic/versionactivity2_7/common/VersionActivity2_7JumpHandleFunc.lua

module("modules.logic.versionactivity2_7.common.VersionActivity2_7JumpHandleFunc", package.seeall)

local VersionActivity2_7JumpHandleFunc = class("VersionActivity2_7JumpHandleFunc")

function VersionActivity2_7JumpHandleFunc:jumpTo12003(paramsList)
	local actId = paramsList[2]
	local episodeId = paramsList[3]

	table.insert(self.waitOpenViewNames, ViewName.VersionActivity2_7EnterView)
	table.insert(self.closeViewNames, ViewName.VersionActivity2_0DungeonMapLevelView)

	if episodeId then
		VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
			VersionActivity2_0DungeonController.instance:openVersionActivityDungeonMapView(nil, episodeId, function()
				local isOpenGraffitiEntrance = VersionActivity2_0DungeonModel.instance:getOpenGraffitiEntranceState()

				if isOpenGraffitiEntrance then
					ViewMgr.instance:closeView(ViewName.VersionActivity2_0DungeonMapGraffitiEnterView)
				end

				ViewMgr.instance:openView(ViewName.VersionActivity2_0DungeonMapLevelView, {
					isJump = true,
					episodeId = episodeId
				})
			end)
		end, nil, actId, true)
	else
		VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(VersionActivity2_0DungeonController.openVersionActivityDungeonMapView, VersionActivity2_0DungeonController.instance, actId, true)
	end

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_7JumpHandleFunc:jumpTo12713(paramsList)
	table.insert(self.waitOpenViewNames, ViewName.VersionActivity2_7EnterView)
	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(self.waitOpenViewNames, ViewName.ReactivityStoreView)
		ReactivityController.instance:openReactivityStoreView(VersionActivity2_7Enum.ActivityId.Reactivity)
	end)

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_7JumpHandleFunc:jumpTo12005(paramsList)
	table.insert(self.waitOpenViewNames, VersionActivityFixedHelper.getVersionActivityEnterViewName())
	table.insert(self.waitOpenViewNames, ViewName.VersionActivity2_0DungeonMapView)
	table.insert(self.waitOpenViewNames, ViewName.VersionActivity2_0DungeonGraffitiView)

	local function openGraffitiFunc()
		Activity161Controller.instance:openGraffitiView()
	end

	local function openDungeonMapFunc()
		if ViewMgr.instance:isOpen(ViewName.VersionActivity2_0DungeonMapView) then
			openGraffitiFunc()
		else
			VersionActivity2_0DungeonController.instance:openVersionActivityDungeonMapView(nil, nil, openGraffitiFunc)
		end
	end

	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(openDungeonMapFunc, nil, nil, true)

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_7JumpHandleFunc:jumpTo12701()
	local activityId = VersionActivity2_7Enum.ActivityId.Act191

	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterView(function()
		Activity191Controller.instance:enterActivity(activityId)
	end, nil, activityId, true)

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_7JumpHandleFunc:jumpTo12706(paramsList)
	local actId = paramsList[2]
	local episodeId = paramsList[3]
	local mapLevelViewName = VersionActivityFixedHelper.getVersionActivityDungeonMapLevelViewName()

	table.insert(self.waitOpenViewNames, ViewName.VersionActivity2_7EnterView)
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

function VersionActivity2_7JumpHandleFunc:jumpTo12707(paramsList)
	local dungeonController = VersionActivityFixedHelper.getVersionActivityDungeonController()

	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(dungeonController.openStoreView, dungeonController.instance, VersionActivityFixedHelper.getVersionActivityEnum().ActivityId.Dungeon, true)

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_7JumpHandleFunc:jumpTo12714(paramsList)
	local actId = paramsList[2]

	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(VersionActivity2_7JumpHandleFunc.enterRoleActivity, actId, actId)

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_7JumpHandleFunc.enterRoleActivity(actId)
	RoleActivityController.instance:enterActivity(actId)
end

function VersionActivity2_7JumpHandleFunc:jumpTo12702(paramsList)
	local actId = paramsList[2]

	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(nil, nil, actId)

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_7JumpHandleFunc:jumpTo12703(paramsList)
	local actId = paramsList[2]

	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(nil, nil, actId)

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_7JumpHandleFunc:jumpTo12704(paramsList)
	local actId = paramsList[2]

	VersionActivityFixedHelper.getVersionActivityEnterController():openVersionActivityEnterView(nil, nil, actId)

	return JumpEnum.JumpResult.Success
end

return VersionActivity2_7JumpHandleFunc
