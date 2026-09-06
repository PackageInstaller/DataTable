-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magicschool/view/MagicSchoolQuestionEndViewPresentor.lua

module("logic.extensions.magicschool.view.MagicSchoolQuestionEndViewPresentor", package.seeall)

local MagicSchoolQuestionEndViewPresentor = class("MagicSchoolQuestionEndViewPresentor", ViewPresentor)

function MagicSchoolQuestionEndViewPresentor:ctor()
	MagicSchoolQuestionEndViewPresentor.super.ctor(self)
end

function MagicSchoolQuestionEndViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MagicSchoolQuestionEndViewPresentor:dependWhatResources()
	return {
		"ui/views/magicschool/magicschoolquestionendview.prefab"
	}
end

function MagicSchoolQuestionEndViewPresentor:buildViews()
	return {
		MagicSchoolQuestionEndView.New()
	}
end

return MagicSchoolQuestionEndViewPresentor
