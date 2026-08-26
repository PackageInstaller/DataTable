-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/work/GaoSiNiaoWork_DelaySecond.lua

module("modules.logic.versionactivity3_1.gaosiniao.work.GaoSiNiaoWork_DelaySecond", package.seeall)

local GaoSiNiaoWork_DelaySecond = class("GaoSiNiaoWork_DelaySecond", GaoSiNiaoWorkBase)

function GaoSiNiaoWork_DelaySecond.s_create(durationSec)
	local work = GaoSiNiaoWork_DelaySecond.New()

	work._durationSec = durationSec

	return work
end

function GaoSiNiaoWork_DelaySecond:onStart()
	self:clearWork()

	if not self._durationSec then
		logWarn("durationSec is null")
		self:onSucc()

		return
	end

	if self._durationSec <= 0 then
		self:onSucc()
	else
		TaskDispatcher.cancelTask(self._delaySucc, self)
		TaskDispatcher.runDelay(self._delaySucc, self, self._durationSec)
	end
end

function GaoSiNiaoWork_DelaySecond:_delaySucc()
	self:onSucc()
end

function GaoSiNiaoWork_DelaySecond:clearWork()
	TaskDispatcher.cancelTask(self._delaySucc, self)
	GaoSiNiaoWork_DelaySecond.super.clearWork(self)
end

return GaoSiNiaoWork_DelaySecond
