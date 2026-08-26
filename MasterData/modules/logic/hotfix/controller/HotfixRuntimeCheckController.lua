-- chunkname: @modules/logic/hotfix/controller/HotfixRuntimeCheckController.lua

module("modules.logic.hotfix.controller.HotfixRuntimeCheckController", package.seeall)

local HotfixRuntimeCheckController = class("HotfixRuntimeCheckController", BaseController)

HotfixRuntimeCheckController.NoInteractInterval = 600
HotfixRuntimeCheckController.HotfixCheckInterval = 600

local StoreCheckTabIds = {
	[610] = true,
	[100] = true,
	[110] = true,
	[170] = true,
	[410] = true
}

function HotfixRuntimeCheckController:onInit()
	self.enableCheck = true
end

function HotfixRuntimeCheckController:addConstEvents()
	logNormal("HotfixRuntimeCheckController addConstEvents")
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self.handleOnOpenView, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonTabSet, self._handleSummonTabChange, self)
	self.addEventCb(self, StoreController.instance, StoreEvent.OnSwitchTab, self._handleStoreTabChange, self)
	self.addEventCb(self, GameStateMgr.instance, GameStateEvent.OnTouchScreenUp, self._onTouchScreen, self)
	TaskDispatcher.runRepeat(self._onTick, self, 10)
end

function HotfixRuntimeCheckController:reInit()
	self._lastCheckTime = nil

	self:cleanFlow()
end

function HotfixRuntimeCheckController:checkInitViewNames()
	if ViewName and not self._focusViewNames then
		self._focusViewNames = {
			[ViewName.SummonADView] = true,
			[ViewName.StoreView] = true
		}
	end
end

function HotfixRuntimeCheckController:isViewNeedCheckVersion(viewName)
	self:checkInitViewNames()

	if viewName and self._focusViewNames and self._focusViewNames[viewName] then
		return true
	end

	return false
end

function HotfixRuntimeCheckController:isTimeToCheckVersion()
	return not self._lastCheckTime or Time.time - self._lastCheckTime > HotfixRuntimeCheckController.HotfixCheckInterval
end

function HotfixRuntimeCheckController:_onTouchScreen()
	self._lastInteractTime = Time.realtimeSinceStartup
end

function HotfixRuntimeCheckController:_onTick()
	if not ViewMgr.instance:isOpen(ViewName.MainView) then
		self._lastInteractTime = Time.realtimeSinceStartup

		return
	end

	local now = Time.realtimeSinceStartup

	if self._lastInteractTime and now - self._lastInteractTime > HotfixRuntimeCheckController.NoInteractInterval and self:isTimeToCheckVersion() then
		self:checkNewVersion()

		self._lastInteractTime = now
	end
end

function HotfixRuntimeCheckController:checkNewVersion()
	if self.enableCheck and self:isTimeToCheckVersion() then
		self._lastCheckTime = Time.time

		if not self._flowCheckVer then
			self._flowCheckVer = FlowSequence.New()

			self._flowCheckVer:addWork(RuntimeCheckVersionWork.New())
			self._flowCheckVer:registerDoneListener(self.handleCheckVersionFlowDone, self)
			self._flowCheckVer:start()
		end
	end
end

function HotfixRuntimeCheckController:cleanFlow()
	if self._flowCheckVer then
		self._flowCheckVer:stop()
		self._flowCheckVer:unregisterDoneListener(self.handleCheckVersionFlowDone, self)

		self._flowCheckVer = nil
	end
end

function HotfixRuntimeCheckController:handleCheckVersionFlowDone(success)
	logNormal("HotfixRuntimeCheckController CheckVersionFlowDone : " .. tostring(success))
	self:cleanFlow()
end

function HotfixRuntimeCheckController:handleOnOpenView(viewName)
	if self:isViewNeedCheckVersion(viewName) then
		self:checkNewVersion()
	end
end

function HotfixRuntimeCheckController:_handleSummonTabChange()
	self:checkNewVersion()
end

function HotfixRuntimeCheckController:_handleStoreTabChange(storeEntranceCfg)
	if storeEntranceCfg and StoreCheckTabIds[storeEntranceCfg.id] then
		self:checkNewVersion()
	end
end

HotfixRuntimeCheckController.instance = HotfixRuntimeCheckController.New()

return HotfixRuntimeCheckController
