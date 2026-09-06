-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magicschool/view/MagicSchoolQuestionViewPresentor.lua

module("logic.extensions.magicschool.view.MagicSchoolQuestionViewPresentor", package.seeall)

local MagicSchoolQuestionViewPresentor = class("MagicSchoolQuestionViewPresentor", ViewPresentor)

function MagicSchoolQuestionViewPresentor:ctor()
	MagicSchoolQuestionViewPresentor.super.ctor(self)
end

function MagicSchoolQuestionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MagicSchoolQuestionViewPresentor:dependWhatResources()
	return {
		"ui/views/magicschool/magicschoolquestionview.prefab"
	}
end

function MagicSchoolQuestionViewPresentor:buildViews()
	return {
		MagicSchoolQuestionView.New()
	}
end

return MagicSchoolQuestionViewPresentor
