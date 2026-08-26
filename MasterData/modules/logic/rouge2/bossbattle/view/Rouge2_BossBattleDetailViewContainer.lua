-- chunkname: @modules/logic/rouge2/bossbattle/view/Rouge2_BossBattleDetailViewContainer.lua

module("modules.logic.rouge2.bossbattle.view.Rouge2_BossBattleDetailViewContainer", package.seeall)

local Rouge2_BossBattleDetailViewContainer = class("Rouge2_BossBattleDetailViewContainer", BaseViewContainer)

function Rouge2_BossBattleDetailViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_BossBattleDetailView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Rouge2_BossBattleDetailViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self.navigateView
		}
	end
end

return Rouge2_BossBattleDetailViewContainer
