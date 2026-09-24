-- chunkname: @modules/logic/college/view/other/CollegeMainViewContainer.lua

module("modules.logic.college.view.other.CollegeMainViewContainer", package.seeall)

local CollegeMainViewContainer = class("CollegeMainViewContainer", BaseViewContainer)

function CollegeMainViewContainer:buildViews()
	self._sceneView = CollegeSceneView.New()

	return {
		CollegeStatIdleTimeView.New(CollegeStatEnum.ViewName.Main),
		CollegeMainView.New(),
		self._sceneView,
		CollegeVisibleBaseView.New(),
		CollegeTaskTipsView.New(),
		CollegeBuildingBubbleView.New(),
		CollegeSceneBubbleView.New(),
		CollegeCurrencyView.New("#go_righttop"),
		CollegeChessMoveRouteView.New(),
		CollegeStoryFlyEffectView.New(),
		TabViewGroup.New(1, "#go_lefttop")
	}
end

function CollegeMainViewContainer:getSceneView()
	return self._sceneView
end

function CollegeMainViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigationView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		self.navigationView:setOverrideClose(self.defaultOverrideCloseClick, self)

		return {
			self.navigationView
		}
	end
end

function CollegeMainViewContainer:playOpenTransition()
	self:onPlayOpenTransitionFinish()
end

function CollegeMainViewContainer:setCloseFunc(callback, callobj)
	self.closeClickCallback = callback
	self.closeClickCallbackObj = callobj
end

function CollegeMainViewContainer:defaultOverrideCloseClick()
	if self.closeClickCallback then
		self.closeClickCallback(self.closeClickCallbackObj)

		return
	end

	if CollegeModel.instance.curSceneType == CollegeEnum.SceneType.Map then
		CollegeController.instance:dispatchEvent(CollegeEvent.ChangeSceneType, CollegeEnum.SceneType.City)

		return
	end

	self:closeThis()
end

function CollegeMainViewContainer:setVisibleInternal(...)
	CollegeMainViewContainer.super.setVisibleInternal(self, ...)
	CollegeController.instance:dispatchEvent(CollegeEvent.MainViewVisibleChange)
end

function CollegeMainViewContainer:playCloseTransition()
	self:onPlayCloseTransitionFinish()
end

return CollegeMainViewContainer
