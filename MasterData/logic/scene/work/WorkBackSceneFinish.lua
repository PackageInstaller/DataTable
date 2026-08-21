-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/work/WorkBackSceneFinish.lua

module("logic.scene.work.WorkBackSceneFinish", package.seeall)

local M = class("WorkBackSceneFinish", WorkBase)

function M:ctor()
	M.super.ctor(self)
end

function M:onEnter(context)
	local scene = SceneMgr.instance:getCurScene()

	if scene and scene.onReturnSceneFinished then
		scene:onReturnSceneFinished(context.infoBack.passThroughParam)
	end

	local readyBackFlow = context.infoBack.readyBackFlow

	if readyBackFlow then
		readyBackFlow:onReturnSceneFinished(context.infoBack.passThroughParam)
	end

	self:onDone(WorkResult.Succeed)
end

function M:onExit(isInterrupt)
	return
end

return M
