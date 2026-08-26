-- chunkname: @modules/logic/versionactivity2_8/common/VersionActivity2_8JumpHandleFunc.lua

module("modules.logic.versionactivity2_8.common.VersionActivity2_8JumpHandleFunc", package.seeall)

local VersionActivity2_8JumpHandleFunc = class("VersionActivity2_8JumpHandleFunc")

function VersionActivity2_8JumpHandleFunc:jumpTo12810(paramsList)
	local actId = paramsList[2]
	local episodeId = paramsList[3]

	table.insert(self.closeViewNames, ViewName.NuoDiKaTaskView)

	if ViewMgr.instance:isOpen(ViewName.NuoDiKaLevelView) then
		local data = {}

		data.actId = actId
		data.episodeId = episodeId

		NuoDiKaController.instance:enterEpisode(data)
	else
		local data = {}

		data.actId = actId
		data.episodeId = episodeId

		NuoDiKaController.instance:enterLevelView(data)
	end

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_8JumpHandleFunc:jumpTo12811(paramsList)
	local actId = paramsList[2]
	local episodeId = paramsList[3]

	table.insert(self.closeViewNames, ViewName.MoLiDeErTaskView)

	if ViewMgr.instance:isOpen(ViewName.MoLiDeErLevelView) then
		MoLiDeErController.instance:enterEpisode(actId, episodeId)
	else
		MoLiDeErController.instance:enterLevelView(actId, episodeId)
	end

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_8JumpHandleFunc:jumpTo12806(paramsList)
	local actId = paramsList[2]

	VersionActivity2_8EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, actId)

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_8JumpHandleFunc:jumpTo12803(paramsList)
	VersionActivity2_8DungeonController.instance:openStoreView()

	return JumpEnum.JumpResult.Success
end

return VersionActivity2_8JumpHandleFunc
