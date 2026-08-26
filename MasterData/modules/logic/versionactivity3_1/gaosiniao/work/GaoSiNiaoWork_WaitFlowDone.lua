-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/work/GaoSiNiaoWork_WaitFlowDone.lua

module("modules.logic.versionactivity3_1.gaosiniao.work.GaoSiNiaoWork_WaitFlowDone", package.seeall)

local GaoSiNiaoWork_WaitFlowDone = class("GaoSiNiaoWork_WaitFlowDone", GaoSiNiaoWorkBase)

function GaoSiNiaoWork_WaitFlowDone.s_create(flowObj, ...)
	local res = GaoSiNiaoWork_WaitFlowDone.New()

	if isDebugBuild then
		assert(isTypeOf(flowObj, GaoSiNiaoFlowSequence_Base), debug.traceback())
	end

	res._flowObj = flowObj
	res._startParams = {
		...
	}

	return res
end

function GaoSiNiaoWork_WaitFlowDone:onStart()
	if not self._flowObj then
		logWarn("flowObj is invalid")
		self:onSucc()

		return
	end

	self._flowObj:reset()
	self._flowObj:registerDoneListener(self.onSucc, self)
	self._flowObj:start(unpack(self._startParams))
end

function GaoSiNiaoWork_WaitFlowDone:clearWork()
	GameUtil.onDestroyViewMember(self, "_flowObj")
	GaoSiNiaoWork_WaitFlowDone.super.clearWork(self)
end

return GaoSiNiaoWork_WaitFlowDone
