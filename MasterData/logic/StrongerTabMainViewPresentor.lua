-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tabframework/view/strongertabmainview/StrongerTabMainViewPresentor.lua

module("logic.extensions.tabframework.view.strongertabmainview.StrongerTabMainViewPresentor", package.seeall)

local StrongerTabMainViewPresentor = class("StrongerTabMainViewPresentor", ViewPresentor)

function StrongerTabMainViewPresentor:ctor()
	StrongerTabMainViewPresentor.super.ctor(self)
end

function StrongerTabMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function StrongerTabMainViewPresentor:dependWhatResources()
	return {
		"ui/views/tabframework/strongertabmainview.prefab"
	}
end

function StrongerTabMainViewPresentor:buildViews()
	return {
		StrongerTabMainView.New()
	}
end

return StrongerTabMainViewPresentor
