-- chunkname: @modules/logic/versionactivity2_8/act199/view/V2a8_SelfSelectCharacterFullViewContainer.lua

module("modules.logic.versionactivity2_8.act199.view.V2a8_SelfSelectCharacterFullViewContainer", package.seeall)

local V2a8_SelfSelectCharacterFullViewContainer = class("V2a8_SelfSelectCharacterFullViewContainer", BaseViewContainer)

function V2a8_SelfSelectCharacterFullViewContainer:buildViews()
	local views = {}

	table.insert(views, V2a8_SelfSelectCharacterFullView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function V2a8_SelfSelectCharacterFullViewContainer:buildTabViews(tabContainerId)
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

return V2a8_SelfSelectCharacterFullViewContainer
