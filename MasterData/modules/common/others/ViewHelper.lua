-- chunkname: @modules/common/others/ViewHelper.lua

module("modules.common.others.ViewHelper", package.seeall)

local ViewHelper = class("ViewHelper")

function ViewHelper:checkViewNameDictInit()
	if self.viewNameDict then
		return
	end

	self.viewNameDict = {}
end

function ViewHelper:OpenViewAndWaitViewClose(viewName, viewParam, closeViewCb, closeViewCbObj)
	self:checkViewNameDictInit()

	if self.viewNameDict[viewName] then
		logWarn(viewName .. "close callback override!")
	end

	self.viewNameDict[viewName] = {
		closeViewCb,
		closeViewCbObj
	}

	ViewMgr.instance:openView(viewName, viewParam)

	if not self.registerEvent then
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self.onViewClose, self)

		self.registerEvent = true
	end
end

function ViewHelper:onViewClose(viewName)
	if not self.viewNameDict[viewName] then
		return
	end

	local callback, callbackObj = self.viewNameDict[viewName][1], self.viewNameDict[viewName][2]

	self.viewNameDict[viewName] = nil

	if tabletool.len(self.viewNameDict) == 0 then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self.onViewClose, self)

		self.registerEvent = false
	end

	if callback then
		return callback(callbackObj)
	end
end

function ViewHelper:initGlobalIgnoreViewList()
	self.checkViewTopIgnoreViewList = self.checkViewTopIgnoreViewList or {
		ViewName.ToastView
	}

	return self.checkViewTopIgnoreViewList
end

function ViewHelper:checkIsGlobalIgnore(viewName)
	self:initGlobalIgnoreViewList()

	return tabletool.indexOf(self.checkViewTopIgnoreViewList, viewName)
end

function ViewHelper:checkViewOnTheTop(viewName, ignoreViewList)
	self:initGlobalIgnoreViewList()

	local openViewList = ViewMgr.instance:getOpenViewNameList()
	local openViewLen = #openViewList

	for i = openViewLen, 1, -1 do
		local openViewName = openViewList[i]

		if not tabletool.indexOf(self.checkViewTopIgnoreViewList, openViewName) then
			if not ignoreViewList then
				return openViewName == viewName
			end

			if not tabletool.indexOf(ignoreViewList, openViewName) then
				return openViewName == viewName
			end
		end
	end

	return false
end

function ViewHelper:checkAnyViewOnTheTop(viewNameList, ignoreViewList)
	if not viewNameList or #viewNameList == 0 then
		return false
	end

	local viewNameDict = {}
	local ignoreViewDict = {}
	local openViewList = ViewMgr.instance:getOpenViewNameList()

	for _, viewName in ipairs(viewNameList) do
		viewNameDict[viewName] = true
	end

	if ignoreViewList then
		for _, viewName in ipairs(ignoreViewList) do
			ignoreViewDict[viewName] = true
		end
	end

	for i = #openViewList, 1, -1 do
		local viewName = openViewList[i]
		local viewContainer = ViewMgr.instance:getContainer(viewName)

		if viewContainer and not self:checkIsGlobalIgnore(viewName) and not ignoreViewDict[viewName] and viewNameDict[viewName] then
			return true
		end
	end

	return false
end

ViewHelper.instance = ViewHelper.New()

return ViewHelper
