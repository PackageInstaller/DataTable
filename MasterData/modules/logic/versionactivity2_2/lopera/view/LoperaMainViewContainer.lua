-- chunkname: @modules/logic/versionactivity2_2/lopera/view/LoperaMainViewContainer.lua

module("modules.logic.versionactivity2_2.lopera.view.LoperaMainViewContainer", package.seeall)

local LoperaMainViewContainer = class("LoperaMainViewContainer", BaseViewContainer)
local closeAniDuration = 0.35

function LoperaMainViewContainer:buildViews()
	self._mainView = LoperaMainView.New()

	return {
		self._mainView,
		TabViewGroup.New(1, "#go_left")
	}
end

function LoperaMainViewContainer:buildTabViews(tabContainerId)
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

function LoperaMainViewContainer:onContainerInit()
	ActivityEnterMgr.instance:enterActivity(VersionActivity2_2Enum.ActivityId.Lopera)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity2_2Enum.ActivityId.Lopera
	})
end

function LoperaMainViewContainer:setVisibleInternal(isVisible)
	LoperaMainViewContainer.super.setVisibleInternal(self, isVisible)

	if not self.viewGO then
		return
	end

	self._anim = self._anim or self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if isVisible then
		self._anim:Play(UIAnimationName.Open, 0, 0)
		self._mainView:tryShowFinishUnlockView()
	end
end

function LoperaMainViewContainer:_overrideCloseFunc()
	self._anim = self._anim or self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	self._anim:Play(UIAnimationName.Close, 0, 0)
	TaskDispatcher.runDelay(self.closeThis, self, closeAniDuration)
end

function LoperaMainViewContainer:onContainerClose()
	TaskDispatcher.cancelTask(self.closeThis, self)
end

return LoperaMainViewContainer
