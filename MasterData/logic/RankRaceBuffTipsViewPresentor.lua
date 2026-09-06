-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/view/RankRaceBuffTipsViewPresentor.lua

module("logic.extensions.rankrace.view.RankRaceBuffTipsViewPresentor", package.seeall)

local RankRaceBuffTipsViewPresentor = class("RankRaceBuffTipsViewPresentor", ViewPresentor)

function RankRaceBuffTipsViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function RankRaceBuffTipsViewPresentor:dependWhatResources()
	return {
		"ui/views/rankrace/rankracebufftips.prefab"
	}
end

function RankRaceBuffTipsViewPresentor:buildViews()
	return {
		RankRaceBuffTipsView.New()
	}
end

return RankRaceBuffTipsViewPresentor
