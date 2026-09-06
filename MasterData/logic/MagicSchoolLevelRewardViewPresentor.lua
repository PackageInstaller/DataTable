-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magicschool/view/MagicSchoolLevelRewardViewPresentor.lua

module("logic.extensions.magicschool.view.MagicSchoolLevelRewardViewPresentor", package.seeall)

local MagicSchoolLevelRewardViewPresentor = class("MagicSchoolLevelRewardViewPresentor", ViewPresentor)

function MagicSchoolLevelRewardViewPresentor:ctor()
	MagicSchoolLevelRewardViewPresentor.super.ctor(self)
end

function MagicSchoolLevelRewardViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MagicSchoolLevelRewardViewPresentor:dependWhatResources()
	return {
		"ui/views/magicschool/magicschoollevelrewardview.prefab"
	}
end

function MagicSchoolLevelRewardViewPresentor:buildViews()
	return {
		MagicSchoolLevelRewardView.New()
	}
end

return MagicSchoolLevelRewardViewPresentor
