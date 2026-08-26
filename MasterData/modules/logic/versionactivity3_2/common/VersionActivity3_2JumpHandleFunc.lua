-- chunkname: @modules/logic/versionactivity3_2/common/VersionActivity3_2JumpHandleFunc.lua

module("modules.logic.versionactivity3_2.common.VersionActivity3_2JumpHandleFunc", package.seeall)

local VersionActivity3_2JumpHandleFunc = class("VersionActivity3_2JumpHandleFunc")

function VersionActivity3_2JumpHandleFunc:jumpTo13223(paramsList)
	local actId = paramsList[2]
	local episodeId = paramsList[3]
	local mapLevelViewName = ViewName.VersionActivity3_2DungeonMapLevelView

	table.insert(self.waitOpenViewNames, ViewName.VersionActivity3_9EnterView)
	table.insert(self.closeViewNames, mapLevelViewName)
	VersionActivityFixedDungeonModel.instance:setMapNeedTweenState(true)

	local enterController = VersionActivityFixedHelper.getVersionActivityEnterController(3, 9)
	local dungeonController = VersionActivityFixedHelper.getVersionActivityDungeonController(3, 2)

	if episodeId then
		enterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			dungeonController.instance:openVersionActivityReactivityDungeonMapView(3, 2, nil, episodeId, function()
				ViewMgr.instance:openView(mapLevelViewName, {
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

function VersionActivity3_2JumpHandleFunc:jumpTo13224(paramsList)
	local dungeonController = VersionActivityFixedHelper.getVersionActivityDungeonController()

	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(dungeonController.openStoreView, dungeonController.instance, VersionActivityFixedHelper.getVersionActivityEnum().ActivityId.Dungeon, true)

	return JumpEnum.JumpResult.Success
end

function VersionActivity3_2JumpHandleFunc:jumpTo13229(paramsList)
	local episodeId = paramsList and paramsList[3]
	local actId = VersionActivity3_2Enum.ActivityId.HuiDiaoLan

	table.insert(self.waitOpenViewNames, VersionActivityFixedHelper.getVersionActivityEnterViewName())
	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
		VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(nil, nil, actId, true)
		HuiDiaoLanGameController.instance:enterEpisodeLevelView(actId, episodeId)
	end)

	return JumpEnum.JumpResult.Success
end

function VersionActivity3_2JumpHandleFunc:jumpTo13231(paramsList)
	local episodeId = paramsList and paramsList[3]
	local actId = VersionActivity3_2Enum.ActivityId.BeiLiEr

	table.insert(self.waitOpenViewNames, VersionActivityFixedHelper.getVersionActivityEnterViewName())
	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
		VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(nil, nil, actId, true)
		BeiLiErController.instance:enterLevelView(episodeId)
	end)

	return JumpEnum.JumpResult.Success
end

function VersionActivity3_2JumpHandleFunc:jumpTo13209(paramsList)
	local actId = VersionActivity3_2Enum.ActivityId.Rouge2

	Rouge2_Model.instance:setCurActId(actId)
	Rouge2_Controller.instance:enterDungeonView()

	return JumpEnum.JumpResult.Success
end

function VersionActivity3_2JumpHandleFunc:jumpTo13211(paramsList)
	local actId = paramsList[2]

	table.insert(self.waitOpenViewNames, VersionActivityFixedHelper.getVersionActivityEnterViewName())
	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
		AutoChessController.instance:enterMainView(actId)
	end, nil, actId, true)

	return JumpEnum.JumpResult.Success
end

return VersionActivity3_2JumpHandleFunc
