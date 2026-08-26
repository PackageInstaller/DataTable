-- chunkname: @modules/logic/battlepass/view/BpChangeViewContainer.lua

module("modules.logic.battlepass.view.BpChangeViewContainer", package.seeall)

local BpChangeViewContainer = class("BpChangeViewContainer", BaseViewContainer)

function BpChangeViewContainer:buildViews()
	return {}
end

function BpChangeViewContainer:onContainerOpen()
	UIBlockMgr.instance:startBlock("BP_Switch")
	TaskDispatcher.runDelay(self._delayClose, self, 1)
end

function BpChangeViewContainer:_delayClose()
	self:closeThis()
end

function BpChangeViewContainer:onContainerClose()
	UIBlockMgr.instance:endBlock("BP_Switch")
	TaskDispatcher.cancelTask(self._delayClose, self)
end

return BpChangeViewContainer
