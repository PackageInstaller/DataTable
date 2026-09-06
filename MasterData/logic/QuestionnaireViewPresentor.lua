-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/questionnaire/view/QuestionnaireViewPresentor.lua

module("logic.extensions.questionnaire.view.QuestionnaireViewPresentor", package.seeall)

local QuestionnaireViewPresentor = class("QuestionnaireViewPresentor", ViewPresentor)

function QuestionnaireViewPresentor:ctor()
	QuestionnaireViewPresentor.super.ctor(self)
end

function QuestionnaireViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function QuestionnaireViewPresentor:dependWhatResources()
	return {
		"ui/views/questionnaire/questionnaireview.prefab"
	}
end

function QuestionnaireViewPresentor:buildViews()
	return {
		QuestionnaireView.New()
	}
end

return QuestionnaireViewPresentor
