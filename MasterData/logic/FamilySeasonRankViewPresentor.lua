-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyteamplay/view/FamilySeasonRankViewPresentor.lua

module("logic.extensions.familyteamplay.view.FamilySeasonRankViewPresentor", package.seeall)

local FamilySeasonRankViewPresentor = class("FamilySeasonRankViewPresentor", ViewPresentor)

function FamilySeasonRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FamilySeasonRankViewPresentor:dependWhatResources()
	return {
		"ui/views/familyteamplay/familyseasonrankview.prefab"
	}
end

function FamilySeasonRankViewPresentor:buildViews()
	return {
		FamilySeasonRankView.New()
	}
end

return FamilySeasonRankViewPresentor
