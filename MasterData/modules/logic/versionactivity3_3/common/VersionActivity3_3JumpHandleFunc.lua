-- chunkname: @modules/logic/versionactivity3_3/common/VersionActivity3_3JumpHandleFunc.lua

module("modules.logic.versionactivity3_3.common.VersionActivity3_3JumpHandleFunc", package.seeall)

local VersionActivity3_3JumpHandleFunc = class("VersionActivity3_3JumpHandleFunc")

function VersionActivity3_3JumpHandleFunc:jumpTo13306(paramsList)
	local actId = paramsList[2]
	local episodeId = paramsList[3]
	local mapLevelViewName = VersionActivityFixedHelper.getVersionActivityDungeonMapLevelViewName()

	table.insert(self.waitOpenViewNames, ViewName.VersionActivity3_3EnterView)
	table.insert(self.closeViewNames, mapLevelViewName)
	VersionActivityFixedDungeonModel.instance:setMapNeedTweenState(true)

	local VersionActivity3_3DungeonController = VersionActivityFixedHelper.getVersionActivityDungeonController()

	if episodeId then
		VersionActivity3_3EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			VersionActivity3_3DungeonController.instance:openVersionActivityDungeonMapView(nil, episodeId, function()
				ViewMgr.instance:openView(mapLevelViewName, {
					isJump = true,
					episodeId = episodeId
				})
			end)
		end, nil, actId, true)
	else
		VersionActivity3_3EnterController.instance:openVersionActivityEnterViewIfNotOpened(VersionActivity3_3DungeonController.openVersionActivityDungeonMapView, VersionActivity3_3DungeonController.instance, actId, true)
	end

	return JumpEnum.JumpResult.Success
end

function VersionActivity3_3JumpHandleFunc:jumpTo13307(paramsList)
	VersionActivity3_3EnterController.instance:openVersionActivityEnterViewIfNotOpened(VersionActivity3_3DungeonController.openStoreView, VersionActivity3_3DungeonController.instance, VersionActivity3_3Enum.ActivityId.Dungeon, true)

	return JumpEnum.JumpResult.Success
end

function VersionActivity3_3JumpHandleFunc:jumpTo13309(paramsList)
	local actId = VersionActivity3_3Enum.ActivityId.Arcade

	VersionActivity3_3EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, actId, true)
end

function VersionActivity3_3JumpHandleFunc:jumpTo13310(paramsList)
	local actId = paramsList[2]
	local episodeId = paramsList[3]

	table.insert(self.waitOpenViewNames, VersionActivityFixedHelper.getVersionActivityEnterViewName())
	VersionActivity3_3EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		MarshaController.instance:enterLevelView(episodeId)
	end, nil, actId, true)

	return JumpEnum.JumpResult.Success
end

function VersionActivity3_3JumpHandleFunc:jumpTo13313(paramsList)
	local actId = paramsList[2]
	local episodeId = paramsList[3]

	table.insert(self.waitOpenViewNames, VersionActivityFixedHelper.getVersionActivityEnterViewName())
	VersionActivity3_3EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		IgorController.instance:enterEpisodeLevelView(actId, episodeId)
	end, nil, actId, true)

	return JumpEnum.JumpResult.Success
end

return VersionActivity3_3JumpHandleFunc
