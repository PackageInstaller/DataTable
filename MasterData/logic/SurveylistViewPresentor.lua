-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/SurveylistViewPresentor.lua

module("logic.extensions.bonus.view.SurveylistViewPresentor", package.seeall)

local SurveylistViewPresentor = class("SurveylistViewPresentor", ViewPresentor)

function SurveylistViewPresentor:ctor()
	SurveylistViewPresentor.super.ctor(self)
end

function SurveylistViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SurveylistViewPresentor:dependWhatResources()
	return {
		"ui/views/bonus/surveylistview.prefab"
	}
end

function SurveylistViewPresentor:buildViews()
	return {
		SurveylistView.New()
	}
end

return SurveylistViewPresentor
