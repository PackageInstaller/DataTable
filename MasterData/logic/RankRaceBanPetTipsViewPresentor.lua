-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/view/RankRaceBanPetTipsViewPresentor.lua

module("logic.extensions.rankrace.view.RankRaceBanPetTipsViewPresentor", package.seeall)

local RankRaceBanPetTipsViewPresentor = class("RankRaceBanPetTipsViewPresentor", ViewPresentor)

function RankRaceBanPetTipsViewPresentor:ctor()
	RankRaceBanPetTipsViewPresentor.super.ctor(self)
end

function RankRaceBanPetTipsViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function RankRaceBanPetTipsViewPresentor:dependWhatResources()
	return {
		"ui/views/rankrace/rankracebanpettipsview.prefab"
	}
end

function RankRaceBanPetTipsViewPresentor:buildViews()
	return {
		RankRaceBanPetTipsView.New()
	}
end

return RankRaceBanPetTipsViewPresentor
