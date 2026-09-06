-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showoff/view/ShowoffrankViewPresentor.lua

module("logic.extensions.showoff.view.ShowoffrankViewPresentor", package.seeall)

local ShowoffrankViewPresentor = class("ShowoffrankViewPresentor", ViewPresentor)

function ShowoffrankViewPresentor:ctor()
	ShowoffrankViewPresentor.super.ctor(self)
end

function ShowoffrankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShowoffrankViewPresentor:dependWhatResources()
	return {
		"ui/views/showoff/showoffrankview.prefab"
	}
end

function ShowoffrankViewPresentor:buildViews()
	return {
		ShowoffrankView.New()
	}
end

function ShowoffrankViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ShowoffrankViewPresentor
