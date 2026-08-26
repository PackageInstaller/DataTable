-- chunkname: @modules/logic/main/controller/work/MainPatFaceWork.lua

module("modules.logic.main.controller.work.MainPatFaceWork", package.seeall)

local MainPatFaceWork = class("MainPatFaceWork", BaseWork)

function MainPatFaceWork:onStart(context)
	PatFaceController.instance:registerCallback(PatFaceEvent.FinishAllPatFace, self._onFinishAllPatFace, self)

	local patFaceType = PatFaceEnum.patFaceType.Login

	if context and context.dailyRefresh then
		patFaceType = PatFaceEnum.patFaceType.NewDay
	end

	self._patFaceType = patFaceType

	local result = PatFaceController.instance:startPatFace(patFaceType)

	if not result then
		self:onDone(true)
	end
end

function MainPatFaceWork:_onFinishAllPatFace()
	self:onDone(true)
end

function MainPatFaceWork:clearWork()
	PatFaceController.instance:unregisterCallback(PatFaceEvent.FinishAllPatFace, self._onFinishAllPatFace, self)
	PatFaceController.instance:dispatchEvent(PatFaceEvent.PatFaceWorkDone, self._patFaceType)
end

return MainPatFaceWork
