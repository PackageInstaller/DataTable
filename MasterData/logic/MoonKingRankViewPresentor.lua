-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/moonking/view/MoonKingRankViewPresentor.lua

module("logic.extensions.moonking.view.MoonKingRankViewPresentor", package.seeall)

local MoonKingRankViewPresentor = class("MoonKingRankViewPresentor", ViewWithGuidePresentor)

function MoonKingRankViewPresentor:ctor()
	MoonKingRankViewPresentor.super.ctor(self)
end

function MoonKingRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MoonKingRankViewPresentor:dependWhatResources()
	return {
		"ui/views/moonking/moonkingrankview.prefab"
	}
end

function MoonKingRankViewPresentor:buildViews()
	return {
		MoonKingRankView.New()
	}
end

return MoonKingRankViewPresentor
