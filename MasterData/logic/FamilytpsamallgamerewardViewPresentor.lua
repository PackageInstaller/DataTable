-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyteamplay/view/game/kjt/FamilytpsamallgamerewardViewPresentor.lua

module("logic.extensions.familyteamplay.view.game.kjt.FamilytpsamallgamerewardViewPresentor", package.seeall)

local FamilytpsamallgamerewardViewPresentor = class("FamilytpsamallgamerewardViewPresentor", ViewPresentor)

function FamilytpsamallgamerewardViewPresentor:ctor()
	FamilytpsamallgamerewardViewPresentor.super.ctor(self)
end

function FamilytpsamallgamerewardViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FamilytpsamallgamerewardViewPresentor:dependWhatResources()
	return {
		"ui/views/familyteamplay/familytpsamallgamereward.prefab"
	}
end

function FamilytpsamallgamerewardViewPresentor:buildViews()
	return {
		FamilytpsamallgamerewardView.New()
	}
end

return FamilytpsamallgamerewardViewPresentor
