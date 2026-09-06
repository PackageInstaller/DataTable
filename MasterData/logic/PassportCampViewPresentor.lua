-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/PassportCampViewPresentor.lua

module("logic.extensions.passport.view.PassportCampViewPresentor", package.seeall)

local PassportCampViewPresentor = class("PassportCampViewPresentor", ViewPresentor)

function PassportCampViewPresentor:ctor()
	PassportCampViewPresentor.super.ctor(self)
end

function PassportCampViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PassportCampViewPresentor:dependWhatResources()
	return {
		"ui/views/passport/passportcampview.prefab"
	}
end

function PassportCampViewPresentor:buildViews()
	return {
		PassportCampView.New()
	}
end

return PassportCampViewPresentor
