-- chunkname: @modules/logic/rouge2/map/work/Rouge2_WaitRougeActorMoveToEndDoneWork.lua

module("modules.logic.rouge2.map.work.Rouge2_WaitRougeActorMoveToEndDoneWork", package.seeall)

local Rouge2_WaitRougeActorMoveToEndDoneWork = class("Rouge2_WaitRougeActorMoveToEndDoneWork", BaseWork)

function Rouge2_WaitRougeActorMoveToEndDoneWork:ctor()
	return
end

function Rouge2_WaitRougeActorMoveToEndDoneWork:onStart()
	local needPlay = Rouge2_MapModel.instance:needPlayMoveToEndAnim()

	if not needPlay then
		return self:onDone(true)
	end

	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onBeforeActorMoveToEnd)
	Rouge2_MapController.instance:registerCallback(Rouge2_MapEvent.onEndActorMoveToEnd, self.onEndActorMoveToEnd, self)
end

function Rouge2_WaitRougeActorMoveToEndDoneWork:onEndActorMoveToEnd()
	Rouge2_MapController.instance:unregisterCallback(Rouge2_MapEvent.onEndActorMoveToEnd, self.onEndActorMoveToEnd, self)
	self:onDone(true)
end

function Rouge2_WaitRougeActorMoveToEndDoneWork:clearWork()
	Rouge2_MapController.instance:unregisterCallback(Rouge2_MapEvent.onEndActorMoveToEnd, self.onEndActorMoveToEnd, self)
end

return Rouge2_WaitRougeActorMoveToEndDoneWork
