-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teenchampionking/view/TeenChampionKingRewardViewPresentor.lua

module("logic.extensions.teenchampionking.view.TeenChampionKingRewardViewPresentor", package.seeall)

local TeenChampionKingRewardViewPresentor = class("TeenChampionKingRewardViewPresentor", ViewPresentor)

function TeenChampionKingRewardViewPresentor:ctor()
	TeenChampionKingRewardViewPresentor.super.ctor(self)
end

function TeenChampionKingRewardViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TeenChampionKingRewardViewPresentor:dependWhatResources()
	return {
		"ui/views/teenchampionking/teenchampionkingrewardview.prefab"
	}
end

function TeenChampionKingRewardViewPresentor:buildViews()
	return {
		TeenChampionKingRewardView.New()
	}
end

return TeenChampionKingRewardViewPresentor
