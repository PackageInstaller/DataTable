-- chunkname: @modules/logic/versionactivity2_6/xugouji/view/XugoujiLevelViewContainer.lua

module("modules.logic.versionactivity2_6.xugouji.view.XugoujiLevelViewContainer", package.seeall)

local XugoujiLevelViewContainer = class("XugoujiLevelViewContainer", BaseViewContainer)
local closeAniDuration = 0.35

function XugoujiLevelViewContainer:buildViews()
	self._mainView = XugoujiLevelView.New()

	return {
		self._mainView,
		TabViewGroup.New(1, "#go_btns")
	}
end

function XugoujiLevelViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local navView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		navView:setOverrideClose(self._overrideCloseFunc, self)

		return {
			navView
		}
	end
end

function XugoujiLevelViewContainer:onContainerInit()
	ActivityEnterMgr.instance:enterActivity(VersionActivity2_6Enum.ActivityId.Xugouji)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity2_6Enum.ActivityId.Xugouji
	})
end

function XugoujiLevelViewContainer:setVisibleInternal(isVisible)
	XugoujiLevelViewContainer.super.setVisibleInternal(self, isVisible)

	if not self.viewGO then
		return
	end

	self._anim = self._anim or self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if isVisible then
		self._anim:Play(UIAnimationName.Open, 0, 0)
	end

	if isVisible then
		self._mainView:doEpisodeFinishedDisplay()
	end
end

function XugoujiLevelViewContainer:_overrideCloseFunc()
	self._anim = self._anim or self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	self._anim:Play(UIAnimationName.Close, 0, 0)
	TaskDispatcher.runDelay(self.closeThis, self, closeAniDuration)
end

function XugoujiLevelViewContainer:onContainerClose()
	TaskDispatcher.cancelTask(self.closeThis, self)
end

return XugoujiLevelViewContainer
