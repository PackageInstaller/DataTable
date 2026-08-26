-- chunkname: @modules/logic/versionactivity2_4/warmup/view/V2a4_WarmUp_DialogueViewContainer.lua

module("modules.logic.versionactivity2_4.warmup.view.V2a4_WarmUp_DialogueViewContainer", package.seeall)

local V2a4_WarmUp_DialogueViewContainer = class("V2a4_WarmUp_DialogueViewContainer", Activity125ViewBaseContainer)
local kTabContainerId_NavigateButtonsView = 1

function V2a4_WarmUp_DialogueViewContainer:buildViews()
	return {
		V2a4_WarmUp_DialogueView.New(),
		TabViewGroup.New(kTabContainerId_NavigateButtonsView, "#go_topleft")
	}
end

function V2a4_WarmUp_DialogueViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == kTabContainerId_NavigateButtonsView then
		self._navigationView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		self._navigationView:setOverrideClose(self._overrideClose, self)

		return {
			self._navigationView
		}
	end
end

function V2a4_WarmUp_DialogueViewContainer:_overrideClose()
	GameFacade.showMessageBox(MessageBoxIdDefine.V2a4_WarmUp_DialogueView_AbortRequest, MsgBoxEnum.BoxType.Yes_No, self._endYesCallback, nil, nil, self, nil, nil)
end

function V2a4_WarmUp_DialogueViewContainer:_endYesCallback()
	V2a4_WarmUpController.instance:abort()
end

function V2a4_WarmUp_DialogueViewContainer:actId()
	return V2a4_WarmUpConfig.instance:actId()
end

function V2a4_WarmUp_DialogueViewContainer:onContainerClose()
	V2a4_WarmUpController.instance:uploadToServer()
end

return V2a4_WarmUp_DialogueViewContainer
