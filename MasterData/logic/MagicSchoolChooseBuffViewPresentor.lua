-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magicschool/view/MagicSchoolChooseBuffViewPresentor.lua

module("logic.extensions.magicschool.view.MagicSchoolChooseBuffViewPresentor", package.seeall)

local MagicSchoolChooseBuffViewPresentor = class("MagicSchoolChooseBuffViewPresentor", ViewPresentor)

function MagicSchoolChooseBuffViewPresentor:ctor()
	MagicSchoolChooseBuffViewPresentor.super.ctor(self)
end

function MagicSchoolChooseBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MagicSchoolChooseBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/magicschool/magicschoolchoosebuffview.prefab"
	}
end

function MagicSchoolChooseBuffViewPresentor:buildViews()
	return {
		MagicSchoolChooseBuffView.New()
	}
end

return MagicSchoolChooseBuffViewPresentor
