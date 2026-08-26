-- chunkname: @modules/logic/rouge/view/RougeTalentTreeViewContainer.lua

module("modules.logic.rouge.view.RougeTalentTreeViewContainer", package.seeall)

local RougeTalentTreeViewContainer = class("RougeTalentTreeViewContainer", BaseViewContainer)

function RougeTalentTreeViewContainer:buildViews()
	local views = {}

	self._treeview = RougeTalentTreeView.New()
	self._poolview = RougeTalentTreeBranchPool.New(self._viewSetting.otherRes.branchitem)
	self._tabview = TabViewGroup.New(2, "#go_talenttree")

	table.insert(views, TabViewGroup.New(1, "#go_topleft"))
	table.insert(views, self._tabview)
	table.insert(views, self._treeview)
	table.insert(views, self._poolview)

	return views
end

function RougeTalentTreeViewContainer:getPoolView()
	return self._poolview
end

function RougeTalentTreeViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		self._navigateButtonView:setCloseCheck(self.defaultOverrideCloseCheck, self)

		return {
			self._navigateButtonView
		}
	elseif tabContainerId == 2 then
		local views = {}
		local season = RougeConfig1.instance:season()
		local total = RougeTalentConfig.instance:getTalentNum(season)

		for i = 1, total do
			table.insert(views, RougeTalentTreeBranchView.New())
		end

		return views
	end
end

function RougeTalentTreeViewContainer:getTabView()
	return self._tabview
end

function RougeTalentTreeViewContainer:defaultOverrideCloseCheck()
	RougeController.instance:dispatchEvent(RougeEvent.exitTalentView)

	local closetime = 0.5

	function self._closeCallback()
		self._navigateButtonView:_reallyClose()
		RougeController.instance:dispatchEvent(RougeEvent.reallyExitTalentView)
	end

	TaskDispatcher.runDelay(self._closeCallback, self, closetime)
end

return RougeTalentTreeViewContainer
