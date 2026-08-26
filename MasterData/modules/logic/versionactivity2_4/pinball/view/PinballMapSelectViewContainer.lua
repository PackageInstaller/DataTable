-- chunkname: @modules/logic/versionactivity2_4/pinball/view/PinballMapSelectViewContainer.lua

module("modules.logic.versionactivity2_4.pinball.view.PinballMapSelectViewContainer", package.seeall)

local PinballMapSelectViewContainer = class("PinballMapSelectViewContainer", BaseViewContainer)

function PinballMapSelectViewContainer:buildViews()
	return {
		PinballMapSelectView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function PinballMapSelectViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local navView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			navView
		}
	end
end

return PinballMapSelectViewContainer
