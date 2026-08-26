-- chunkname: @modules/logic/versionactivity3_6/common/VersionActivity3_6JumpHandleFunc.lua

module("modules.logic.versionactivity3_6.common.VersionActivity3_6JumpHandleFunc", package.seeall)

local VersionActivity3_6JumpHandleFunc = class("VersionActivity3_6JumpHandleFunc")

function VersionActivity3_6JumpHandleFunc:jumpTo13604(paramsList)
	local actId = paramsList[2]
	local episodeId = paramsList[3]
	local mapLevelViewName = VersionActivityFixedHelper.getVersionActivityDungeonMapLevelViewName()

	table.insert(self.waitOpenViewNames, ViewName.VersionActivity3_6EnterView)
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

function VersionActivity3_6JumpHandleFunc:jumpTo13605(paramsList)
	local dungeonController = VersionActivityFixedHelper.getVersionActivityDungeonController()

	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(dungeonController.openStoreView, dungeonController.instance, VersionActivityFixedHelper.getVersionActivityEnum().ActivityId.Dungeon, true)

	return JumpEnum.JumpResult.Success
end

function VersionActivity3_6JumpHandleFunc:jumpTo13601(paramsList)
	table.insert(self.closeViewNames, ViewName.AbyssTaskView)
	table.insert(self.waitOpenViewNames, VersionActivityFixedHelper.getVersionActivityEnterViewName())
	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
		AbyssController.instance:openMainView(VersionActivity3_6Enum.ActivityId.Abyss)
	end, nil, VersionActivity3_6Enum.ActivityId.Abyss, true)

	return JumpEnum.JumpResult.Success
end

function VersionActivity3_6JumpHandleFunc:jumpTo13608(paramsList)
	table.insert(self.waitOpenViewNames, VersionActivityFixedHelper.getVersionActivityEnterViewName())
	VersionActivity3_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		VersionActivity3_6EnterController.instance:openVersionActivityEnterView(nil, nil, VersionActivity3_6Enum.ActivityId.YaMi)
	end, nil, VersionActivity3_6Enum.ActivityId.YaMi, true)

	return JumpEnum.JumpResult.Success
end

return VersionActivity3_6JumpHandleFunc
