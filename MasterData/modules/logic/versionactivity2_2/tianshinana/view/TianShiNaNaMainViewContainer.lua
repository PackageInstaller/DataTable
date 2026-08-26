-- chunkname: @modules/logic/versionactivity2_2/tianshinana/view/TianShiNaNaMainViewContainer.lua

module("modules.logic.versionactivity2_2.tianshinana.view.TianShiNaNaMainViewContainer", package.seeall)

local TianShiNaNaMainViewContainer = class("TianShiNaNaMainViewContainer", BaseViewContainer)

function TianShiNaNaMainViewContainer:buildViews()
	self._mapViewScene = TianShiNaNaMainScene.New()

	return {
		self._mapViewScene,
		TianShiNaNaMainView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function TianShiNaNaMainViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local navView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			navView
		}
	end
end

function TianShiNaNaMainViewContainer:onContainerInit()
	ActivityEnterMgr.instance:enterActivity(VersionActivity2_2Enum.ActivityId.TianShiNaNa)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity2_2Enum.ActivityId.TianShiNaNa
	})
end

function TianShiNaNaMainViewContainer:setVisibleInternal(isVisible)
	self._mapViewScene:setSceneVisible(isVisible)
	TianShiNaNaMainViewContainer.super.setVisibleInternal(self, isVisible)
end

return TianShiNaNaMainViewContainer
