-- chunkname: @modules/logic/rouge/map/work/WaitPopViewDoneWork.lua

module("modules.logic.rouge.map.work.WaitPopViewDoneWork", package.seeall)

local WaitPopViewDoneWork = class("WaitPopViewDoneWork", BaseWork)

function WaitPopViewDoneWork:ctor()
	return
end

function WaitPopViewDoneWork:onStart()
	local hadPop = RougePopController.instance:hadPopView()

	if not hadPop then
		return self:onDone(true)
	end

	RougeMapController.instance:registerCallback(RougeMapEvent.onPopViewDone, self.onPopViewDone, self)
	RougePopController.instance:tryPopView()
end

function WaitPopViewDoneWork:onPopViewDone()
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onPopViewDone, self.onPopViewDone, self)
	self:onDone(true)
end

function WaitPopViewDoneWork:clearWork()
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onPopViewDone, self.onPopViewDone, self)
end

return WaitPopViewDoneWork
