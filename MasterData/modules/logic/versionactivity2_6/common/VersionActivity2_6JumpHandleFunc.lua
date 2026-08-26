-- chunkname: @modules/logic/versionactivity2_6/common/VersionActivity2_6JumpHandleFunc.lua

module("modules.logic.versionactivity2_6.common.VersionActivity2_6JumpHandleFunc", package.seeall)

local VersionActivity2_6JumpHandleFunc = class("VersionActivity2_6JumpHandleFunc")

function VersionActivity2_6JumpHandleFunc:jumpTo12601()
	VersionActivity2_6EnterController.instance:openVersionActivityEnterView()

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_6JumpHandleFunc:jumpTo12602(paramsList)
	local actId = paramsList[2]

	VersionActivity2_6EnterController.instance:openVersionActivityEnterView(nil, nil, actId)

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_6JumpHandleFunc:jumpTo12605(paramsList)
	local actId = paramsList[2]

	VersionActivity2_6EnterController.instance:openVersionActivityEnterView(nil, nil, actId)

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_6JumpHandleFunc:jumpTo12603(paramsList)
	VersionActivity2_6DungeonController.instance:openStoreView()

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_6JumpHandleFunc:jumpTo12606(paramsList)
	local actId = paramsList[2]

	VersionActivity2_6EnterController.instance:openVersionActivityEnterView(nil, nil, actId)

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_6JumpHandleFunc:jumpTo12618(paramsList)
	local actId = paramsList[2]

	VersionActivity2_6EnterController.instance:openVersionActivityEnterView(nil, nil, actId)

	return JumpEnum.JumpResult.Success
end

return VersionActivity2_6JumpHandleFunc
