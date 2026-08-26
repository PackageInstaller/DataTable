-- chunkname: @modules/logic/versionactivity2_4/common/VersionActivity2_4JumpHandleFunc.lua

module("modules.logic.versionactivity2_4.common.VersionActivity2_4JumpHandleFunc", package.seeall)

local VersionActivity2_4JumpHandleFunc = class("VersionActivity2_4JumpHandleFunc")

function VersionActivity2_4JumpHandleFunc:jumpTo12401()
	VersionActivity2_4EnterController.instance:openVersionActivityEnterView()

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_4JumpHandleFunc:jumpTo12402(paramsList)
	local actId = paramsList[2]
	local episodeId = paramsList[3]

	table.insert(self.waitOpenViewNames, ViewName.VersionActivity2_4EnterView)
	table.insert(self.closeViewNames, ViewName.VersionActivity2_4DungeonMapLevelView)
	VersionActivity2_4DungeonModel.instance:setMapNeedTweenState(true)

	if episodeId then
		VersionActivity2_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			VersionActivity2_4DungeonController.instance:openVersionActivityDungeonMapView(nil, episodeId, function()
				ViewMgr.instance:openView(ViewName.VersionActivity2_4DungeonMapLevelView, {
					isJump = true,
					episodeId = episodeId
				})
			end)
		end, nil, actId, true)
	else
		VersionActivity2_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(VersionActivity2_4DungeonController.openVersionActivityDungeonMapView, VersionActivity2_4DungeonController.instance, actId, true)
	end

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_4JumpHandleFunc:jumpTo12403(paramsList)
	VersionActivity2_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(VersionActivity2_4DungeonController.openStoreView, VersionActivity2_4DungeonController.instance, VersionActivity2_4Enum.ActivityId.Dungeon, true)

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_4JumpHandleFunc:jumpTo12404(paramsList)
	local actId = paramsList[2]

	VersionActivity2_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		PinballController.instance:openMainView()
	end, nil, actId)

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_4JumpHandleFunc:jumpTo12405(paramsList)
	local actId = paramsList[2]

	VersionActivity2_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		VersionActivity2_4MusicController.instance:openVersionActivity2_4MusicChapterView()
	end, nil, actId)

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_4JumpHandleFunc:jumpTo11804(paramsList)
	local actId = paramsList[2]
	local episodeId = paramsList[3]

	table.insert(self.waitOpenViewNames, ViewName.VersionActivity2_4EnterView)
	table.insert(self.closeViewNames, ViewName.VersionActivity1_8DungeonMapLevelView)

	if episodeId then
		VersionActivity2_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			VersionActivity1_8DungeonController.instance:openVersionActivityDungeonMapView(nil, episodeId, function()
				ViewMgr.instance:openView(ViewName.VersionActivity1_8DungeonMapLevelView, {
					isJump = true,
					episodeId = episodeId
				})
			end)
		end, nil, actId, true)
	else
		VersionActivity2_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(VersionActivity1_8DungeonController.openVersionActivityDungeonMapView, VersionActivity1_8DungeonController.instance, actId, true)
	end

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_4JumpHandleFunc:jumpTo11815(paramsList)
	local isOpenFactoryBlueprint = paramsList and paramsList[3] == 2

	table.insert(self.waitOpenViewNames, ViewName.VersionActivity2_4EnterView)
	table.insert(self.waitOpenViewNames, ViewName.VersionActivity1_8DungeonMapView)
	table.insert(self.waitOpenViewNames, ViewName.VersionActivity1_8FactoryMapView)

	if not isOpenFactoryBlueprint then
		table.insert(self.closeViewNames, ViewName.VersionActivity1_8FactoryBlueprintView)
	end

	local function openFactoryFunc()
		Activity157Controller.instance:openFactoryMapView(isOpenFactoryBlueprint)
	end

	local function openDungeonMapFunc()
		if ViewMgr.instance:isOpen(ViewName.VersionActivity1_8DungeonMapView) then
			openFactoryFunc()
		else
			VersionActivity1_8DungeonController.instance:openVersionActivityDungeonMapView(nil, nil, openFactoryFunc)
		end
	end

	VersionActivity2_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(openDungeonMapFunc, nil, nil, true)

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_4JumpHandleFunc:jumpTo12408(paramsList)
	table.insert(self.waitOpenViewNames, ViewName.VersionActivity2_4EnterView)
	VersionActivity2_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(self.waitOpenViewNames, ViewName.ReactivityStoreView)
		ReactivityController.instance:openReactivityStoreView(VersionActivity2_4Enum.ActivityId.Reactivity)
	end)

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_4JumpHandleFunc:jumpTo12400(paramsList)
	local actId = paramsList[2]

	VersionActivity2_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, actId, true)

	return JumpEnum.JumpResult.Success
end

return VersionActivity2_4JumpHandleFunc
