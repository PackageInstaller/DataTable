-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/work/WorkEnableLoadingOptimize.lua

module("logic.scene.work.WorkEnableLoadingOptimize", package.seeall)

local M = class("WorkEnableLoadingOptimize", WorkBase)

function M:onEnter(context)
	LoadingOptimizeUtil.enableOptimize()
	self:onDone(WorkResult.Succeed)
end

function M:onExit(isInterrupt)
	return
end

return M
