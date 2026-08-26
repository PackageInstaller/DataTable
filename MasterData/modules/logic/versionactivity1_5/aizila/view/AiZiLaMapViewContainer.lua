-- chunkname: @modules/logic/versionactivity1_5/aizila/view/AiZiLaMapViewContainer.lua

module("modules.logic.versionactivity1_5.aizila.view.AiZiLaMapViewContainer", package.seeall)

local AiZiLaMapViewContainer = class("AiZiLaMapViewContainer", BaseViewContainer)

function AiZiLaMapViewContainer:buildViews()
	local views = {}

	self._mapView = AiZiLaMapView.New()

	table.insert(views, self._mapView)
	table.insert(views, TabViewGroup.New(1, "#go_BackBtns"))

	return views
end

function AiZiLaMapViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

function AiZiLaMapViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		self._navigateButtonsView:setOverrideClose(self._overrideCloseFunc, self)

		return {
			self._navigateButtonsView
		}
	end
end

AiZiLaMapViewContainer.UI_COLSE_BLOCK_KEY = "AiZiLaMapViewContainer_COLSE_BLOCK_KEY"

function AiZiLaMapViewContainer:_overrideCloseFunc()
	AiZiLaHelper.startBlock(AiZiLaMapViewContainer.UI_COLSE_BLOCK_KEY)
	self._mapView:playViewAnimator(UIAnimationName.Close)
	TaskDispatcher.runDelay(self._onDelayCloseView, self, AiZiLaEnum.AnimatorTime.MapViewClose)
end

function AiZiLaMapViewContainer:_onDelayCloseView()
	AiZiLaHelper.endBlock(AiZiLaMapViewContainer.UI_COLSE_BLOCK_KEY)
	self:closeThis()
end

function AiZiLaMapViewContainer:onContainerInit()
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_5Enum.ActivityId.AiZiLa)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_5Enum.ActivityId.AiZiLa
	})
end

return AiZiLaMapViewContainer
