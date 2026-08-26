-- chunkname: @modules/logic/versionactivity1_5/act142/view/Activity142MapViewContainer.lua

module("modules.logic.versionactivity1_5.act142.view.Activity142MapViewContainer", package.seeall)

local Activity142MapViewContainer = class("Activity142MapViewContainer", BaseViewContainer)

function Activity142MapViewContainer:buildViews()
	local views = {}

	self._mapView = Activity142MapView.New()
	views[#views + 1] = self._mapView
	views[#views + 1] = TabViewGroup.New(1, "#go_BackBtns")

	return views
end

function Activity142MapViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		navigateButtonsView:setOverrideClose(self._overrideCloseFunc, self)

		return {
			navigateButtonsView
		}
	end
end

function Activity142MapViewContainer:_overrideCloseFunc()
	self._mapView:playViewAnimation(UIAnimationName.Close)
	AudioMgr.instance:trigger(AudioEnum.ui_activity142.CloseMapView)
	TaskDispatcher.runDelay(self._onDelayCloseView, self, Activity142Enum.CLOSE_MAP_VIEW_TIME)
end

function Activity142MapViewContainer:_onDelayCloseView()
	self:closeThis()
end

function Activity142MapViewContainer:onContainerInit()
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_5Enum.ActivityId.Activity142)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_5Enum.ActivityId.Activity142
	})
end

function Activity142MapViewContainer:_setVisible(isVisible)
	BaseViewContainer._setVisible(self, isVisible)

	if not self._mapView then
		return
	end

	self._mapView:onSetVisible(isVisible)

	if isVisible then
		self._mapView:playViewAnimation(UIAnimationName.Open)
	end
end

return Activity142MapViewContainer
