-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stronger/view/StrongerTabViewPresentor.lua

module("logic.extensions.stronger.view.StrongerTabViewPresentor", package.seeall)

local StrongerTabViewPresentor = class("StrongerTabViewPresentor", ViewPresentor)

function StrongerTabViewPresentor:ctor()
	StrongerTabViewPresentor.super.ctor(self)
end

function StrongerTabViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function StrongerTabViewPresentor:dependWhatResources()
	return {
		"ui/views/stronger/strongertabview.prefab"
	}
end

function StrongerTabViewPresentor:buildViews()
	return {
		StrongerTabView.New()
	}
end

function StrongerTabViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return StrongerTabViewPresentor
