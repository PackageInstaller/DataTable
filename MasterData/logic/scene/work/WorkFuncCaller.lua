-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/work/WorkFuncCaller.lua

module("logic.scene.work.WorkFuncCaller", package.seeall)

local M = class("WorkFuncCaller", WorkBase)

function M:ctor(funcCall, funcCallObj, funcCallParams)
	M.super.ctor(self)

	self._funcCall = funcCall
	self._funcCallObj = funcCallObj
	self._funcCallParams = funcCallParams
end

function M:onEnter(context)
	if self._funcCall then
		self._funcCall(self._funcCallObj, self._funcCallParams)
	end

	self:onDone(WorkResult.Succeed)
end

function M:onExit(isInterrupt)
	return
end

return M
