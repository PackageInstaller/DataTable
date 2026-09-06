-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownFinalViewPresentor.lua

module("logic.extensions.showdown.view.ShowDownFinalViewPresentor", package.seeall)

local ShowDownFinalViewPresentor = class("ShowDownFinalViewPresentor", ViewPresentor)

function ShowDownFinalViewPresentor:ctor()
	ShowDownFinalViewPresentor.super.ctor(self)
end

function ShowDownFinalViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShowDownFinalViewPresentor:dependWhatResources()
	return {
		"ui/views/showdown/showdownfinalview.prefab"
	}
end

function ShowDownFinalViewPresentor:buildViews()
	return {
		ShowDownFinalView.New()
	}
end

function ShowDownFinalViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ShowDownFinalViewPresentor
