-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingway/view/HolyChallViewPresentor.lua

module("logic.extensions.kingway.view.HolyChallViewPresentor", package.seeall)

local HolyChallViewPresentor = class("HolyChallViewPresentor", ViewWithGuidePresentor)

function HolyChallViewPresentor:ctor()
	HolyChallViewPresentor.super.ctor(self)
end

function HolyChallViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HolyChallViewPresentor:dependWhatResources()
	return {
		"ui/views/kingway/holychallview.prefab"
	}
end

function HolyChallViewPresentor:buildViews()
	return {
		HolyChallView.New()
	}
end

return HolyChallViewPresentor
