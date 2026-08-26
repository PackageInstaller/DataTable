-- chunkname: @modules/logic/versionactivity2_8/molideer/view/MoLiDeErGameViewContainer.lua

module("modules.logic.versionactivity2_8.molideer.view.MoLiDeErGameViewContainer", package.seeall)

local MoLiDeErGameViewContainer = class("MoLiDeErGameViewContainer", BaseViewContainer)

function MoLiDeErGameViewContainer:buildViews()
	local views = {}

	table.insert(views, MoLiDeErGameView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function MoLiDeErGameViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		self.navigateView:setCloseCheck(self._overrideCloseFunc, self)

		return {
			self.navigateView
		}
	end
end

function MoLiDeErGameViewContainer:_overrideCloseFunc()
	MoLiDeErController.instance:statGameExit(StatEnum.MoLiDeErGameExitType.Exit)
	self:closeThis()
end

return MoLiDeErGameViewContainer
