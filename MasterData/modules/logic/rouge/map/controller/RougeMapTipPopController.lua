-- chunkname: @modules/logic/rouge/map/controller/RougeMapTipPopController.lua

module("modules.logic.rouge.map.controller.RougeMapTipPopController", package.seeall)

local RougeMapTipPopController = class("RougeMapTipPopController")

function RougeMapTipPopController:init()
	if self.inited then
		return
	end

	self.inited = true
	self.waitTipsList = {}
	self.showing = false

	RougeMapController.instance:registerCallback(RougeMapEvent.onCreateMapDoneFlowDone, self.popNextTip, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self.popNextTip, self)
end

function RougeMapTipPopController:addPopTip(text)
	if not self.waitTipsList or string.nilorempty(text) then
		return
	end

	table.insert(self.waitTipsList, text)
	self:popNextTip()
end

function RougeMapTipPopController:addPopTipByInteractId(interactId)
	local interactCo = lua_rouge_interactive.configDict[interactId]

	if not interactCo then
		logError("not found interact id .. " .. tostring(interactId))

		return
	end

	self:addPopTip(interactCo.tips)
end

function RougeMapTipPopController:addPopTipByEffect(effectList)
	for _, effectId in ipairs(effectList) do
		local effectCo = lua_rouge_effect.configDict[effectId]

		if not effectCo then
			logError("not found effect id .. " .. tostring(effectId))
		else
			self:addPopTip(effectCo.tips)
		end
	end
end

function RougeMapTipPopController:popNextTip()
	local state = RougeMapModel.instance:getMapState()

	if state <= RougeMapEnum.MapState.WaitFlow then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.RougeNextLayerView) then
		return
	end

	if self.showing then
		return
	end

	local tip = table.remove(self.waitTipsList, 1)

	if string.nilorempty(tip) then
		return
	end

	self.showing = true

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onShowTip, tip)
	TaskDispatcher.runDelay(self._onHideTip, self, RougeMapEnum.TipShowDuration)
end

function RougeMapTipPopController:_onHideTip()
	self.showing = false

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onHideTip)
	TaskDispatcher.runDelay(self.popNextTip, self, RougeMapEnum.TipShowInterval)
end

function RougeMapTipPopController:clear()
	TaskDispatcher.cancelTask(self.onHideTip, self)
	TaskDispatcher.cancelTask(self.popNextTip, self)

	self.showing = false

	if self.waitTipsList then
		tabletool.clear(self.waitTipsList)
	end

	RougeMapController.instance:unregisterCallback(RougeMapEvent.onCreateMapDoneFlowDone, self.popNextTip, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self.popNextTip, self)

	self.inited = nil
end

function RougeMapTipPopController.getTipsByEffectId(effectId)
	local effectCo = lua_rouge_effect.configDict[effectId]

	return effectCo.tips
end

RougeMapTipPopController.instance = RougeMapTipPopController.New()

return RougeMapTipPopController
