-- chunkname: @modules/logic/pushbox/view/PushBoxViewContainer.lua

module("modules.logic.pushbox.view.PushBoxViewContainer", package.seeall)

local PushBoxViewContainer = class("PushBoxViewContainer", BaseViewContainer)

function PushBoxViewContainer:buildViews()
	return {
		TabViewGroup.New(1, "#go_btns"),
		PushBoxView.New()
	}
end

function PushBoxViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self._navigateButtonView
		}
	end
end

return PushBoxViewContainer
