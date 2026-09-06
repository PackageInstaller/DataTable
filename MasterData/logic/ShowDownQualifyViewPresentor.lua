-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownQualifyViewPresentor.lua

module("logic.extensions.showdown.view.ShowDownQualifyViewPresentor", package.seeall)

local ShowDownQualifyViewPresentor = class("ShowDownQualifyViewPresentor", ViewPresentor)

function ShowDownQualifyViewPresentor:ctor()
	ShowDownQualifyViewPresentor.super.ctor(self)
end

function ShowDownQualifyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShowDownQualifyViewPresentor:dependWhatResources()
	return {
		"ui/views/showdown/showdownqualifyview.prefab"
	}
end

function ShowDownQualifyViewPresentor:buildViews()
	return {
		ShowDownQualifyView.New()
	}
end

function ShowDownQualifyViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ShowDownQualifyViewPresentor
