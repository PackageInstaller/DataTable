-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/landlords/view/FalRankViewPresentor.lua

module("logic.extensions.landlords.view.FalRankViewPresentor", package.seeall)

local FalRankViewPresentor = class("FalRankViewPresentor", ViewPresentor)

function FalRankViewPresentor:ctor()
	FalRankViewPresentor.super.ctor(self)
end

function FalRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FalRankViewPresentor:dependWhatResources()
	return {
		"ui/views/landlords/falrankview.prefab"
	}
end

function FalRankViewPresentor:buildViews()
	return {
		FalRankView.New()
	}
end

return FalRankViewPresentor
