-- chunkname: @modules/logic/versionactivity2_2/lopera/view/LoperaLevelViewContainer.lua

module("modules.logic.versionactivity2_2.lopera.view.LoperaLevelViewContainer", package.seeall)

local LoperaLevelViewContainer = class("LoperaLevelViewContainer", BaseViewContainer)
local closeAniDuration = 0.35

function LoperaLevelViewContainer:buildViews()
	return {
		LoperaLevelView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function LoperaLevelViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local navView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		navView:setOverrideClose(self._overrideCloseAction, self)
		navView:setOverrideHome(self._overrideClickHome, self)

		return {
			navView
		}
	end
end

function LoperaLevelViewContainer:_overrideCloseAction()
	GameFacade.showMessageBox(MessageBoxIdDefine.QuitPushBoxEpisode, MsgBoxEnum.BoxType.Yes_No, self._playAniAndClose, nil, nil, self)
end

function LoperaLevelViewContainer:_overrideClickHome()
	LoperaController.instance:sendStatOnHomeClick()
	NavigateButtonsView.homeClick()
end

function LoperaLevelViewContainer:_playAniAndClose()
	self._anim = self._anim or self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	self._anim:Play("out", 0, 0)
	LoperaController.instance:abortEpisode()
	TaskDispatcher.runDelay(self.closeThis, self, closeAniDuration)
end

function LoperaLevelViewContainer:defaultOverrideCloseCheck(reallyClose, reallyCloseObj)
	local function yesFunc()
		LoperaController.instance:abortEpisode()
		reallyClose(reallyCloseObj)
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.QuitPushBoxEpisode, MsgBoxEnum.BoxType.Yes_No, yesFunc)

	return false
end

function LoperaLevelViewContainer:setVisibleInternal(isVisible)
	LoperaLevelViewContainer.super.setVisibleInternal(self, isVisible)
end

return LoperaLevelViewContainer
