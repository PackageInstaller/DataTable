-- chunkname: @modules/logic/versionactivity3_7/common/VersionActivity3_7JumpHandleFunc.lua

module("modules.logic.versionactivity3_7.common.VersionActivity3_7JumpHandleFunc", package.seeall)

local VersionActivity3_7JumpHandleFunc = class("VersionActivity3_7JumpHandleFunc")

function VersionActivity3_7JumpHandleFunc:jumpTo13704(paramsList)
	VersionActivityMainFixedHelper.getVersionActivityDungeonController().instance:openStoreView()

	return JumpEnum.JumpResult.Success
end

function VersionActivity3_7JumpHandleFunc:jumpTo13720(paramsList)
	table.insert(self.waitOpenViewNames, VersionActivityFixedHelper.getVersionActivityEnterViewName())
	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
		ArcadeGameController.instance:getArcadeInSideInfo()
	end, nil, VersionActivity3_7Enum.ActivityId.ArcadeV3a7)

	return JumpEnum.JumpResult.Success
end

function VersionActivity3_7JumpHandleFunc:jumpTo13701(paramsList)
	table.insert(self.waitOpenViewNames, VersionActivityFixedHelper.getVersionActivityEnterViewName())
	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(nil, nil, VersionActivity3_7Enum.ActivityId.Sodache)

	return JumpEnum.JumpResult.Success
end

function VersionActivity3_7JumpHandleFunc:jumpTo13744(paramsList)
	table.insert(self.closeViewNames, ViewName.AbyssTaskView)
	table.insert(self.waitOpenViewNames, VersionActivityFixedHelper.getVersionActivityEnterViewName())
	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
		AbyssController.instance:openMainView(VersionActivity3_7Enum.ActivityId.Abyss)
	end, nil, VersionActivity3_7Enum.ActivityId.Abyss, true)

	return JumpEnum.JumpResult.Success
end

function VersionActivity3_7JumpHandleFunc:jumpTo13723(paramsList)
	table.insert(self.closeViewNames, ViewName.V3a7_Wmz_TaskView)

	local actId = paramsList[2]
	local enterCtrlInst = VersionActivityFixedHelper.getVersionActivityEnterController().instance

	table.insert(self.waitOpenViewNames, VersionActivityFixedHelper.getVersionActivityEnterViewName())
	enterCtrlInst:openVersionActivityEnterViewIfNotOpened(nil, nil, actId, true)

	return JumpEnum.JumpResult.Success
end

return VersionActivity3_7JumpHandleFunc
