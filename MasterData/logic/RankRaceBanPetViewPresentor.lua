-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/view/RankRaceBanPetViewPresentor.lua

module("logic.extensions.rankrace.view.RankRaceBanPetViewPresentor", package.seeall)

local RankRaceBanPetViewPresentor = class("RankRaceBanPetViewPresentor", ViewPresentor)

function RankRaceBanPetViewPresentor:ctor()
	RankRaceBanPetViewPresentor.super.ctor(self)
end

function RankRaceBanPetViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RankRaceBanPetViewPresentor:dependWhatResources()
	return {
		"ui/views/rankrace/rankracebanpetview.prefab"
	}
end

function RankRaceBanPetViewPresentor:buildViews()
	return {
		RankRaceBanPetView.New()
	}
end

return RankRaceBanPetViewPresentor
