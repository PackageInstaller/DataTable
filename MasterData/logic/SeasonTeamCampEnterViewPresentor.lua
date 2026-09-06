-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/teamcampshow/SeasonTeamCampEnterViewPresentor.lua

module("logic.extensions.season.view.teamcampshow.SeasonTeamCampEnterViewPresentor", package.seeall)

local SeasonTeamCampEnterViewPresentor = class("SeasonTeamCampEnterViewPresentor", ViewPresentor)

function SeasonTeamCampEnterViewPresentor:ctor()
	SeasonTeamCampEnterViewPresentor.super.ctor(self)
end

function SeasonTeamCampEnterViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasonTeamCampEnterViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasonteamcampenterview.prefab"
	}
end

function SeasonTeamCampEnterViewPresentor:buildViews()
	return {
		SeasonTeamCampEnterView.New()
	}
end

return SeasonTeamCampEnterViewPresentor
