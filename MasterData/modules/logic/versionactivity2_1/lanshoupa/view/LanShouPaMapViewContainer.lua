-- chunkname: @modules/logic/versionactivity2_1/lanshoupa/view/LanShouPaMapViewContainer.lua

module("modules.logic.versionactivity2_1.lanshoupa.view.LanShouPaMapViewContainer", package.seeall)

local LanShouPaMapViewContainer = class("LanShouPaMapViewContainer", BaseViewContainer)

function LanShouPaMapViewContainer:buildViews()
	local views = {}

	self._mapViewScene = LanShouPaMapScene.New()

	table.insert(views, self._mapViewScene)
	table.insert(views, LanShouPaMapView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function LanShouPaMapViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

function LanShouPaMapViewContainer:buildTabViews(tabContainerId)
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

function LanShouPaMapViewContainer:onContainerInit()
	ActivityEnterMgr.instance:enterActivity(VersionActivity2_1Enum.ActivityId.LanShouPa)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity2_1Enum.ActivityId.LanShouPa
	})
end

function LanShouPaMapViewContainer:setVisibleInternal(isVisible)
	self._mapViewScene:setSceneVisible(isVisible)
	LanShouPaMapViewContainer.super.setVisibleInternal(self, isVisible)
end

return LanShouPaMapViewContainer
