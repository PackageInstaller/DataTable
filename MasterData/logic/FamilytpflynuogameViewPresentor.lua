-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyteamplay/view/game/flynuo/FamilytpflynuogameViewPresentor.lua

module("logic.extensions.familyteamplay.view.game.flynuo.FamilytpflynuogameViewPresentor", package.seeall)

local FamilytpflynuogameViewPresentor = class("FamilytpflynuogameViewPresentor", ViewPresentor)

function FamilytpflynuogameViewPresentor:ctor()
	FamilytpflynuogameViewPresentor.super.ctor(self)
end

function FamilytpflynuogameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FamilytpflynuogameViewPresentor:dependWhatResources()
	return {
		"ui/views/familyteamplay/familytpflynuogameview.prefab"
	}
end

function FamilytpflynuogameViewPresentor:buildViews()
	return {
		FamilytpflynuogameView.New()
	}
end

return FamilytpflynuogameViewPresentor
