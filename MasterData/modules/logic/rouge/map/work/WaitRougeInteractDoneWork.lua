-- chunkname: @modules/logic/rouge/map/work/WaitRougeInteractDoneWork.lua

module("modules.logic.rouge.map.work.WaitRougeInteractDoneWork", package.seeall)

local WaitRougeInteractDoneWork = class("WaitRougeInteractDoneWork", BaseWork)

function WaitRougeInteractDoneWork:ctor()
	return
end

function WaitRougeInteractDoneWork:onStart()
	local cutInteract = RougeMapModel.instance:getCurInteractive()

	if string.nilorempty(cutInteract) then
		return self:onDone(true)
	end

	RougeMapController.instance:registerCallback(RougeMapEvent.onClearInteract, self.onClearInteract, self)
	RougeMapInteractHelper.triggerInteractive()
end

function WaitRougeInteractDoneWork:onClearInteract()
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onClearInteract, self.onClearInteract, self)
	self:onDone(true)
end

function WaitRougeInteractDoneWork:clearWork()
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onClearInteract, self.onClearInteract, self)
end

return WaitRougeInteractDoneWork
