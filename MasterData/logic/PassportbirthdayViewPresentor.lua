-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/PassportbirthdayViewPresentor.lua

module("logic.extensions.passport.view.PassportbirthdayViewPresentor", package.seeall)

local PassportbirthdayViewPresentor = class("PassportbirthdayViewPresentor", ViewPresentor)

function PassportbirthdayViewPresentor:ctor()
	PassportbirthdayViewPresentor.super.ctor(self)
end

function PassportbirthdayViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PassportbirthdayViewPresentor:dependWhatResources()
	return {
		"ui/views/passport/passportbirthdayview.prefab"
	}
end

function PassportbirthdayViewPresentor:buildViews()
	return {
		PassportBirthdayView.New()
	}
end

return PassportbirthdayViewPresentor
