-- chunkname: @modules/logic/versionactivity1_7/common/VersionActivity1_7JumpHandleFunc.lua

module("modules.logic.versionactivity1_7.common.VersionActivity1_7JumpHandleFunc", package.seeall)

local VersionActivity1_7JumpHandleFunc = class("VersionActivity1_7JumpHandleFunc")

function VersionActivity1_7JumpHandleFunc:jumpTo11720(paramsList)
	local actId = paramsList[2]

	if not ActivityModel.instance:isActOnLine(actId) then
		return JumpEnum.JumpResult.Fail
	end

	table.insert(self.waitOpenViewNames, ViewName.ActivityBeginnerView)
	ActivityModel.instance:setTargetActivityCategoryId(actId)
	ActivityController.instance:openActivityBeginnerView()

	return JumpEnum.JumpResult.Success
end

function VersionActivity1_7JumpHandleFunc:jumpTo11701(paramsList)
	VersionActivity1_7EnterController.instance:openVersionActivityEnterView()

	return JumpEnum.JumpResult.Success
end

function VersionActivity1_7JumpHandleFunc:jumpTo11702(paramsList)
	local actId = paramsList[2]

	VersionActivity1_7EnterController.instance:openVersionActivityEnterView(nil, nil, actId)

	return JumpEnum.JumpResult.Success
end

function VersionActivity1_7JumpHandleFunc:jumpTo11703(paramsList)
	VersionActivity1_7EnterController.instance:openVersionActivityEnterView(VersionActivity1_7DungeonController.openStoreView, VersionActivity1_7DungeonController.instance, VersionActivity1_7Enum.ActivityId.Dungeon)

	return JumpEnum.JumpResult.Success
end

function VersionActivity1_7JumpHandleFunc:jumpTo11700(paramsList)
	local actId = paramsList[2]

	VersionActivity1_7EnterController.instance:openVersionActivityEnterView(nil, nil, actId)

	return JumpEnum.JumpResult.Success
end

function VersionActivity1_7JumpHandleFunc:jumpTo11706(paramsList)
	local actId = paramsList[2]

	VersionActivity1_7EnterController.instance:openVersionActivityEnterView(ActIsoldeController.enterActivity, ActIsoldeController.instance, actId)

	return JumpEnum.JumpResult.Success
end

function VersionActivity1_7JumpHandleFunc:jumpTo11707(paramsList)
	local actId = paramsList[2]

	VersionActivity1_7EnterController.instance:openVersionActivityEnterView(ActMarcusController.enterActivity, ActMarcusController.instance, actId)

	return JumpEnum.JumpResult.Success
end

return VersionActivity1_7JumpHandleFunc
