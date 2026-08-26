-- chunkname: @modules/logic/summon/view/limitationreplicationselfselect/SummonLimitationReplicationSelfSelectTabViewGroup.lua

module("modules.logic.summon.view.limitationreplicationselfselect.SummonLimitationReplicationSelfSelectTabViewGroup", package.seeall)

local SummonLimitationReplicationSelfSelectTabViewGroup = class("SummonLimitationReplicationSelfSelectTabViewGroup", TabViewGroup)

function SummonLimitationReplicationSelfSelectTabViewGroup:onOpen()
	self.viewContainer:registerCallback(ViewEvent.ToSwitchTab, self._toSwitchTab, self)
end

function SummonLimitationReplicationSelfSelectTabViewGroup:_toSwitchTab(tabContainerId, tabId)
	if tabContainerId == self._tabContainerId then
		self:_openTabView(tabId)
	end
end

function SummonLimitationReplicationSelfSelectTabViewGroup:_openTabView(tabId)
	self:_closeTabView()

	self._curTabId = tabId

	if self._tabAbLoaders[self._curTabId] then
		self:_setVisible(self._curTabId, true)
		self._tabViews[self._curTabId]:onOpenInternal()
	else
		local loader = MultiAbLoader.New()

		self._tabAbLoaders[self._curTabId] = loader

		local config = SummonConfig.instance:getSummonLimitReplicateConfig(tabId)

		self._tabViews[self._curTabId] = not string.nilorempty(config.class) and _G[config.class].New() or self:getDefaultClass()
		self._tabViews[self._curTabId].config = config

		if not string.nilorempty(config.res) then
			local curTabRes = {
				config.res
			}

			UIBlockMgr.instance:startBlock(self._UIBlockKey)
			loader:setPathList(curTabRes)
			loader:startLoad(self._finishCallback, self)
		else
			logError(string.format("TabView no res: tabContainerId_%d, tabId_%d", self._tabContainerId, self._curTabId))
		end
	end
end

function SummonLimitationReplicationSelfSelectTabViewGroup:getDefaultClass()
	return SummonLimitationReplicationSelfSelectSubBaseView.New()
end

return SummonLimitationReplicationSelfSelectTabViewGroup
