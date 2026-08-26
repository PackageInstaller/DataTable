-- chunkname: @modules/logic/versionactivity2_4/pinball/view/PinballTalentViewContainer.lua

module("modules.logic.versionactivity2_4.pinball.view.PinballTalentViewContainer", package.seeall)

local PinballTalentViewContainer = class("PinballTalentViewContainer", BaseViewContainer)

function PinballTalentViewContainer:buildViews()
	return {
		PinballTalentView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function PinballTalentViewContainer:buildTabViews(tabContainerId)
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

return PinballTalentViewContainer
