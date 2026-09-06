-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementSparkStageViewPresentor.lua

module("logic.extensions.elementspark.view.ElementSparkStageViewPresentor", package.seeall)

local ElementSparkStageViewPresentor = class("ElementSparkStageViewPresentor", ViewPresentor)

function ElementSparkStageViewPresentor:ctor()
	ElementSparkStageViewPresentor.super.ctor(self)
end

function ElementSparkStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ElementSparkStageViewPresentor:dependWhatResources()
	return {
		"ui/views/elementspark/elementsparkstageview.prefab"
	}
end

function ElementSparkStageViewPresentor:buildViews()
	return {
		ElementSparkStageView.New()
	}
end

function ElementSparkStageViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ElementSparkStageViewPresentor
