-- chunkname: @modules/logic/summon/view/SummonMainPreloadView.lua

module("modules.logic.summon.view.SummonMainPreloadView", package.seeall)

local SummonMainPreloadView = class("SummonMainPreloadView", TabViewGroup)

function SummonMainPreloadView:preloadTab(tabIdList)
	self._tabIdPreloadList = tabIdList
	self._tabAbPreloaders = {}
end

function SummonMainPreloadView:onOpen()
	if not self._tabIdPreloadList then
		return
	end

	self:addPreloadTab(self._tabIdPreloadList[1])
	SummonMainPreloadView.super.onOpen(self)
end

function SummonMainPreloadView:checkPreload()
	for _, tabId in ipairs(self._tabIdPreloadList) do
		self:addPreloadTab(tabId)
	end
end

function SummonMainPreloadView:addPreloadTab(tabId)
	if not self._tabAbLoaders[tabId] and not self._tabAbPreloaders[tabId] then
		local loader = MultiAbLoader.New()

		self._tabAbPreloaders[tabId] = loader

		local tabRes = self.viewContainer:getSetting().tabRes

		if tabRes then
			::label_4_0::

			local var_4_0 = tabRes[self._tabContainerId]

			if tabRes[self._tabContainerId] then
				local curTabRes = tabRes[self._tabContainerId][tabId]

				if curTabRes then
					loader:setPathList(curTabRes)
					loader:startLoad(self._onItemPreloaded, self)
				else
					logError(string.format("SummonMainPreloadView no res: tabContainerId_%d, tabId_%d", self._tabContainerId, tabId))
				end
			end
		end
	end
end

function SummonMainPreloadView:onDestroyView()
	for tabId, tabLoader in pairs(self._tabAbPreloaders) do
		if self._tabAbLoaders[tabId] ~= tabLoader then
			tabLoader:dispose()
		end
	end

	self._tabAbPreloaders = nil

	SummonMainPreloadView.super.onDestroyView(self)
end

function SummonMainPreloadView:_openTabView(tabId)
	if not self._tabAbLoaders[tabId] then
		local loader = self._tabAbPreloaders[tabId]

		if loader and not loader.isLoading then
			self:_closeTabView()

			self._curTabId = tabId
			self._tabAbLoaders[self._curTabId] = loader

			self:_finishCallback(loader)

			return
		end
	end

	SummonMainPreloadView.super._openTabView(self, tabId)
end

function SummonMainPreloadView:_onItemPreloaded(loader)
	return
end

return SummonMainPreloadView
