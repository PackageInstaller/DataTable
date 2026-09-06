-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youngchampionking/view/YoungChampionKingRewardViewPresentor.lua

module("logic.extensions.youngchampionking.view.YoungChampionKingRewardViewPresentor", package.seeall)

local YoungChampionKingRewardViewPresentor = class("YoungChampionKingRewardViewPresentor", ViewPresentor)

function YoungChampionKingRewardViewPresentor:ctor()
	YoungChampionKingRewardViewPresentor.super.ctor(self)
end

function YoungChampionKingRewardViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YoungChampionKingRewardViewPresentor:dependWhatResources()
	return {
		"ui/views/youngchampionking/youngchampionkingrewardview.prefab"
	}
end

function YoungChampionKingRewardViewPresentor:buildViews()
	return {
		YoungChampionKingRewardView.New()
	}
end

return YoungChampionKingRewardViewPresentor
