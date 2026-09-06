-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/games/burygame/SeasonBuryGameMainViewPresentor.lua

module("logic.extensions.season.view.games.burygame.SeasonSeasonBuryGameMainViewPresentor", package.seeall)

local SeasonBuryGameMainViewPresentor = class("SeasonBuryGameMainViewPresentor", ViewPresentor)

function SeasonBuryGameMainViewPresentor:ctor()
	SeasonBuryGameMainViewPresentor.super.ctor(self)
end

function SeasonBuryGameMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasonBuryGameMainViewPresentor:dependWhatResources()
	return {
		"ui/views/burygame/burygamemainview.prefab"
	}
end

function SeasonBuryGameMainViewPresentor:buildViews()
	return {
		SeasonBuryGameMainView.New()
	}
end

return SeasonBuryGameMainViewPresentor
