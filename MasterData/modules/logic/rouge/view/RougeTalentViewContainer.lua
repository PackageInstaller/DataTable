-- chunkname: @modules/logic/rouge/view/RougeTalentViewContainer.lua

module("modules.logic.rouge.view.RougeTalentViewContainer", package.seeall)

local RougeTalentViewContainer = class("RougeTalentViewContainer", BaseViewContainer)

function RougeTalentViewContainer:buildViews()
	local views = {}

	table.insert(views, RougeTalentView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function RougeTalentViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		self.navigateView:setHelpId(HelpEnum.HelpId.RougeTalentViewHelp)

		return {
			self.navigateView
		}
	end
end

return RougeTalentViewContainer
