-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonRankOccupiedViewPresentor.lua

module("logic.extensions.season.view.SeasonRankOccupiedViewPresentor", package.seeall)

local SeasonRankOccupiedViewPresentor = class("SeasonRankOccupiedViewPresentor", ViewPresentor)

function SeasonRankOccupiedViewPresentor:ctor()
	SeasonRankOccupiedViewPresentor.super.ctor(self)
end

function SeasonRankOccupiedViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasonRankOccupiedViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasonrankoccupiedview.prefab"
	}
end

function SeasonRankOccupiedViewPresentor:buildViews()
	return {
		SeasonRankOccupiedView.New()
	}
end

function SeasonRankOccupiedViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return SeasonRankOccupiedViewPresentor
