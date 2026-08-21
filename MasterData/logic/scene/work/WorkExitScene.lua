-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/work/WorkExitScene.lua

module("logic.scene.work.WorkExitScene", package.seeall)

local M = class("WorkExitScene", WorkBase)

function M:onEnter(context)
	SceneMgr.instance:exitCurScene()
	self:onDone(WorkResult.Succeed)
end

return M
