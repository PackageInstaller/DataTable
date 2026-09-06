-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingway/view/HolyChallRankViewPresentor.lua

module("logic.extensions.kingway.view.HolyChallRankViewPresentor", package.seeall)

local HolyChallRankViewPresentor = class("HolyChallRankViewPresentor", ViewPresentor)

function HolyChallRankViewPresentor:ctor()
	HolyChallRankViewPresentor.super.ctor(self)
end

function HolyChallRankViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HolyChallRankViewPresentor:dependWhatResources()
	return {
		"ui/views/kingway/holychallrankview.prefab"
	}
end

function HolyChallRankViewPresentor:buildViews()
	return {
		HolyChallRankView.New()
	}
end

return HolyChallRankViewPresentor
