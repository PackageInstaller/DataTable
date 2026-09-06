-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magicschool/view/MagicSchoolOperationSignInViewPresentor.lua

module("logic.extensions.magicschool.view.MagicSchoolOperationSignInViewPresentor", package.seeall)

local MagicSchoolOperationSignInViewPresentor = class("MagicSchoolOperationSignInViewPresentor", ViewPresentor)

function MagicSchoolOperationSignInViewPresentor:ctor()
	MagicSchoolOperationSignInViewPresentor.super.ctor(self)
end

function MagicSchoolOperationSignInViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MagicSchoolOperationSignInViewPresentor:dependWhatResources()
	return {
		"ui/views/magicschool/magicschooloperationsigninview.prefab"
	}
end

function MagicSchoolOperationSignInViewPresentor:buildViews()
	return {
		MagicSchoolOperationSignInView.New()
	}
end

return MagicSchoolOperationSignInViewPresentor
