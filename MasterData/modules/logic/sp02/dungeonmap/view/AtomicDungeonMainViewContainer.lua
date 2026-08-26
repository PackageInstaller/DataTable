-- chunkname: @modules/logic/sp02/dungeonmap/view/AtomicDungeonMainViewContainer.lua

module("modules.logic.sp02.dungeonmap.view.AtomicDungeonMainViewContainer", package.seeall)

local AtomicDungeonMainViewContainer = class("AtomicDungeonMainViewContainer", BaseViewContainer)

function AtomicDungeonMainViewContainer:buildViews()
	self.atomicDungeonSceneView = AtomicDungeonSceneView.New()
	self.atomicDungeonSceneElements = AtomicDungeonSceneElements.New()
	self.atomicDungeonMapSelectView = AtomicDungeonMapSelectView.New()
	self.atomicDungeonMainView = AtomicDungeonMainView.New()
	self.atomicDungeonTipToastView = AtomicDungeonTipToastView.New()
	self.atomicDungeonRewardToastView = AtomicDungeonRewardToastView.New()
	self.atomicDungeonDataBaseToastView = AtomicDungeonDataBaseToastView.New()

	return {
		self.atomicDungeonSceneView,
		self.atomicDungeonSceneElements,
		self.atomicDungeonMapSelectView,
		self.atomicDungeonMainView,
		self.atomicDungeonTipToastView,
		self.atomicDungeonRewardToastView,
		self.atomicDungeonDataBaseToastView,
		TabViewGroup.New(1, "root/#go_topleft")
	}
end

function AtomicDungeonMainViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.AtomicDungeonMain, nil, self._homeCallback, nil, self)

		return {
			self.navigateView
		}
	end
end

function AtomicDungeonMainViewContainer:setOverrideCloseClick(overrideCloseFunc, overrideCloseObj)
	self.navigateView:setOverrideClose(overrideCloseFunc, overrideCloseObj)
end

function AtomicDungeonMainViewContainer:_homeCallback()
	AtomicDungeonStatHelper.instance:sendDungeonResultInfo("主动返回")
end

function AtomicDungeonMainViewContainer:getDungeonSceneView()
	return self.atomicDungeonSceneView
end

function AtomicDungeonMainViewContainer:getDungeonSceneElementsView()
	return self.atomicDungeonSceneElements
end

function AtomicDungeonMainViewContainer:getDungeonMainView()
	return self.atomicDungeonMainView
end

function AtomicDungeonMainViewContainer:getDungeonMapSelectView()
	return self.atomicDungeonMapSelectView
end

function AtomicDungeonMainViewContainer:getNavigateButtonsView()
	return self.navigateView
end

function AtomicDungeonMainViewContainer:setVisibleInternal(isVisible)
	AtomicDungeonMainViewContainer.super.setVisibleInternal(self, isVisible)

	if self.atomicDungeonSceneView then
		self.atomicDungeonSceneView:setSceneVisible(isVisible)
	end
end

return AtomicDungeonMainViewContainer
