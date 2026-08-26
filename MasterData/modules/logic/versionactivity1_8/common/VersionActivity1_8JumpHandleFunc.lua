-- chunkname: @modules/logic/versionactivity1_8/common/VersionActivity1_8JumpHandleFunc.lua

module("modules.logic.versionactivity1_8.common.VersionActivity1_8JumpHandleFunc", package.seeall)

local VersionActivity1_8JumpHandleFunc = class("VersionActivity1_8JumpHandleFunc")

function VersionActivity1_8JumpHandleFunc:jumpTo11803(paramsList)
	VersionActivity1_8EnterController.instance:openVersionActivityEnterView()

	return JumpEnum.JumpResult.Success
end

function VersionActivity1_8JumpHandleFunc:jumpTo11804(paramsList)
	local actId = paramsList[2]
	local episodeId = paramsList[3]

	table.insert(self.waitOpenViewNames, ViewName.VersionActivity1_8EnterView)
	table.insert(self.closeViewNames, ViewName.VersionActivity1_8DungeonMapLevelView)

	if episodeId then
		VersionActivity1_8EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			VersionActivity1_8DungeonController.instance:openVersionActivityDungeonMapView(nil, episodeId, function()
				ViewMgr.instance:openView(ViewName.VersionActivity1_8DungeonMapLevelView, {
					isJump = true,
					episodeId = episodeId
				})
			end)
		end, nil, actId, true)
	else
		VersionActivity1_8EnterController.instance:openVersionActivityEnterViewIfNotOpened(VersionActivity1_8DungeonController.openVersionActivityDungeonMapView, VersionActivity1_8DungeonController.instance, actId, true)
	end

	return JumpEnum.JumpResult.Success
end

function VersionActivity1_8JumpHandleFunc:jumpTo11805(paramsList)
	VersionActivity1_8EnterController.instance:openVersionActivityEnterViewIfNotOpened(VersionActivity1_8DungeonController.openStoreView, VersionActivity1_8DungeonController.instance, VersionActivity1_8Enum.ActivityId.Dungeon, true)

	return JumpEnum.JumpResult.Success
end

function VersionActivity1_8JumpHandleFunc:jumpTo11815(paramsList)
	local isOpenFactoryBlueprint = paramsList and paramsList[3] == 2

	table.insert(self.waitOpenViewNames, ViewName.VersionActivity1_8EnterView)
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

	VersionActivity1_8EnterController.instance:openVersionActivityEnterViewIfNotOpened(openDungeonMapFunc, nil, nil, true)

	return JumpEnum.JumpResult.Success
end

function VersionActivity1_8JumpHandleFunc:jumpTo11806(paramsList)
	local actId = paramsList[2]

	VersionActivity1_8EnterController.instance:openVersionActivityEnterView(ActWeilaController.enterActivity, ActWeilaController.instance, actId)

	return JumpEnum.JumpResult.Success
end

function VersionActivity1_8JumpHandleFunc:jumpTo11807(paramsList)
	local actId = paramsList[2]

	VersionActivity1_8EnterController.instance:openVersionActivityEnterView(ActWindSongController.enterActivity, ActWindSongController.instance, actId)

	return JumpEnum.JumpResult.Success
end

function VersionActivity1_8JumpHandleFunc:jumpTo11810(paramsList)
	local actId = paramsList[2]

	if not ActivityModel.instance:isActOnLine(actId) then
		return JumpEnum.JumpResult.Fail
	end

	table.insert(self.waitOpenViewNames, ViewName.ActivityBeginnerView)
	ActivityModel.instance:setTargetActivityCategoryId(actId)
	ActivityController.instance:openActivityBeginnerView()

	return JumpEnum.JumpResult.Success
end

function VersionActivity1_8JumpHandleFunc:jumpTo11811(paramsList)
	local actId = paramsList[2]

	VersionActivity1_8EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, actId, true)

	return JumpEnum.JumpResult.Success
end

return VersionActivity1_8JumpHandleFunc
