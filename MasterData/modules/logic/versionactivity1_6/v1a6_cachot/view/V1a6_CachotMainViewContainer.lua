-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotMainViewContainer.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotMainViewContainer", package.seeall)

local V1a6_CachotMainViewContainer = class("V1a6_CachotMainViewContainer", BaseViewContainer)

function V1a6_CachotMainViewContainer:buildViews()
	self._guideDragTip = V1a6_CachotGuideDragTip.New()

	return {
		V1a6_CachotMainView.New(),
		V1a6_CachotPlayCtrlView.New(),
		self._guideDragTip,
		TabViewGroup.New(1, "#go_topleft")
	}
end

function V1a6_CachotMainViewContainer:buildTabViews(tabContainerId)
	local navView = NavigateButtonsView.New({
		true,
		true,
		false
	})

	navView:setOverrideClose(self._onCloseClick, self)
	navView:setOverrideHome(self._onHomeClick, self)
	navView:setCloseCheck(self._navCloseCheck, self)

	return {
		navView
	}
end

function V1a6_CachotMainViewContainer:_navCloseCheck()
	if self._guideDragTip then
		local showDragTip = self._guideDragTip:isShowDragTip()

		return not self._guideDragTip
	end
end

function V1a6_CachotMainViewContainer:_onCloseClick()
	MainController.instance:enterMainScene()
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_6EnterView)
		VersionActivity1_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, V1a6_CachotEnum.ActivityId)
	end)
end

function V1a6_CachotMainViewContainer:_onHomeClick()
	MainController.instance:enterMainScene()
end

return V1a6_CachotMainViewContainer
