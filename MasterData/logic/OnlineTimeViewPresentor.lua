-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/onlinetime/view/OnlineTimeViewPresentor.lua

module("logic.extensions.onlinetime.view.OnlineTimeViewPresentor", package.seeall)

local OnlineTimeViewPresentor = class("OnlineTimeViewPresentor", ViewPresentor)

function OnlineTimeViewPresentor:ctor()
	OnlineTimeViewPresentor.super.ctor(self)
end

function OnlineTimeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OnlineTimeViewPresentor:dependWhatResources()
	return {
		"ui/views/bonus/onlinetime.prefab"
	}
end

function OnlineTimeViewPresentor:buildViews()
	return {
		OnlineTimeView.New()
	}
end

return OnlineTimeViewPresentor
