-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/work/WorkDisableLoadingOptimize.lua

module("logic.scene.work.WorkDisableLoadingOptimize", package.seeall)

local M = class("WorkDisableLoadingOptimize", WorkBase)

function M:onEnter(context)
	LoadingOptimizeUtil.disableOptimize()
	self:onDone(WorkResult.Succeed)
end

function M:onExit(isInterrupt)
	return
end

return M
