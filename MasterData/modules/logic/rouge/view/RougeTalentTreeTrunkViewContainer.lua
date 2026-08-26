-- chunkname: @modules/logic/rouge/view/RougeTalentTreeTrunkViewContainer.lua

module("modules.logic.rouge.view.RougeTalentTreeTrunkViewContainer", package.seeall)

local RougeTalentTreeTrunkViewContainer = class("RougeTalentTreeTrunkViewContainer", BaseViewContainer)

function RougeTalentTreeTrunkViewContainer:buildViews()
	local views = {}

	table.insert(views, RougeTalentTreeTrunkView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function RougeTalentTreeTrunkViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigateView
		}
	end
end

return RougeTalentTreeTrunkViewContainer
