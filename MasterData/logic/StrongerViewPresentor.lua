-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stronger/view/StrongerViewPresentor.lua

module("logic.extensions.stronger.view.StrongerViewPresentor", package.seeall)

local StrongerViewPresentor = class("StrongerViewPresentor", ViewPresentor)

function StrongerViewPresentor:ctor()
	StrongerViewPresentor.super.ctor(self)
end

function StrongerViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function StrongerViewPresentor:dependWhatResources()
	return {
		"ui/views/stronger/strongerview.prefab"
	}
end

function StrongerViewPresentor:buildViews()
	return {
		StrongerView.New()
	}
end

return StrongerViewPresentor
