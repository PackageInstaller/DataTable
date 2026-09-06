-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownEliminateViewPresentor.lua

module("logic.extensions.showdown.view.ShowDownEliminateViewPresentor", package.seeall)

local ShowDownEliminateViewPresentor = class("ShowDownEliminateViewPresentor", ViewPresentor)

function ShowDownEliminateViewPresentor:ctor()
	ShowDownEliminateViewPresentor.super.ctor(self)
end

function ShowDownEliminateViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShowDownEliminateViewPresentor:dependWhatResources()
	return {
		"ui/views/showdown/showdowneliminateview.prefab"
	}
end

function ShowDownEliminateViewPresentor:buildViews()
	return {
		ShowDownEliminateView.New()
	}
end

function ShowDownEliminateViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ShowDownEliminateViewPresentor
