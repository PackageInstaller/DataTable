-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magicschool/view/MagicSchoolChallengeViewPresentor.lua

module("logic.extensions.magicschool.view.MagicSchoolChallengeViewPresentor", package.seeall)

local MagicSchoolChallengeViewPresentor = class("MagicSchoolChallengeViewPresentor", ViewPresentor)

function MagicSchoolChallengeViewPresentor:ctor()
	MagicSchoolChallengeViewPresentor.super.ctor(self)
end

function MagicSchoolChallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MagicSchoolChallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/magicschool/magicschoolchallengeview.prefab"
	}
end

function MagicSchoolChallengeViewPresentor:buildViews()
	return {
		MagicSchoolChallengeView.New()
	}
end

return MagicSchoolChallengeViewPresentor
