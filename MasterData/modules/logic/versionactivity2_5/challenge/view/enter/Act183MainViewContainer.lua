-- chunkname: @modules/logic/versionactivity2_5/challenge/view/enter/Act183MainViewContainer.lua

module("modules.logic.versionactivity2_5.challenge.view.enter.Act183MainViewContainer", package.seeall)

local Act183MainViewContainer = class("Act183MainViewContainer", BaseViewContainer)

function Act183MainViewContainer:buildViews()
	local views = {}

	table.insert(views, Act183MainView.New())
	table.insert(views, TabViewGroup.New(1, "root/#go_topleft"))
	table.insert(views, TabViewGroup.New(2, "root/left/#go_store"))

	local helpView = HelpShowView.New()

	helpView:setHelpId(HelpEnum.HelpId.Act183EnterMain)
	table.insert(views, helpView)

	return views
end

function Act183MainViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.Act183EnterMain)

		return {
			self.navigateView
		}
	elseif tabContainerId == 2 then
		return {
			Act183StoreEntry.New()
		}
	end
end

return Act183MainViewContainer
