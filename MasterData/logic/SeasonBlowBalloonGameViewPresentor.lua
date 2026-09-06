-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/games/blowballoon/SeasonBlowBalloonGameViewPresentor.lua

module("logic.extensions.season.view.games.blowballoon.SeasonSeasonBlowBalloonGameViewPresentor", package.seeall)

local SeasonBlowBalloonGameViewPresentor = class("SeasonBlowBalloonGameViewPresentor", ViewPresentor)

function SeasonBlowBalloonGameViewPresentor:ctor()
	SeasonBlowBalloonGameViewPresentor.super.ctor(self)
end

function SeasonBlowBalloonGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasonBlowBalloonGameViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/elizabeth/elizabethgameview.prefab"
	}
end

function SeasonBlowBalloonGameViewPresentor:buildViews()
	return {
		SeasonBlowBalloonGameView.New()
	}
end

return SeasonBlowBalloonGameViewPresentor
