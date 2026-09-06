-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownFunViewPresentor.lua

module("logic.extensions.showdown.view.ShowDownFunViewPresentor", package.seeall)

local ShowDownFunViewPresentor = class("ShowDownFunViewPresentor", ViewPresentor)

function ShowDownFunViewPresentor:ctor()
	ShowDownFunViewPresentor.super.ctor(self)
end

function ShowDownFunViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShowDownFunViewPresentor:dependWhatResources()
	return {
		"ui/views/showdown/showdownfunview.prefab"
	}
end

function ShowDownFunViewPresentor:buildViews()
	return {
		ShowDownFunView.New()
	}
end

function ShowDownFunViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ShowDownFunViewPresentor
