-- chunkname: @modules/logic/rouge2/map/controller/Rouge2_MapTipPopController.lua

module("modules.logic.rouge2.map.controller.Rouge2_MapTipPopController", package.seeall)

local Rouge2_MapTipPopController = class("Rouge2_MapTipPopController")

function Rouge2_MapTipPopController:init()
	if self.inited then
		return
	end

	self.inited = true
	self.waitTipsList = {}
	self.showing = false

	Rouge2_MapController.instance:registerCallback(Rouge2_MapEvent.onCreateMapDoneFlowDone, self.popNextTip, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self.popNextTip, self)
end

function Rouge2_MapTipPopController:addPopTip(text)
	if not self.waitTipsList or string.nilorempty(text) then
		return
	end

	table.insert(self.waitTipsList, text)
	self:popNextTip()
end

function Rouge2_MapTipPopController:popTipImmediately(text)
	if not self.waitTipsList or string.nilorempty(text) then
		return
	end

	table.insert(self.waitTipsList, text)
	self:_popNextTip()
end

function Rouge2_MapTipPopController:popNextTip()
	local state = Rouge2_MapModel.instance:getMapState()

	if state <= Rouge2_MapEnum.MapState.WaitFlow then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.Rouge2_NextLayerView) then
		return
	end

	self:_popNextTip()
end

function Rouge2_MapTipPopController:_popNextTip()
	if self.showing then
		return
	end

	local tip = table.remove(self.waitTipsList, 1)

	if string.nilorempty(tip) then
		return
	end

	self.showing = true

	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onShowTip, tip)
	TaskDispatcher.runDelay(self.onHideTip, self, Rouge2_MapEnum.TipShowDuration)
end

function Rouge2_MapTipPopController:onHideTip()
	self.showing = false

	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onHideTip)
	TaskDispatcher.runDelay(self.popNextTip, self, Rouge2_MapEnum.TipShowInterval)
end

function Rouge2_MapTipPopController:clear()
	TaskDispatcher.cancelTask(self.onHideTip, self)
	TaskDispatcher.cancelTask(self.popNextTip, self)

	self.showing = false

	if self.waitTipsList then
		tabletool.clear(self.waitTipsList)
	end

	Rouge2_MapController.instance:unregisterCallback(Rouge2_MapEvent.onCreateMapDoneFlowDone, self.popNextTip, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self.popNextTip, self)

	self.inited = nil
end

Rouge2_MapTipPopController.instance = Rouge2_MapTipPopController.New()

return Rouge2_MapTipPopController
