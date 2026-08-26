-- chunkname: @modules/logic/store/controller/StoreTabViewGroup.lua

module("modules.logic.store.controller.StoreTabViewGroup", package.seeall)

local StoreTabViewGroup = class("StoreTabViewGroup", TabViewGroup)

function StoreTabViewGroup:onOpen()
	self.viewContainer:registerCallback(ViewEvent.ToSwitchTab, self._toSwitchTab, self)

	if self.viewParam and type(self.viewParam) == "table" and self.viewParam.defaultTabIds then
		if not self.viewParam.defaultTabIds[self._tabContainerId] then
			local defaultTabId = 1

			self:_openTabView(defaultTabId)
		end
	end
end

function StoreTabViewGroup:_toSwitchTab(tabContainerId, tabId)
	if tabContainerId == self._tabContainerId then
		self:_openTabView(tabId)
	end
end

function StoreTabViewGroup:_openTabView(tabId)
	self:_closeTabView()

	self._curTabId = tabId

	if self._tabAbLoaders[self._curTabId] then
		self:_setVisible(self._curTabId, true)
		self._tabViews[self._curTabId]:onOpenInternal()
	else
		local loader = MultiAbLoader.New()

		self._tabAbLoaders[self._curTabId] = loader

		local tabRes = self.viewContainer:getSetting().tabRes

		for _, config in pairs(lua_store_recommend.configDict) do
			if config.isCustomLoad == 1 and config.prefab == self._curTabId then
				tabRes[self._tabContainerId][config.prefab] = {
					string.format("ui/viewres/%s.prefab", config.res)
				}
				self._tabViews[self._curTabId] = _G[config.className].New()
				self._tabViews[self._curTabId].config = config
			end
		end

		if tabRes then
			::label_3_0::

			local var_3_0 = tabRes[self._tabContainerId]

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

return StoreTabViewGroup
