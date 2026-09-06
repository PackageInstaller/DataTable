-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chopking/view/ChopKingRankViewPresentor.lua

module("logic.extensions.chopking.view.ChopKingRankViewPresentor", package.seeall)

local ChopKingRankViewPresentor = class("ChopKingRankViewPresentor", ViewPresentor)

function ChopKingRankViewPresentor:ctor()
	ChopKingRankViewPresentor.super.ctor(self)
end

function ChopKingRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ChopKingRankViewPresentor:dependWhatResources()
	return {
		"ui/views/chopking/chopkingrankview.prefab"
	}
end

function ChopKingRankViewPresentor:buildViews()
	return {
		ChopKingRankView.New()
	}
end

return ChopKingRankViewPresentor
