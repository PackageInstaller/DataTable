-- chunkname: @modules/logic/versionactivity1_9/common/VersionActivity1_9JumpHandleFunc.lua

module("modules.logic.versionactivity1_9.common.VersionActivity1_9JumpHandleFunc", package.seeall)

local VersionActivity1_9JumpHandleFunc = class("VersionActivity1_9JumpHandleFunc")

function VersionActivity1_9JumpHandleFunc:jumpTo11901()
	VersionActivity1_9EnterController.instance:openVersionActivityEnterView()

	return JumpEnum.JumpResult.Success
end

function VersionActivity1_9JumpHandleFunc:jumpTo11902(paramsList)
	local actId = paramsList[2]

	VersionActivity1_9EnterController.instance:openVersionActivityEnterView(nil, nil, actId)

	return JumpEnum.JumpResult.Success
end

function VersionActivity1_9JumpHandleFunc:jumpTo11903(paramsList)
	local actId = paramsList[2]

	VersionActivity1_9EnterController.instance:openVersionActivityEnterView(nil, nil, actId)

	return JumpEnum.JumpResult.Success
end

function VersionActivity1_9JumpHandleFunc:jumpTo11905()
	if not ViewMgr.instance:isOpen(ViewName.DungeonMapView) then
		local result = self:jumpToDungeonViewWithEpisode("4#10730#1")

		if result ~= JumpEnum.JumpResult.Success then
			return result
		end
	end

	ToughBattleController.instance:jumpToActView()

	return JumpEnum.JumpResult.Success
end

function VersionActivity1_9JumpHandleFunc:jumpTo11908(paramsList)
	local actId = paramsList[2]

	VersionActivity1_9EnterController.instance:openVersionActivityEnterView(VersionActivity1_9JumpHandleFunc.enterRoleActivity, actId, actId)

	return JumpEnum.JumpResult.Success
end

function VersionActivity1_9JumpHandleFunc:jumpTo11909(paramsList)
	local actId = paramsList[2]

	VersionActivity1_9EnterController.instance:openVersionActivityEnterView(VersionActivity1_9JumpHandleFunc.enterRoleActivity, actId, actId)

	return JumpEnum.JumpResult.Success
end

function VersionActivity1_9JumpHandleFunc.enterRoleActivity(actId)
	RoleActivityController.instance:enterActivity(actId)
end

function VersionActivity1_9JumpHandleFunc:jumpTo11906(paramsList)
	local actId = paramsList[2]

	VersionActivity1_9EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, actId, true)

	return JumpEnum.JumpResult.Success
end

return VersionActivity1_9JumpHandleFunc
