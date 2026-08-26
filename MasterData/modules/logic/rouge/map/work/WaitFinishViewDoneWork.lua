-- chunkname: @modules/logic/rouge/map/work/WaitFinishViewDoneWork.lua

module("modules.logic.rouge.map.work.WaitFinishViewDoneWork", package.seeall)

local WaitFinishViewDoneWork = class("WaitFinishViewDoneWork", BaseWork)

function WaitFinishViewDoneWork:ctor(rougeFinish)
	self.rougeFinish = rougeFinish
end

function WaitFinishViewDoneWork:onStart()
	if self.rougeFinish then
		RougeMapController.instance:openRougeFinishView()
	else
		RougeMapController.instance:openRougeFailView()
	end

	RougeMapController.instance:registerCallback(RougeMapEvent.onFinishViewDone, self.onFinishViewDone, self)
end

function WaitFinishViewDoneWork:onFinishViewDone()
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onFinishViewDone, self.onFinishViewDone, self)
	self:onDone(true)
end

function WaitFinishViewDoneWork:clearWork()
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onFinishViewDone, self.onFinishViewDone, self)
end

return WaitFinishViewDoneWork
