-- chunkname: @modules/logic/versionactivity2_0/common/VersionActivity2_0JumpHandleFunc.lua

module("modules.logic.versionactivity2_0.common.VersionActivity2_0JumpHandleFunc", package.seeall)

local VersionActivity2_0JumpHandleFunc = class("VersionActivity2_0JumpHandleFunc")

function VersionActivity2_0JumpHandleFunc:jumpTo12002(paramsList)
	VersionActivity2_0EnterController.instance:openVersionActivityEnterView()

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_0JumpHandleFunc:jumpTo12003(paramsList)
	local actId = paramsList[2]
	local episodeId = paramsList[3]

	table.insert(self.waitOpenViewNames, ViewName.VersionActivity2_0EnterView)
	table.insert(self.closeViewNames, ViewName.VersionActivity2_0DungeonMapLevelView)
	VersionActivity2_0DungeonModel.instance:setMapNeedTweenState(true)

	if episodeId then
		VersionActivity2_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
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
		VersionActivity2_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(VersionActivity2_0DungeonController.openVersionActivityDungeonMapView, VersionActivity2_0DungeonController.instance, actId, true)
	end

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_0JumpHandleFunc:jumpTo12004(paramsList)
	VersionActivity2_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(VersionActivity2_0DungeonController.openStoreView, VersionActivity2_0DungeonController.instance, VersionActivity2_0Enum.ActivityId.Dungeon, true)

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_0JumpHandleFunc:jumpTo12005(paramsList)
	table.insert(self.waitOpenViewNames, ViewName.VersionActivity2_0EnterView)
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

	VersionActivity2_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(openDungeonMapFunc, nil, nil, true)

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_0JumpHandleFunc:jumpTo12008(paramsList)
	local actId = paramsList[2]

	VersionActivity2_0EnterController.instance:openVersionActivityEnterView(VersionActivity2_0JumpHandleFunc.enterRoleActivity, actId, actId)

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_0JumpHandleFunc:jumpTo12009(paramsList)
	local actId = paramsList[2]

	VersionActivity2_0EnterController.instance:openVersionActivityEnterView(VersionActivity2_0JumpHandleFunc.enterRoleActivity, actId, actId)

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_0JumpHandleFunc.enterRoleActivity(actId)
	RoleActivityController.instance:enterActivity(actId)
end

function VersionActivity2_0JumpHandleFunc:jumpTo12001(paramsList)
	table.insert(self.waitOpenViewNames, ViewName.VersionActivity2_0EnterView)
	VersionActivity2_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(self.waitOpenViewNames, ViewName.ReactivityStoreView)
		ReactivityController.instance:openReactivityStoreView(JumpEnum.ActIdEnum.Act1_5Dungeon)
	end)

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_0JumpHandleFunc:jumpTo12006(paramsList)
	local actId = paramsList[2]

	VersionActivity2_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, actId, true)

	return JumpEnum.JumpResult.Success
end

return VersionActivity2_0JumpHandleFunc
