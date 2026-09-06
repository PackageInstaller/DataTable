-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/PassportbirthdaypopupViewPresentor.lua

module("logic.extensions.passport.view.PassportbirthdaypopupViewPresentor", package.seeall)

local PassportbirthdaypopupViewPresentor = class("PassportbirthdaypopupViewPresentor", ViewPresentor)

function PassportbirthdaypopupViewPresentor:ctor()
	PassportbirthdaypopupViewPresentor.super.ctor(self)
end

function PassportbirthdaypopupViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PassportbirthdaypopupViewPresentor:dependWhatResources()
	return {
		"ui/views/passport/passportbirthdaypopupview.prefab"
	}
end

function PassportbirthdaypopupViewPresentor:buildViews()
	return {
		PassportBirthdayPopupView.New()
	}
end

return PassportbirthdaypopupViewPresentor
