-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magicschool/view/MagicSchoolChooseViewPresentor.lua

module("logic.extensions.magicschool.view.MagicSchoolChooseViewPresentor", package.seeall)

local MagicSchoolChooseViewPresentor = class("MagicSchoolChooseViewPresentor", ViewPresentor)

function MagicSchoolChooseViewPresentor:ctor()
	MagicSchoolChooseViewPresentor.super.ctor(self)
end

function MagicSchoolChooseViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MagicSchoolChooseViewPresentor:dependWhatResources()
	return {
		"ui/views/magicschool/magicschoolchooseview.prefab"
	}
end

function MagicSchoolChooseViewPresentor:buildViews()
	return {
		MagicSchoolChooseView.New()
	}
end

return MagicSchoolChooseViewPresentor
