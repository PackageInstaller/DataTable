-- chunkname: @modules/logic/versionactivity3_7/travelgo/view/TravelGoViewContainer.lua

module("modules.logic.versionactivity3_7.travelgo.view.TravelGoViewContainer", package.seeall)

local TravelGoViewContainer = class("TravelGoViewContainer", BaseViewContainer)

function TravelGoViewContainer:buildViews()
	return {
		TravelGoView.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function TravelGoViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local helpId = self:getHelpId()

		self.navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			helpId ~= nil
		}, helpId)

		self.navigateButtonView:setOverrideClose(self._overrideCloseFunc, self)

		return {
			self.navigateButtonView
		}
	end
end

function TravelGoViewContainer:_overrideCloseFunc()
	GameFacade.showMessageBox(MessageBoxIdDefine.XRuiAnNongActConfirmQuit, MsgBoxEnum.BoxType.Yes_No, self._confirmExitGame, nil, nil, self)
end

function TravelGoViewContainer:_confirmExitGame()
	TravelGoStatHelper.instance:sendGameAbort()
	self:closeThis()
end

function TravelGoViewContainer:getHelpId()
	return HelpEnum.HelpId.V3a7XRuiAnYiTravelGoViewHelp
end

return TravelGoViewContainer
