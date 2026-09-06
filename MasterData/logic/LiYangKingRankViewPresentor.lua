-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/liyangking/view/LiYangKingRankViewPresentor.lua

module("logic.extensions.liyangking.view.LiYangKingRankViewPresentor", package.seeall)

local LiYangKingRankViewPresentor = class("LiYangKingRankViewPresentor", ViewPresentor)

function LiYangKingRankViewPresentor:ctor()
	LiYangKingRankViewPresentor.super.ctor(self)
end

function LiYangKingRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LiYangKingRankViewPresentor:dependWhatResources()
	return {
		"ui/views/liyangking/liyangkingrankview.prefab"
	}
end

function LiYangKingRankViewPresentor:buildViews()
	return {
		LiYangKingRankView.New()
	}
end

return LiYangKingRankViewPresentor
