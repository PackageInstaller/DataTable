-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/groupregress/view/GroupRegressMainTabViewPresentor.lua

module("logic.extensions.groupregress.view.GroupRegressMainTabViewPresentor", package.seeall)

local GroupRegressMainTabViewPresentor = class("GroupRegressMainTabViewPresentor", ViewPresentor)

function GroupRegressMainTabViewPresentor:ctor()
	GroupRegressMainTabViewPresentor.super.ctor(self)
end

function GroupRegressMainTabViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GroupRegressMainTabViewPresentor:dependWhatResources()
	return {
		"ui/views/groupregress/groupregressmaintabview.prefab"
	}
end

function GroupRegressMainTabViewPresentor:buildViews()
	return {
		GroupRegressMainTabView.New()
	}
end

function GroupRegressMainTabViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return GroupRegressMainTabViewPresentor
