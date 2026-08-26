-- chunkname: @modules/logic/versionactivity3_4/lusijian/view/LuSiJianGameViewContainer.lua

module("modules.logic.versionactivity3_4.lusijian.view.LuSiJianGameViewContainer", package.seeall)

local LuSiJianGameViewContainer = class("LuSiJianGameViewContainer", BaseViewContainer)

function LuSiJianGameViewContainer:buildViews()
	local views = {}

	table.insert(views, LuSiJianGameView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function LuSiJianGameViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonsView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		self._navigateButtonsView:setOverrideClose(self._overrideCloseFunc, self)

		return {
			self._navigateButtonsView
		}
	end
end

function LuSiJianGameViewContainer:_overrideCloseFunc()
	LuSiJianStatHelper.instance:sendGameAbort()
	self:closeThis()
end

return LuSiJianGameViewContainer
