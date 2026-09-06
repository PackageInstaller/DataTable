-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyteamplay/view/game/flynuo/FamilytpflynuoitemgetViewPresentor.lua

module("logic.extensions.familyteamplay.view.game.flynuo.FamilytpflynuoitemgetViewPresentor", package.seeall)

local FamilytpflynuoitemgetViewPresentor = class("FamilytpflynuoitemgetViewPresentor", ViewPresentor)

function FamilytpflynuoitemgetViewPresentor:ctor()
	FamilytpflynuoitemgetViewPresentor.super.ctor(self)
end

function FamilytpflynuoitemgetViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FamilytpflynuoitemgetViewPresentor:dependWhatResources()
	return {
		"ui/views/familyteamplay/familytpflynuoitemgetview.prefab"
	}
end

function FamilytpflynuoitemgetViewPresentor:buildViews()
	return {
		FamilytpflynuoitemgetView.New()
	}
end

return FamilytpflynuoitemgetViewPresentor
