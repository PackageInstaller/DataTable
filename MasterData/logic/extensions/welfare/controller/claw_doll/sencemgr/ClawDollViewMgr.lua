-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/controller/claw_doll/sencemgr/ClawDollViewMgr.lua

module("logic.extensions.welfare.controller.claw_doll.sencemgr.ClawDollViewMgr", package.seeall)

local M = class("ClawDollViewMgr", ISceneFlowComp)

function M:ctor(flow)
	M.super.ctor(self, flow)
end

function M:onInit(sceneInfo)
	return
end

function M:onEnter()
	self:_setEvent(true)
end

function M:onEnterDone()
	local isBackScene = self._flow:getIsBackScene()

	if isBackScene then
		printWarn("===is back claw doll ===")
		ViewMgr.instance:_openPreFullUpView()
	else
		printWarn("===is normal enter claw doll ===")
		ViewMgr.instance:open(ViewName.ClawDollOperationView)
	end

	local info = SceneFace.instance:getCurrBackInfo()

	if info then
		info.isBack = nil
	end
end

function M:onExit()
	self:_setEvent(false)
end

function M:onExitDone()
	return
end

function M:onSceneLoadDone()
	return
end

function M:onLeaveScene()
	return
end

function M:onReturnScene()
	return
end

function M:onReturnSceneFinished()
	return
end

function M:_setEvent(add)
	if add then
		-- block empty
	end
end

return M
