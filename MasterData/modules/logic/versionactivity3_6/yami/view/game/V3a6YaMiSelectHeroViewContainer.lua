-- chunkname: @modules/logic/versionactivity3_6/yami/view/game/V3a6YaMiSelectHeroViewContainer.lua

module("modules.logic.versionactivity3_6.yami.view.game.V3a6YaMiSelectHeroViewContainer", package.seeall)

local V3a6YaMiSelectHeroViewContainer = class("V3a6YaMiSelectHeroViewContainer", BaseViewContainer)

function V3a6YaMiSelectHeroViewContainer:buildViews()
	local views = {}

	table.insert(views, V3a6YaMiSelectHeroView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function V3a6YaMiSelectHeroViewContainer:buildTabViews(tabContainerId)
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

function V3a6YaMiSelectHeroViewContainer:overrideCloseFunc()
	V3a6YaMiModel.instance:refreshSelectHeros()
	self:closeThis()
end

return V3a6YaMiSelectHeroViewContainer
