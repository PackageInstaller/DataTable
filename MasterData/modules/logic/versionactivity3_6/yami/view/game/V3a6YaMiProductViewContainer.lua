-- chunkname: @modules/logic/versionactivity3_6/yami/view/game/V3a6YaMiProductViewContainer.lua

module("modules.logic.versionactivity3_6.yami.view.game.V3a6YaMiProductViewContainer", package.seeall)

local V3a6YaMiProductViewContainer = class("V3a6YaMiProductViewContainer", BaseViewContainer)

function V3a6YaMiProductViewContainer:buildViews()
	local views = {}

	table.insert(views, V3a6YaMiProductView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function V3a6YaMiProductViewContainer:buildTabViews(tabContainerId)
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

function V3a6YaMiProductViewContainer:overrideCloseFunc()
	V3a6YaMiModel.instance:refreshSelectMaterials()
	self:closeThis()
end

return V3a6YaMiProductViewContainer
