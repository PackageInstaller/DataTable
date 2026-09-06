-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/villaintrial/view/VillaintrialRankViewPresentor.lua

module("logic.extensions.villaintrial.view.VillaintrialRankViewPresentor", package.seeall)

local VillaintrialRankViewPresentor = class("VillaintrialRankViewPresentor", ViewPresentor)

function VillaintrialRankViewPresentor:ctor()
	VillaintrialRankViewPresentor.super.ctor(self)
end

function VillaintrialRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function VillaintrialRankViewPresentor:dependWhatResources()
	return {
		"ui/views/villaintrial/villaintrialrankview.prefab"
	}
end

function VillaintrialRankViewPresentor:buildViews()
	return {
		VillaintrialRankView.New()
	}
end

return VillaintrialRankViewPresentor
