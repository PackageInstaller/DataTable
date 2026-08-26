-- chunkname: @modules/logic/versionactivity3_7/selfselect/view/V3a7SelfSelectPickViewContainer.lua

module("modules.logic.versionactivity3_7.selfselect.view.V3a7SelfSelectPickViewContainer", package.seeall)

local V3a7SelfSelectPickViewContainer = class("V3a7SelfSelectPickViewContainer", BaseViewContainer)

function V3a7SelfSelectPickViewContainer:buildViews()
	local views = {}

	table.insert(views, V3a7SelfSelectPickView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function V3a7SelfSelectPickViewContainer:buildTabViews(tabContainerId)
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

return V3a7SelfSelectPickViewContainer
