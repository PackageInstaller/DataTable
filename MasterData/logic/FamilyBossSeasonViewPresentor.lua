-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyteamplay/view/FamilyBossSeasonViewPresentor.lua

module("logic.extensions.familyteamplay.view.FamilyBossSeasonViewPresentor", package.seeall)

local FamilyBossSeasonViewPresentor = class("FamilyBossSeasonViewPresentor", ViewPresentor)

function FamilyBossSeasonViewPresentor:ctor()
	FamilyBossSeasonViewPresentor.super.ctor(self)
end

function FamilyBossSeasonViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FamilyBossSeasonViewPresentor:dependWhatResources()
	return {
		"ui/views/familyteamplay/familybossseasonview.prefab"
	}
end

function FamilyBossSeasonViewPresentor:buildViews()
	return {
		FamilyBossSeasonView.New()
	}
end

return FamilyBossSeasonViewPresentor
