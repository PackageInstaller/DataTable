-- chunkname: @modules/logic/rouge2/map/work/Rouge2_WaitPopViewDoneWork.lua

module("modules.logic.rouge2.map.work.Rouge2_WaitPopViewDoneWork", package.seeall)

local Rouge2_WaitPopViewDoneWork = class("Rouge2_WaitPopViewDoneWork", BaseWork)

function Rouge2_WaitPopViewDoneWork:ctor()
	return
end

function Rouge2_WaitPopViewDoneWork:onStart()
	local hadPop = Rouge2_PopController.instance:hadPopView()

	if not hadPop then
		return self:onDone(true)
	end

	Rouge2_MapController.instance:registerCallback(Rouge2_MapEvent.onPopViewDone, self.onPopViewDone, self)
	Rouge2_PopController.instance:tryPopView()
end

function Rouge2_WaitPopViewDoneWork:onPopViewDone()
	Rouge2_MapController.instance:unregisterCallback(Rouge2_MapEvent.onPopViewDone, self.onPopViewDone, self)
	self:onDone(true)
end

function Rouge2_WaitPopViewDoneWork:clearWork()
	Rouge2_MapController.instance:unregisterCallback(Rouge2_MapEvent.onPopViewDone, self.onPopViewDone, self)
end

return Rouge2_WaitPopViewDoneWork
