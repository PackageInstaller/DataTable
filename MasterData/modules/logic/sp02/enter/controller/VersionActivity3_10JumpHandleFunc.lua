-- chunkname: @modules/logic/sp02/enter/controller/VersionActivity3_10JumpHandleFunc.lua

module("modules.logic.sp02.enter.controller.VersionActivity3_10JumpHandleFunc", package.seeall)

local VersionActivity3_10JumpHandleFunc = class("VersionActivity3_10JumpHandleFunc")

function VersionActivity3_10JumpHandleFunc:jumpTo138502(paramsList)
	local actId = paramsList[2]
	local episodeId = paramsList[3]
	local enterViewName = ViewName.VersionActivity3_10EnterView
	local mapLevelViewName = ViewName.VersionActivity3_10DungeonMapLevelView

	table.insert(self.waitOpenViewNames, enterViewName)
	table.insert(self.closeViewNames, mapLevelViewName)
	VersionActivityFixedDungeonModel.instance:setMapNeedTweenState(true)

	if episodeId then
		VersionActivity3_10EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			VersionActivity3_10DungeonController.instance:openVersionActivityDungeonMapView(nil, episodeId, function()
				ViewMgr.instance:openView(mapLevelViewName, {
					isJump = true,
					episodeId = episodeId
				})
			end)
		end, nil, actId, true)
	else
		VersionActivity3_10EnterController.instance:openVersionActivityEnterViewIfNotOpened(VersionActivity3_10DungeonController.openVersionActivityDungeonMapView, VersionActivity3_10DungeonController.instance, actId, true)
	end

	return JumpEnum.JumpResult.Success
end

function VersionActivity3_10JumpHandleFunc:jumpTo138503(paramsList)
	table.insert(self.waitOpenViewNames, ViewName.VersionActivity3_10StoreView)
	VersionActivity3_10EnterController.instance:openVersionActivityEnterViewIfNotOpened(VersionActivity3_10DungeonController.openStoreView, VersionActivity3_10DungeonController.instance, VersionActivity3_10Enum.ActivityId.Dungeon, true)

	return JumpEnum.JumpResult.Success
end

function VersionActivity3_10JumpHandleFunc:jumpTo138521(paramsList)
	table.insert(self.closeViewNames, ViewName.AbyssTaskView)
	table.insert(self.waitOpenViewNames, VersionActivityFixedHelper.getVersionActivityEnterViewName())
	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
		AbyssController.instance:openMainView(VersionActivity3_10Enum.ActivityId.Abyss)
	end, nil, VersionActivity3_10Enum.ActivityId.Abyss, true)

	return JumpEnum.JumpResult.Success
end

return VersionActivity3_10JumpHandleFunc
