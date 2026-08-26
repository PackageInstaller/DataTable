-- chunkname: @modules/logic/versionactivity2_2/tianshinana/view/TianShiNaNaLevelViewContainer.lua

module("modules.logic.versionactivity2_2.tianshinana.view.TianShiNaNaLevelViewContainer", package.seeall)

local TianShiNaNaLevelViewContainer = class("TianShiNaNaLevelViewContainer", BaseViewContainer)

function TianShiNaNaLevelViewContainer:buildViews()
	self._mapViewScene = TianShiNaNaLevelScene.New()

	return {
		TianShiNaNaLevelView.New(),
		TianShiNaNaOperView.New(),
		self._mapViewScene,
		TabViewGroup.New(1, "#go_topleft")
	}
end

function TianShiNaNaLevelViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local navView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		navView:setOverrideClose(self.defaultOverrideCloseClick, self)

		return {
			navView
		}
	end
end

function TianShiNaNaLevelViewContainer:defaultOverrideCloseClick()
	if TianShiNaNaHelper.isBanOper() then
		return
	end

	MessageBoxController.instance:showMsgBox(MessageBoxIdDefine.Act167Abort, MsgBoxEnum.BoxType.Yes_No, self.closeThis, nil, nil, self)
end

function TianShiNaNaLevelViewContainer:setVisibleInternal(isVisible)
	if self._mapViewScene then
		self._mapViewScene:setSceneVisible(isVisible)
	end

	TianShiNaNaLevelViewContainer.super.setVisibleInternal(self, isVisible)
end

return TianShiNaNaLevelViewContainer
