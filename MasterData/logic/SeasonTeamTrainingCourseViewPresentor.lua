-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/teamcampshow/SeasonTeamTrainingCourseViewPresentor.lua

module("logic.extensions.season.view.SeasonTeamTrainingCourseViewPresentor", package.seeall)

local SeasonTeamTrainingCourseViewPresentor = class("SeasonTeamTrainingCourseViewPresentor", ViewPresentor)

function SeasonTeamTrainingCourseViewPresentor:ctor()
	SeasonTeamTrainingCourseViewPresentor.super.ctor(self)
end

function SeasonTeamTrainingCourseViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasonTeamTrainingCourseViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasontrainingcourseview.prefab"
	}
end

function SeasonTeamTrainingCourseViewPresentor:buildViews()
	return {
		SeasonTeamTrainingCourseView.New()
	}
end

return SeasonTeamTrainingCourseViewPresentor
