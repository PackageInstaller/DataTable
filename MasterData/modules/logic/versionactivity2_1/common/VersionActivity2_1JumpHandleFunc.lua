-- chunkname: @modules/logic/versionactivity2_1/common/VersionActivity2_1JumpHandleFunc.lua

module("modules.logic.versionactivity2_1.common.VersionActivity2_1JumpHandleFunc", package.seeall)

local VersionActivity2_1JumpHandleFunc = class("VersionActivity2_1JumpHandleFunc")

function VersionActivity2_1JumpHandleFunc:jumpTo12115(paramsList)
	local actId = paramsList[2]

	VersionActivity2_1EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, actId, true)

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_1JumpHandleFunc:jumpTo12101(paramsList)
	VersionActivity2_1EnterController.instance:openVersionActivityEnterView()

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_1JumpHandleFunc:jumpTo12102(paramsList)
	local actId = paramsList[2]
	local episodeId = paramsList[3]

	table.insert(self.waitOpenViewNames, ViewName.VersionActivity2_1EnterView)
	table.insert(self.closeViewNames, ViewName.VersionActivity2_1DungeonMapLevelView)
	VersionActivity2_1DungeonModel.instance:setMapNeedTweenState(true)

	if episodeId then
		VersionActivity2_1EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			VersionActivity2_1DungeonController.instance:openVersionActivityDungeonMapView(nil, episodeId, function()
				ViewMgr.instance:openView(ViewName.VersionActivity2_1DungeonMapLevelView, {
					isJump = true,
					episodeId = episodeId
				})
			end)
		end, nil, actId, true)
	else
		VersionActivity2_1EnterController.instance:openVersionActivityEnterViewIfNotOpened(VersionActivity2_1DungeonController.openVersionActivityDungeonMapView, VersionActivity2_1DungeonController.instance, actId, true)
	end

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_1JumpHandleFunc:jumpTo12103(paramsList)
	VersionActivity2_1EnterController.instance:openVersionActivityEnterViewIfNotOpened(VersionActivity2_1DungeonController.openStoreView, VersionActivity2_1DungeonController.instance, VersionActivity2_1Enum.ActivityId.Dungeon, true)

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_1JumpHandleFunc:jumpTo12104(paramsList)
	local actId = paramsList[2]

	VersionActivity2_1EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		VersionActivity2_1DungeonController.instance:openVersionActivityDungeonMapView(nil, nil, function()
			Activity165Controller.instance:openActivity165EnterView()
		end)
	end, nil, actId)
end

function VersionActivity2_1JumpHandleFunc:jumpTo12105(paramsList)
	local actId = paramsList[2]

	VersionActivity2_1EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		AergusiController.instance:openAergusiLevelView()
	end, nil, actId)
end

function VersionActivity2_1JumpHandleFunc:jumpTo12114(paramsList)
	local actId = paramsList[2]

	VersionActivity2_1EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		Activity164Rpc.instance:sendGetActInfoRequest(VersionActivity2_1Enum.ActivityId.LanShouPa, self._onRecvMsg12114, self)
	end, nil, actId)
end

function VersionActivity2_1JumpHandleFunc:_onRecvMsg12114(cmd, resultCode, msg)
	if resultCode == 0 then
		ViewMgr.instance:openView(ViewName.LanShouPaMapView)
	end
end

return VersionActivity2_1JumpHandleFunc
