-- chunkname: @modules/logic/popup/controller/PopupController.lua

module("modules.logic.popup.controller.PopupController", package.seeall)

local PopupController = class("PopupController", BaseController)

function PopupController:onInit()
	self._popupList = PriorityQueue.New(function(v1, v2)
		return v1[1] > v2[1]
	end)
	self._locked = nil
	self._curPopup = nil
	self._addEvents = nil
	self._subPriorityDict = {}
	self._pauseDict = {}
end

function PopupController:reInit()
	self._popupHistory = {}
	self._popupList = PriorityQueue.New(function(v1, v2)
		return v1[1] > v2[1]
	end)
	self._locked = nil
	self._curPopup = nil
	self._addEvents = nil
	self._subPriorityDict = {}
	self._pauseDict = {}
end

function PopupController:clear()
	self:reInit()
end

function PopupController:onInitFinish()
	return
end

function PopupController:addConstEvents()
	return
end

function PopupController:_getSubPriority(priorityId)
	local minus = 1e-05

	self._subPriorityDict[priorityId] = (self._subPriorityDict[priorityId] or 0) - minus

	return priorityId + self._subPriorityDict[priorityId]
end

function PopupController:_resetSubPriority()
	self._subPriorityDict = {}
end

function PopupController:_onCloseViewFinish(viewName)
	if self._curPopup and viewName == self._curPopup[2] then
		self:_checkViewCloseGC(viewName)
		self:_endPopupView()
	end
end

function PopupController:addPopupView(priorityId, viewName, viewParam)
	local subPriority = self:_getSubPriority(priorityId)

	self._popupList:add({
		subPriority,
		viewName,
		viewParam
	})
	self:_tryShowView()
end

function PopupController:_tryShowView()
	if not self._locked then
		UIBlockMgr.instance:startBlock("PopupController")
		TaskDispatcher.cancelTask(self._showPopupView, self)
		TaskDispatcher.runDelay(self._showPopupView, self, 0.1)
	end

	if SLFramework.FrameworkSettings.IsEditor then
		ViewMgr.instance:closeView(ViewName.GMToolView)
	end
end

function PopupController:_showPopupView()
	UIBlockMgr.instance:endBlock("PopupController")

	if self:isPause() then
		return
	end

	if self._locked or self._popupList:getSize() == 0 then
		if self._popupList:getSize() == 0 then
			self:_resetSubPriority()
			self:dispatchEvent(PopupEvent.OnPopupFinish)
		end

		return
	end

	self._locked = true
	self._curPopup = self._popupList:getFirstAndRemove()

	local viewName, viewParam = self._curPopup[2], self._curPopup[3]

	if viewName == ViewName.MessageBoxView then
		if type(viewParam.extra) == "table" then
			GameFacade.showMessageBox(viewParam.messageBoxId, viewParam.msgBoxType, viewParam.yesCallback, viewParam.noCallback, viewParam.openCallback, viewParam.yesCallbackObj, viewParam.noCallbackObj, viewParam.openCallbackObj, unpack(viewParam.extra))
		else
			GameFacade.showMessageBox(viewParam.messageBoxId, viewParam.msgBoxType, viewParam.yesCallback, viewParam.noCallback, viewParam.openCallback, viewParam.yesCallbackObj, viewParam.noCallbackObj, viewParam.openCallbackObj)
		end
	else
		ViewMgr.instance:openView(viewName, viewParam)
	end

	if not self._addEvents then
		self._addEvents = true

		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	end
end

function PopupController:_endPopupView()
	self._locked = false

	if self._addEvents then
		self._addEvents = nil

		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	end

	self:_showPopupView()
end

function PopupController:_checkViewCloseGC(viewName)
	if self._popupHistory then
		if not #self._popupHistory then
			local len = 0

			if len >= 2 and viewName == self._popupHistory[len] then
				self._popupHistory = {}

				GameGCMgr.instance:dispatchEvent(GameGCEvent.DelayFullGC, 0.1, self)
			else
				self._popupHistory = self._popupHistory or {}

				table.insert(self._popupHistory, viewName)
			end
		end
	end
end

function PopupController:setPause(key, isPause)
	self._pauseDict[key] = isPause and true or nil

	if not self:isPause() then
		self:_tryShowView()
	end
end

function PopupController:isPause()
	for key, isPause in pairs(self._pauseDict) do
		if isPause then
			return true
		end
	end

	return false
end

function PopupController:getPopupCount()
	return (self._popupList:getSize())
end

function PopupController:havePopupView(viewName)
	if not self._popupList or self._popupList:getSize() <= 0 then
		return false
	end

	for i, v in ipairs(self._popupList._dataList) do
		if v[2] == viewName then
			return true
		end
	end

	return false
end

function PopupController:endPopupView()
	self._locked = false

	if self._addEvents then
		self._addEvents = nil

		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	end
end

function PopupController:showPopupView()
	self:_showPopupView()
end

PopupController.instance = PopupController.New()

return PopupController
