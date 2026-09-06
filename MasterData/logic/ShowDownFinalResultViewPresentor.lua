-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownFinalResultViewPresentor.lua

module("logic.extensions.showdown.view.ShowDownFinalResultViewPresentor", package.seeall)

local ShowDownFinalResultViewPresentor = class("ShowDownFinalResultViewPresentor", ViewPresentor)

function ShowDownFinalResultViewPresentor:ctor()
	ShowDownFinalResultViewPresentor.super.ctor(self)
end

function ShowDownFinalResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShowDownFinalResultViewPresentor:dependWhatResources()
	return {
		"ui/views/showdown/showdownfinalresultview.prefab"
	}
end

function ShowDownFinalResultViewPresentor:buildViews()
	return {
		ShowDownFinalResultView.New()
	}
end

function ShowDownFinalResultViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ShowDownFinalResultViewPresentor
