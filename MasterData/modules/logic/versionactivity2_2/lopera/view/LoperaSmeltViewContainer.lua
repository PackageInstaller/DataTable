-- chunkname: @modules/logic/versionactivity2_2/lopera/view/LoperaSmeltViewContainer.lua

module("modules.logic.versionactivity2_2.lopera.view.LoperaSmeltViewContainer", package.seeall)

local LoperaSmeltViewContainer = class("LoperaSmeltViewContainer", BaseViewContainer)

function LoperaSmeltViewContainer:buildViews()
	return {
		LoperaSmeltView.New(),
		TabViewGroup.New(1, "#go_lefttop")
	}
end

function LoperaSmeltViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local navView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		navView:setCloseCheck(self.defaultOverrideCloseCheck, self)
		navView:setOverrideHome(self._overrideClickHome, self)

		return {
			navView
		}
	end
end

function LoperaSmeltViewContainer:defaultOverrideCloseCheck()
	self:closeThis()
end

function LoperaSmeltViewContainer:_overrideClickHome()
	LoperaController.instance:sendStatOnHomeClick()
	NavigateButtonsView.homeClick()
end

function LoperaSmeltViewContainer:setVisibleInternal(isVisible)
	LoperaSmeltViewContainer.super.setVisibleInternal(self, isVisible)
end

return LoperaSmeltViewContainer
