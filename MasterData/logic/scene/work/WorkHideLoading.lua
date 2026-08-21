-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/work/WorkHideLoading.lua

module("logic.scene.work.WorkHideLoading", package.seeall)

local M = class("WorkHideLoading", WorkBase)

function M:onEnter(context)
	LoadingFacade.instance:hideLoading()
	self:onDone(WorkResult.Succeed)
end

function M:onExit(isInterrupt)
	return
end

return M
