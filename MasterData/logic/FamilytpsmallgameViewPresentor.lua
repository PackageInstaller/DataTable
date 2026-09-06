-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyteamplay/view/game/FamilytpsmallgameViewPresentor.lua

module("logic.extensions.familyteamplay.view.FamilytpsmallgameViewPresentor", package.seeall)

local FamilytpsmallgameViewPresentor = class("FamilytpsmallgameViewPresentor", ViewPresentor)

function FamilytpsmallgameViewPresentor:ctor()
	FamilytpsmallgameViewPresentor.super.ctor(self)
end

function FamilytpsmallgameViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FamilytpsmallgameViewPresentor:dependWhatResources()
	return {
		"ui/views/familyteamplay/familytpsmallgameview.prefab"
	}
end

function FamilytpsmallgameViewPresentor:buildViews()
	return {
		FamilytpsmallgameView.New()
	}
end

return FamilytpsmallgameViewPresentor
