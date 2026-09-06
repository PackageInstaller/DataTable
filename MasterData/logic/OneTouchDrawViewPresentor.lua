-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luoshiqiordeal/view/OneTouchDrawViewPresentor.lua

module("logic.extensions.luoshiqiordeal.view.OneTouchDrawViewPresentor", package.seeall)

local OneTouchDrawViewPresentor = class("OneTouchDrawViewPresentor", ViewPresentor)

function OneTouchDrawViewPresentor:ctor()
	OneTouchDrawViewPresentor.super.ctor(self)
end

function OneTouchDrawViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OneTouchDrawViewPresentor:dependWhatResources()
	return {
		"ui/views/luoshiqiordeal/onetouchdrawview.prefab"
	}
end

function OneTouchDrawViewPresentor:buildViews()
	return {
		OneTouchDrawView.New()
	}
end

return OneTouchDrawViewPresentor
