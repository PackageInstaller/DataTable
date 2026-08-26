-- chunkname: @modules/logic/sp02/paomian/enter/view/Sp02_PaoMian_LiveView.lua

module("modules.logic.sp02.paomian.enter.view.Sp02_PaoMian_LiveView", package.seeall)

local Sp02_PaoMian_LiveView = class("Sp02_PaoMian_LiveView", BaseView)

function Sp02_PaoMian_LiveView:ctor(actViewMap)
	Sp02_PaoMian_LiveView.super.ctor(self, actViewMap)
	self:initViewParam(actViewMap)
end

function Sp02_PaoMian_LiveView:addEvents()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._updateActivity, self)
end

function Sp02_PaoMian_LiveView:removeEvents()
	return
end

function Sp02_PaoMian_LiveView:initViewParam(actViewMap)
	self._actId2ViewNameMap = actViewMap or {}
	self._viewName2ActIdMap = {}
	self._viewName2ActIdList = {}
	self._openActViewNameMap = {}

	for actId, viewNameList in pairs(self._actId2ViewNameMap) do
		for _, viewName in ipairs(viewNameList) do
			local actIdMap = self._viewName2ActIdMap[viewName]
			local actIdList = self._viewName2ActIdList[viewName]

			if not actIdList then
				actIdMap = {}
				actIdList = {}
				self._viewName2ActIdMap[viewName] = actIdMap
				self._viewName2ActIdList[viewName] = actIdList
			end

			if not actIdMap[actId] then
				actIdMap[actId] = true

				table.insert(actIdList, actId)
			end

			if not self._openActViewNameMap[viewName] and ViewMgr.instance:isOpen(viewName) then
				self._openActViewNameMap[viewName] = true
			end
		end
	end
end

function Sp02_PaoMian_LiveView:_onOpenView(viewName)
	if not self:_checkIsActView(viewName) then
		return
	end

	self._openActViewNameMap[viewName] = true
end

function Sp02_PaoMian_LiveView:_onCloseView(viewName)
	if not self:_checkIsActView(viewName) then
		return
	end

	self._openActViewNameMap[viewName] = nil
end

function Sp02_PaoMian_LiveView:_checkIsActView(viewName)
	if not viewName then
		return
	end

	if self._viewName2ActIdList then
		local actIdList = self._viewName2ActIdList[viewName]

		if actIdList then
			if not #actIdList then
				local actIdNum = 0

				return actIdNum > 0
			end
		end
	end
end

function Sp02_PaoMian_LiveView:_updateActivity()
	if not self._openActViewNameMap then
		return
	end

	for viewName, isOpen in pairs(self._openActViewNameMap) do
		if isOpen and self:checkIsViewActExpired(viewName) then
			ViewMgr.instance:closeView(ViewName.WebView)
			MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, self.yesCallback)

			break
		end
	end
end

function Sp02_PaoMian_LiveView:checkIsViewActExpired(viewName)
	if self._viewName2ActIdList then
		if not self._viewName2ActIdList then
			return
		end

		for _, actId in ipairs(self._viewName2ActIdList) do
			local status = ActivityHelper.getActivityStatus(actId)

			if status ~= ActivityEnum.ActivityStatus.Expired and status ~= ActivityEnum.ActivityStatus.NotOnLine then
				return
			end
		end

		return true
	end
end

function Sp02_PaoMian_LiveView.yesCallback()
	ActivityController.instance:dispatchEvent(ActivityEvent.CheckGuideOnEndActivity)
	NavigateButtonsView.homeClick()
end

function Sp02_PaoMian_LiveView:onClose()
	return
end

function Sp02_PaoMian_LiveView:onDestroyView()
	return
end

return Sp02_PaoMian_LiveView
