-- chunkname: @modules/logic/rouge/map/work/WaitRougeActorMoveToEndDoneWork.lua

module("modules.logic.rouge.map.work.WaitRougeActorMoveToEndDoneWork", package.seeall)

local WaitRougeActorMoveToEndDoneWork = class("WaitRougeActorMoveToEndDoneWork", BaseWork)

function WaitRougeActorMoveToEndDoneWork:ctor()
	return
end

function WaitRougeActorMoveToEndDoneWork:onStart()
	local needPlay = RougeMapModel.instance:needPlayMoveToEndAnim()

	if not needPlay then
		return self:onDone(true)
	end

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onBeforeActorMoveToEnd)
	RougeMapController.instance:registerCallback(RougeMapEvent.onEndActorMoveToEnd, self.onEndActorMoveToEnd, self)
end

function WaitRougeActorMoveToEndDoneWork:onEndActorMoveToEnd()
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onEndActorMoveToEnd, self.onEndActorMoveToEnd, self)
	self:onDone(true)
end

function WaitRougeActorMoveToEndDoneWork:clearWork()
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onEndActorMoveToEnd, self.onEndActorMoveToEnd, self)
end

return WaitRougeActorMoveToEndDoneWork
