-- chunkname: @modules/logic/rouge2/map/work/Rouge2_WaitRougeInteractDoneWork.lua

module("modules.logic.rouge2.map.work.Rouge2_WaitRougeInteractDoneWork", package.seeall)

local Rouge2_WaitRougeInteractDoneWork = class("Rouge2_WaitRougeInteractDoneWork", BaseWork)

function Rouge2_WaitRougeInteractDoneWork:ctor(notTrigger)
	self._notTrigger = notTrigger
end

function Rouge2_WaitRougeInteractDoneWork:onStart()
	local cutInteract = Rouge2_MapModel.instance:getCurInteractive()

	if string.nilorempty(cutInteract) then
		return self:onDone(true)
	end

	Rouge2_MapController.instance:registerCallback(Rouge2_MapEvent.onClearInteract, self.onClearInteract, self)

	if self._notTrigger then
		return
	end

	Rouge2_MapInteractHelper.triggerInteractive()
end

function Rouge2_WaitRougeInteractDoneWork:onClearInteract()
	Rouge2_MapController.instance:unregisterCallback(Rouge2_MapEvent.onClearInteract, self.onClearInteract, self)
	self:onDone(true)
end

function Rouge2_WaitRougeInteractDoneWork:clearWork()
	Rouge2_MapController.instance:unregisterCallback(Rouge2_MapEvent.onClearInteract, self.onClearInteract, self)
end

return Rouge2_WaitRougeInteractDoneWork
