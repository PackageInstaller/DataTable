-- chunkname: @modules/logic/sp01/assassinChase/view/AssassinChaseGameViewContainer.lua

module("modules.logic.sp01.assassinChase.view.AssassinChaseGameViewContainer", package.seeall)

local AssassinChaseGameViewContainer = class("AssassinChaseGameViewContainer", BaseViewContainer)

function AssassinChaseGameViewContainer:buildViews()
	local views = {}

	table.insert(views, AssassinChaseGameView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function AssassinChaseGameViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		self.navigateView:setOverrideClose(self.overrideClose, self)

		return {
			self.navigateView
		}
	end
end

function AssassinChaseGameViewContainer:overrideClose()
	local view = self._views[1]

	if view.state == AssassinChaseEnum.ViewState.Select and view.infoMo:isSelect() then
		view:refreshUI()

		return
	end

	self:closeThis()
end

return AssassinChaseGameViewContainer
