-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonBadgeViewPresentor.lua

module("logic.extensions.season.view.SeasonBadgeViewPresentor", package.seeall)

local SeasonBadgeViewPresentor = class("SeasonBadgeViewPresentor", ViewPresentor)

function SeasonBadgeViewPresentor:ctor()
	SeasonBadgeViewPresentor.super.ctor(self)
end

function SeasonBadgeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasonBadgeViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasonbadgeview.prefab"
	}
end

function SeasonBadgeViewPresentor:buildViews()
	return {
		SeasonBadgeView.New()
	}
end

return SeasonBadgeViewPresentor
