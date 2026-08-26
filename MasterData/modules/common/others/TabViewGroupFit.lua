-- chunkname: @modules/common/others/TabViewGroupFit.lua

module("modules.common.others.TabViewGroupFit", package.seeall)

local TabViewGroupFit = class("TabViewGroupFit", BaseView)

function TabViewGroupFit:ctor(tabContainerId, tabGOContainerPath)
	TabViewGroupFit.super.ctor(self)

	self._tabContainerId = tabContainerId or 1
	self._tabGOContainerPath = tabGOContainerPath
	self._tabGOContainer = nil
	self._tabAbLoaders = {}
	self._tabCanvasGroup = {}
	self._tabViews = nil
	self._curTabId = nil
	self._hasOpenFinish = false
	self._UIBlockKey = nil
end

function TabViewGroupFit:onInitView()
	self._UIBlockKey = self.viewName .. UIBlockKey.TabViewOpening .. self._tabContainerId
	self._tabGOContainer = self.viewGO

	if not string.nilorempty(self._tabGOContainerPath) then
		self._tabGOContainer = gohelper.findChild(self.viewGO, self._tabGOContainerPath)
	end

	if not self._tabGOContainer then
		logError(self.viewName .. " tabGOContainer not exist: " .. self._tabGOContainerPath)
	end

	self._tabViews = self.viewContainer:buildTabViews(self._tabContainerId)
	self._rawGetRes = self.viewContainer.getRes
	self._rawGetResInst = self.viewContainer.getResInst

	self:_setHook()
end

function TabViewGroupFit:onOpen()
	self.viewContainer:registerCallback(ViewEvent.ToSwitchTab, self._toSwitchTab, self)

	if self.viewParam and type(self.viewParam) == "table" and self.viewParam.defaultTabIds then
		if not self.viewParam.defaultTabIds[self._tabContainerId] then
			local defaultTabId = 1

			self:_openTabView(defaultTabId)
		end
	end
end

function TabViewGroupFit:onOpenFinish()
	for tabId, item in pairs(self._tabViews) do
		local tabLoader = self._tabAbLoaders[tabId]

		if tabLoader and tabLoader.isTabLoadFinished then
			item:onOpenFinishInternal()
		end
	end

	self._hasOpenFinish = true
end

function TabViewGroupFit:onUpdateParam()
	for tabId, item in pairs(self._tabViews) do
		local tabLoader = self._tabAbLoaders[tabId]

		if tabLoader and tabLoader.isTabLoadFinished then
			item:onUpdateParamInternal()
		end
	end
end

function TabViewGroupFit:onClose()
	self._hasOpenFinish = false

	self.viewContainer:unregisterCallback(ViewEvent.ToSwitchTab, self._toSwitchTab, self)

	for tabId, item in pairs(self._tabViews) do
		self:_closeTabView(tabId)
	end
end

function TabViewGroupFit:onCloseFinish()
	for tabId, item in pairs(self._tabViews) do
		local tabLoader = self._tabAbLoaders[tabId]

		if tabLoader and tabLoader.isTabLoadFinished then
			item:onCloseFinishInternal()
		end
	end

	self._curTabId = nil
end

function TabViewGroupFit:removeEvents()
	if self._tabViews then
		for tabId, item in pairs(self._tabViews) do
			local tabLoader = self._tabAbLoaders[tabId]

			if tabLoader and tabLoader.isTabLoadFinished then
				item:removeEventsInternal()
			end
		end
	end
end

function TabViewGroupFit:onDestroyView()
	self:_resetHook()

	if self._tabViews then
		for tabId, item in pairs(self._tabViews) do
			local tabLoader = self._tabAbLoaders[tabId]

			if tabLoader and tabLoader.isTabLoadFinished then
				item:onDestroyViewInternal()
				item:__onDispose()
			end
		end
	end

	for _, tabLoader in pairs(self._tabAbLoaders) do
		tabLoader:dispose()
	end

	self._tabAbLoaders = nil
	self._tabCanvasGroup = nil
	self._tabGOContainer = nil
	self._tabViews = nil
end

function TabViewGroupFit:getTabContainerId()
	return self._tabContainerId
end

function TabViewGroupFit:getCurTabId()
	return self._curTabId
end

function TabViewGroupFit:_toSwitchTab(tabContainerId, tabId)
	if tabContainerId == self._tabContainerId then
		self:_openTabView(tabId)
	end
end

function TabViewGroupFit:_openTabView(tabId)
	self:_switchCloseTabView(self._curTabId)

	self._curTabId = tabId

	ViewMgr.instance:dispatchEvent(ViewEvent.BeforeOpenTabView, {
		tabGroupView = self,
		viewName = self.viewName,
		tabView = self._tabViews[self._curTabId]
	})

	local tabLoader = self._tabAbLoaders[self._curTabId]

	if tabLoader then
		if not tabLoader.isTabLoadFinished then
			return
		end

		self:_setVisible(self._curTabId, true)

		local item = self._tabViews[self._curTabId]

		if item.onTabSwitchOpen then
			item:onTabSwitchOpen()
		end

		if self._tabOpenFinishCallback then
			self._tabOpenFinishCallback(self._tabOpenFinishCallbackObj, self._curTabId, item, false)
		end
	else
		local loader = MultiAbLoader.New()

		self._tabAbLoaders[self._curTabId] = loader

		local tabRes = self.viewContainer:getSetting().tabRes

		if tabRes then
			::label_13_0::

			local var_13_0 = tabRes[self._tabContainerId]

			if tabRes[self._tabContainerId] then
				local curTabRes = tabRes[self._tabContainerId][self._curTabId]

				if curTabRes then
					UIBlockMgr.instance:startBlock(self._UIBlockKey)
					loader:setPathList(curTabRes)
					loader:startLoad(self._finishCallback, self)
				else
					logError(string.format("TabView no res: tabContainerId_%d, tabId_%d", self._tabContainerId, self._curTabId))
				end
			end
		end
	end
end

function TabViewGroupFit:_switchCloseTabView(tabId)
	local curLoader = tabId and self._tabAbLoaders[tabId]

	if curLoader then
		if curLoader.isLoading then
			curLoader:dispose()

			self._tabAbLoaders[tabId] = nil

			UIBlockMgr.instance:endBlock(self._UIBlockKey)
		elseif curLoader.isTabLoadFinished then
			local item = self._tabViews[tabId]

			if item.onTabSwitchClose then
				item:onTabSwitchClose()
			end

			self:_setVisible(tabId, false)

			if self._tabCloseFinishCallback then
				self._tabCloseFinishCallback(self._tabCloseFinishCallbackObj, tabId, item)
			end
		end
	end
end

function TabViewGroupFit:_closeTabView(tabId)
	local curLoader = tabId and self._tabAbLoaders[tabId]

	if curLoader then
		if curLoader.isLoading then
			curLoader:dispose()

			self._tabAbLoaders[tabId] = nil

			UIBlockMgr.instance:endBlock(self._UIBlockKey)
		elseif curLoader.isTabLoadFinished then
			local tabView = self._tabViews[tabId]

			if tabView.onTabSwitchClose then
				tabView:onTabSwitchClose(true)
			end

			tabView:onCloseInternal()

			if self._keepCloseVisible then
				return
			end

			self:_setVisible(tabId, false)
		end
	end
end

function TabViewGroupFit:_setVisible(tabId, isVisible)
	if not self._tabCanvasGroup then
		return
	end

	local canvasGroup = self._tabCanvasGroup[tabId]

	if not canvasGroup then
		local viewGO = self._tabViews[tabId].viewGO

		canvasGroup = gohelper.onceAddComponent(viewGO, typeof(UnityEngine.CanvasGroup))
		self._tabCanvasGroup[tabId] = canvasGroup
	end

	if isVisible then
		canvasGroup.alpha = 1
		canvasGroup.interactable = true
		canvasGroup.blocksRaycasts = true
	else
		canvasGroup.alpha = 0
		canvasGroup.interactable = false
		canvasGroup.blocksRaycasts = false
	end
end

function TabViewGroupFit:setTabCloseFinishCallback(callback, callbackObj)
	self._tabCloseFinishCallback = callback
	self._tabCloseFinishCallbackObj = callbackObj
end

function TabViewGroupFit:setTabOpenFinishCallback(callback, callbackObj)
	self._tabOpenFinishCallback = callback
	self._tabOpenFinishCallbackObj = callbackObj
end

function TabViewGroupFit:setTabAlpha(tabId, value)
	if not self._tabCanvasGroup then
		return
	end

	local canvasGroup = self._tabCanvasGroup[tabId]

	if not canvasGroup then
		local viewGO = self._tabViews[tabId].viewGO

		if not viewGO then
			return
		end

		canvasGroup = gohelper.onceAddComponent(viewGO, typeof(UnityEngine.CanvasGroup))
		self._tabCanvasGroup[tabId] = canvasGroup
	end

	if canvasGroup then
		canvasGroup.alpha = value
	end
end

function TabViewGroupFit:keepCloseVisible(value)
	self._keepCloseVisible = value
end

function TabViewGroupFit:_setHook()
	function self.viewContainer.getRes(viewContainer, resPath)
		local value = self:_getRes(resPath)

		if value then
			return value
		end

		return self._rawGetRes(viewContainer, resPath)
	end

	function self.viewContainer.getResInst(viewContainer, resPath, parentGO, name)
		local value = self:_getResInst(resPath, parentGO, name)

		if value then
			return value
		end

		return self._rawGetResInst(viewContainer, resPath, parentGO, name)
	end
end

function TabViewGroupFit:_resetHook()
	self.viewContainer.getRes = self._rawGetRes
	self.viewContainer.getResInst = self._rawGetResInst
	self._rawGetRes = nil
	self._rawGetResInst = nil
end

function TabViewGroupFit:_getRes(resPath)
	for k, loader in pairs(self._tabAbLoaders) do
		if loader.isTabLoadFinished then
			local assetItem = loader:getAssetItem(resPath)

			if assetItem then
				return assetItem:GetResource(resPath)
			end
		end
	end

	return nil
end

function TabViewGroupFit:_getResInst(resPath, parentGO, name)
	for k, loader in pairs(self._tabAbLoaders) do
		if loader.isTabLoadFinished then
			local assetItem = loader:getAssetItem(resPath)

			if assetItem then
				local prefab = assetItem:GetResource(resPath)

				if prefab then
					return gohelper.clone(prefab, parentGO, name)
				end
			end
		end
	end
end

function TabViewGroupFit:_finishCallback(loader)
	UIBlockMgr.instance:endBlock(self._UIBlockKey)

	local firstAssetItem = loader:getFirstAssetItem()
	local tabPrefab = firstAssetItem:GetResource()
	local viewGO = gohelper.clone(tabPrefab, self._tabGOContainer)
	local tabView = self._tabViews[self._curTabId]

	if tabView then
		loader.isTabLoadFinished = true

		tabView:__onInit()

		tabView.rootGO = self.viewGO
		tabView.viewGO = viewGO
		tabView.tabContainer = self
		tabView.viewContainer = self.viewContainer
		tabView.viewName = self.viewName
		tabView.viewParam = self.viewParam

		self:_setVisible(self._curTabId, true)
		tabView:onInitViewInternal()
		tabView:addEventsInternal()
		tabView:onOpenInternal()

		if tabView.onTabSwitchOpen then
			tabView:onTabSwitchOpen()
		end

		if self._hasOpenFinish then
			tabView:onOpenFinishInternal()
		end

		if self._tabOpenFinishCallback then
			self._tabOpenFinishCallback(self._tabOpenFinishCallbackObj, self._curTabId, tabView, true)
		end
	else
		logError(string.format("TabView not exist: tabContainerId_%d, tabId_%d", self._tabContainerId, self._curTabId))
	end
end

function TabViewGroupFit:_hasLoaded(tabId)
	if self._tabAbLoaders then
		return self._tabAbLoaders and self._tabAbLoaders.isTabLoadFinished
	end
end

return TabViewGroupFit
