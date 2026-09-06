-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/view/GuideQilinViewPresentor.lua

module("logic.extensions.guide.view.GuideQilinViewPresentor", package.seeall)

local GuideQilinViewPresentor = class("GuideQilinViewPresentor", ViewPresentor)

function GuideQilinViewPresentor:ctor()
	GuideQilinViewPresentor.super.ctor(self)

	self.priority = ViewPriorityMgr.BonusViewPriority
end

function GuideQilinViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GuideQilinViewPresentor:dependWhatResources()
	return {
		"ui/views/guide/huangjinshenglongview.prefab"
	}
end

function GuideQilinViewPresentor:buildViews()
	return {
		GuideQilinView.New()
	}
end

function GuideQilinViewPresentor:_onViewShowByHigherPriority()
	GlobalModel.instance:visibleMainCamera(false)

	self._isHideByPriority = false
end

function GuideQilinViewPresentor:_onViewHideByLowerPriority()
	GlobalModel.instance:visibleMainCamera(true)

	self._isHideByPriority = true
end

function GuideQilinViewPresentor:_onEnterAnimationDone()
	GuideQilinViewPresentor.super._onEnterAnimationDone(self)

	if self._isHideByPriority == true then
		GlobalModel.instance:visibleMainCamera(true)
	end
end

function GuideQilinViewPresentor:onClickOutside()
	return
end

return GuideQilinViewPresentor
