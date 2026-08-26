-- chunkname: @modules/logic/versionactivity3_4/common/VersionActivity3_4JumpHandleFunc.lua

module("modules.logic.versionactivity3_4.common.VersionActivity3_4JumpHandleFunc", package.seeall)

local VersionActivity3_4JumpHandleFunc = class("VersionActivity3_4JumpHandleFunc")

function VersionActivity3_4JumpHandleFunc:jumpTo13402(paramsList)
	local actId = paramsList[2]
	local episodeId = paramsList[3]
	local mapLevelViewName = VersionActivityFixedHelper.getVersionActivityDungeonMapLevelViewName()

	table.insert(self.waitOpenViewNames, ViewName.VersionActivity3_4EnterView)
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

function VersionActivity3_4JumpHandleFunc:jumpTo13403(paramsList)
	local dungeonController = VersionActivityFixedHelper.getVersionActivityDungeonController()

	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(dungeonController.openStoreView, dungeonController.instance, VersionActivityFixedHelper.getVersionActivityEnum().ActivityId.Dungeon, true)

	return JumpEnum.JumpResult.Success
end

function VersionActivity3_4JumpHandleFunc:jumpTo13406(paramsList)
	table.insert(self.waitOpenViewNames, VersionActivityFixedHelper.getVersionActivityEnterViewName())
	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
		VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(nil, nil, VersionActivity3_4Enum.ActivityId.Survival, true)
		SurvivalController.instance:openSurvivalView(nil)
	end)

	return JumpEnum.JumpResult.Success
end

function VersionActivity3_4JumpHandleFunc:jumpTo13437(paramsList)
	local actId = paramsList[2]
	local episodeId = paramsList[3]

	table.insert(self.waitOpenViewNames, VersionActivityFixedHelper.getVersionActivityEnterViewName())
	VersionActivity3_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		LuSiJianController.instance:enterLevelView(episodeId)
	end, nil, actId, true)

	return JumpEnum.JumpResult.Success
end

function VersionActivity3_4JumpHandleFunc:jumpTo13440(paramsList)
	table.insert(self.waitOpenViewNames, VersionActivityFixedHelper.getVersionActivityEnterViewName())
	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(self.waitOpenViewNames, ViewName.ReactivityStoreView)
		ReactivityController.instance:openReactivityStoreView(VersionActivity3_4Enum.ActivityId.Reactivity)
	end)

	return JumpEnum.JumpResult.Success
end

return VersionActivity3_4JumpHandleFunc
