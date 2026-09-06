-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magicschool/view/MagicSchoolRenZhengViewPresentor.lua

module("logic.extensions.magicschool.view.MagicSchoolRenZhengViewPresentor", package.seeall)

local MagicSchoolRenZhengViewPresentor = class("MagicSchoolRenZhengViewPresentor", ViewPresentor)

function MagicSchoolRenZhengViewPresentor:ctor()
	MagicSchoolRenZhengViewPresentor.super.ctor(self)
end

function MagicSchoolRenZhengViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MagicSchoolRenZhengViewPresentor:dependWhatResources()
	return {
		"ui/views/magicschool/magicschoolrenzhengview.prefab"
	}
end

function MagicSchoolRenZhengViewPresentor:buildViews()
	return {
		MagicSchoolRenZhengView.New()
	}
end

return MagicSchoolRenZhengViewPresentor
