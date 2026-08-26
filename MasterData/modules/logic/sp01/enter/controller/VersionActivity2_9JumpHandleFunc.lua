-- chunkname: @modules/logic/sp01/enter/controller/VersionActivity2_9JumpHandleFunc.lua

module("modules.logic.sp01.enter.controller.VersionActivity2_9JumpHandleFunc", package.seeall)

local VersionActivity2_9JumpHandleFunc = class("VersionActivity2_9JumpHandleFunc")

function VersionActivity2_9JumpHandleFunc:jumpTo130502(paramsList)
	local actId = paramsList[2]
	local episodeId = paramsList[3]
	local enterViewName = ViewName.VersionActivity2_9EnterView
	local mapLevelViewName = ViewName.VersionActivity2_9DungeonMapLevelView

	table.insert(self.waitOpenViewNames, enterViewName)
	table.insert(self.closeViewNames, mapLevelViewName)
	VersionActivityFixedDungeonModel.instance:setMapNeedTweenState(true)

	if episodeId then
		VersionActivity2_9EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			VersionActivity2_9DungeonController.instance:openVersionActivityDungeonMapView(nil, episodeId, function()
				ViewMgr.instance:openView(mapLevelViewName, {
					isJump = true,
					episodeId = episodeId
				})
			end)
		end, nil, actId, true)
	else
		VersionActivity2_9EnterController.instance:openVersionActivityEnterViewIfNotOpened(VersionActivity2_9DungeonController.openVersionActivityDungeonMapView, VersionActivity2_9DungeonController.instance, actId, true)
	end

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_9JumpHandleFunc:jumpTo130503(paramsList)
	table.insert(self.waitOpenViewNames, ViewName.VersionActivity2_9StoreView)
	VersionActivity2_9EnterController.instance:openVersionActivityEnterViewIfNotOpened(VersionActivity2_9DungeonController.openStoreView, VersionActivity2_9DungeonController.instance, VersionActivity2_9Enum.ActivityId.Dungeon, true)

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_9JumpHandleFunc:jumpTo130504(paramsList)
	VersionActivity2_9EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		VersionActivity2_9JumpHandleFunc._handleJumpTo130504(paramsList)
	end, nil, VersionActivity2_9Enum.ActivityId.Outside, true)

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_9JumpHandleFunc._handleJumpTo130504(paramsList)
	local type = paramsList[3]

	if type == 1 then
		local buildingType

		AssassinController.instance:openAssassinMapView({
			buildingType = (paramsList[4] or nil) and tonumber(paramsList[4])
		})
	elseif type == 2 then
		AssassinController.instance:openAssassinMapView({
			questMapId = tonumber(paramsList[3])
		})
	elseif type == 3 then
		AssassinController.instance:openAssassinMapView({
			questId = tonumber(paramsList[3])
		})
	else
		logError("not define type : %s", type)
	end
end

function VersionActivity2_9JumpHandleFunc:jumpTo130507(paramList)
	VersionActivity2_9EnterController.instance:openVersionActivityEnterViewIfNotOpened(OdysseyDungeonController.openDungeonView, OdysseyDungeonController.instance, VersionActivity2_9Enum.ActivityId.Dungeon2, true)

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_9JumpHandleFunc:jumpTo130518(paramsList)
	Activity204Controller.instance:jumpToActivity(paramsList[2])

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_9JumpHandleFunc:jumpTo130519(paramsList)
	Activity204Controller.instance:jumpToActivity(paramsList[2])

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_9JumpHandleFunc:jumpTo130508()
	local dungeonActId = VersionActivity3_0Enum.ActivityId.Reactivity

	if GameBranchMgr.instance:isOnVer(2, 9) then
		if not ViewMgr.instance:isOpen(ViewName.V2a3_ReactivityEnterview) then
			ViewMgr.instance:openView(ViewName.V2a3_ReactivityEnterview)
		end

		VersionActivity2_3DungeonController.instance:openStoreView()
	else
		VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(VersionActivity2_3DungeonController.openStoreView, VersionActivity2_3DungeonController.instance, dungeonActId, true)
	end

	return JumpEnum.JumpResult.Success
end

return VersionActivity2_9JumpHandleFunc
