-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownFormationExViewPresentor.lua

module("logic.extensions.showdown.view.dream.ShowDownFormationExViewPresentor", package.seeall)

local ShowDownFormationExViewPresentor = class("ShowDownFormationExViewPresentor", ViewPresentor)

function ShowDownFormationExViewPresentor:ctor()
	ShowDownFormationExViewPresentor.super.ctor(self)
end

function ShowDownFormationExViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShowDownFormationExViewPresentor:dependWhatResources()
	return {
		"ui/views/showdown/showdownformationexview.prefab"
	}
end

function ShowDownFormationExViewPresentor:buildViews()
	return {
		ShowDownFormationExView.New()
	}
end

function ShowDownFormationExViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ShowDownFormationExViewPresentor
