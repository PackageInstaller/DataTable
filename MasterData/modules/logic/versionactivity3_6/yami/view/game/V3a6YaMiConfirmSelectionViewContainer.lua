-- chunkname: @modules/logic/versionactivity3_6/yami/view/game/V3a6YaMiConfirmSelectionViewContainer.lua

module("modules.logic.versionactivity3_6.yami.view.game.V3a6YaMiConfirmSelectionViewContainer", package.seeall)

local V3a6YaMiConfirmSelectionViewContainer = class("V3a6YaMiConfirmSelectionViewContainer", BaseViewContainer)

function V3a6YaMiConfirmSelectionViewContainer:buildViews()
	local views = {}

	table.insert(views, V3a6YaMiConfirmSelectionView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function V3a6YaMiConfirmSelectionViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		self.navigateView:setOverrideClose(self.overrideCloseFunc, self)

		return {
			self.navigateView
		}
	end
end

function V3a6YaMiConfirmSelectionViewContainer:overrideCloseFunc()
	self:closeThis()
end

return V3a6YaMiConfirmSelectionViewContainer
