-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/monthcard/view/WholelifecardViewPresentor.lua

module("logic.extensions.monthcard.view.WholelifecardViewPresentor", package.seeall)

local WholelifecardViewPresentor = class("WholelifecardViewPresentor", ViewPresentor)

function WholelifecardViewPresentor:ctor()
	WholelifecardViewPresentor.super.ctor(self)
end

function WholelifecardViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WholelifecardViewPresentor:dependWhatResources()
	return {
		"ui/views/monthcard/wholelifecardview.prefab"
	}
end

function WholelifecardViewPresentor:buildViews()
	return {
		WholelifecardView.New()
	}
end

function WholelifecardViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return WholelifecardViewPresentor
