-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magicschool/view/MagicSchoolMainViewPresentor.lua

module("logic.extensions.magicschool.view.MagicSchoolMainViewPresentor", package.seeall)

local MagicSchoolMainViewPresentor = class("MagicSchoolMainViewPresentor", ViewPresentor)

function MagicSchoolMainViewPresentor:ctor()
	MagicSchoolMainViewPresentor.super.ctor(self)
end

function MagicSchoolMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MagicSchoolMainViewPresentor:dependWhatResources()
	return {
		"ui/views/magicschool/magicschoolmainview.prefab"
	}
end

function MagicSchoolMainViewPresentor:buildViews()
	return {
		MagicSchoolMainView.New()
	}
end

return MagicSchoolMainViewPresentor
