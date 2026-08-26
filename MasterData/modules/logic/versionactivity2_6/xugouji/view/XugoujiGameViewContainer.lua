-- chunkname: @modules/logic/versionactivity2_6/xugouji/view/XugoujiGameViewContainer.lua

module("modules.logic.versionactivity2_6.xugouji.view.XugoujiGameViewContainer", package.seeall)

local XugoujiGameViewContainer = class("XugoujiGameViewContainer", BaseViewContainer)
local closeAniDuration = 0.35

function XugoujiGameViewContainer:buildViews()
	return {
		XugoujiGameView.New(),
		XugoujiGamePlayerInfoView.New(),
		XugoujiGameEnemyInfoView.New(),
		TabViewGroup.New(1, "#go_lefttop")
	}
end

function XugoujiGameViewContainer:buildTabViews(tabContainerId)
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

function XugoujiGameViewContainer:_overrideCloseAction()
	local isDoingXugoujiGuide = Activity188Model.instance:isGameGuideMode()

	if isDoingXugoujiGuide then
		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.QuitPushBoxEpisode, MsgBoxEnum.BoxType.Yes_No, self._playAniAndClose, nil, nil, self)
end

function XugoujiGameViewContainer:_overrideClickHome()
	local isDoingXugoujiGuide = Activity188Model.instance:isGameGuideMode()

	if isDoingXugoujiGuide then
		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.QuitPushBoxEpisode, MsgBoxEnum.BoxType.Yes_No, self._playAniAndGoHome, nil, nil, self)
end

function XugoujiGameViewContainer:_playAniAndClose()
	if self._isClosing then
		return
	end

	self._anim = self._anim or self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	self._anim:Play("out", 0, 0)
	XugoujiController.instance:manualExitGame()

	self._isClosing = true

	TaskDispatcher.runDelay(self._closeAction, self, closeAniDuration)
end

function XugoujiGameViewContainer:_closeAction()
	XugoujiController.instance:manualExitGame()
	XugoujiController.instance:sendExitGameStat()
	self:closeThis()
end

function XugoujiGameViewContainer:_playAniAndGoHome()
	XugoujiController.instance:manualExitGame()
	XugoujiController.instance:sendExitGameStat()
	NavigateButtonsView.homeClick()
end

function XugoujiGameViewContainer:defaultOverrideCloseCheck(reallyClose, reallyCloseObj)
	local function yesFunc()
		reallyClose(reallyCloseObj)
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.QuitPushBoxEpisode, MsgBoxEnum.BoxType.Yes_No, yesFunc)

	return false
end

function XugoujiGameViewContainer:setVisibleInternal(isVisible)
	XugoujiGameViewContainer.super.setVisibleInternal(self, isVisible)
end

return XugoujiGameViewContainer
