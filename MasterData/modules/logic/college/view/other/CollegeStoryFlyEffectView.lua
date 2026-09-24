-- chunkname: @modules/logic/college/view/other/CollegeStoryFlyEffectView.lua

module("modules.logic.college.view.other.CollegeStoryFlyEffectView", package.seeall)

local CollegeStoryFlyEffectView = class("CollegeStoryFlyEffectView", BaseView)

CollegeStoryFlyEffectView.StartPosition = Vector2.New(0, 0)

function CollegeStoryFlyEffectView:onInitView()
	self._goMilestoneEntry = gohelper.findChild(self.viewGO, "Left/Btns/#btn_progress/bg")
	self._tranMilestoneEntry = self._goMilestoneEntry.transform
	self._ignoreViewList = {
		ViewName.CollegeToastView,
		ViewName.CollegeCurrencyTipsView,
		ViewName.ToastView,
		ViewName.GMToolView,
		ViewName.GMToolView2,
		ViewName.MessageBoxView,
		ViewName.TopMessageBoxView,
		ViewName.GuideView,
		ViewName.GuideView2,
		ViewName.GuideStepEditor
	}
end

function CollegeStoryFlyEffectView:addEvents()
	self.addEventCb(self, CollegeController.instance, CollegeEvent.OnFlyStoryEffect, self._onFlyStoryEffect, self)
end

function CollegeStoryFlyEffectView:removeEvents()
	return
end

function CollegeStoryFlyEffectView:_onFlyStoryEffect(storyId)
	self._storyId = storyId

	TaskDispatcher.cancelTask(self._tryFlyStoryEffect, self)
	TaskDispatcher.runDelay(self._tryFlyStoryEffect, self, 0.3)
end

function CollegeStoryFlyEffectView:_tryFlyStoryEffect()
	if not self._storyId then
		return
	end

	local isTop = ViewHelper.instance:checkViewOnTheTop(self.viewName, self._ignoreViewList)

	if not isTop or not CollegeModel.instance:isViewVisible(self.viewName) then
		return
	end

	self:checkStoryFlyEffectInit()
	gohelper.setActive(self._goFlyEffect, true)

	self._flyEffectComp.startPosition = CollegeStoryFlyEffectView.StartPosition
	self._flyEffectComp.endPosition = recthelper.rectToRelativeAnchorPos(self._tranMilestoneEntry.position, self._tranFlyEffect)

	self._flyEffectComp:StartFlying()
end

function CollegeStoryFlyEffectView:checkStoryFlyEffectInit()
	if not self._flyEffectComp then
		self._goFlyEffect = self:getResInst(CollegeEnum.PrefabPath.FlyEffect, self.viewGO, "#go_FlyEffect")
		self._tranFlyEffect = self._goFlyEffect.transform
		self._flyEffectComp = gohelper.findChildComponent(self._goFlyEffect, "fly", typeof(UnityEngine.UI.UIFlying))
	end
end

function CollegeStoryFlyEffectView:onClose()
	TaskDispatcher.cancelTask(self._tryFlyStoryEffect, self)
end

return CollegeStoryFlyEffectView
