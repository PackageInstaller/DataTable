-- chunkname: @modules/logic/help/view/HelpViewContainer.lua

module("modules.logic.help.view.HelpViewContainer", package.seeall)

local HelpViewContainer = class("HelpViewContainer", BaseViewContainer)

function HelpViewContainer:buildViews()
	return {
		HelpView.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function HelpViewContainer:buildTabViews(tabContainerId)
	self._navigateButtonsView = NavigateButtonsView.New({
		false,
		false,
		false
	})

	return {
		self._navigateButtonsView
	}
end

function HelpViewContainer:setBtnShow(isShow)
	if self._navigateButtonsView then
		self._navigateButtonsView:setParam({
			isShow,
			false,
			false
		})
	end
end

return HelpViewContainer
