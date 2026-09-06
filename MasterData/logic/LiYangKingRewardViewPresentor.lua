-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/liyangking/view/LiYangKingRewardViewPresentor.lua

module("logic.extensions.liyangking.view.LiYangKingRewardViewPresentor", package.seeall)

local LiYangKingRewardViewPresentor = class("LiYangKingRewardViewPresentor", ViewPresentor)

function LiYangKingRewardViewPresentor:ctor()
	LiYangKingRewardViewPresentor.super.ctor(self)
end

function LiYangKingRewardViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LiYangKingRewardViewPresentor:dependWhatResources()
	return {
		"ui/views/liyangking/liyangkingrewardview.prefab"
	}
end

function LiYangKingRewardViewPresentor:buildViews()
	return {
		LiYangKingRewardView.New()
	}
end

return LiYangKingRewardViewPresentor
