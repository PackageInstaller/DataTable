-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/PassportbirthdaytaskViewPresentor.lua

module("logic.extensions.passport.view.PassportbirthdaytaskViewPresentor", package.seeall)

local PassportbirthdaytaskViewPresentor = class("PassportbirthdaytaskViewPresentor", ViewPresentor)

function PassportbirthdaytaskViewPresentor:ctor()
	PassportbirthdaytaskViewPresentor.super.ctor(self)
end

function PassportbirthdaytaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PassportbirthdaytaskViewPresentor:dependWhatResources()
	return {
		"ui/views/passport/passportbirthdaytaskview.prefab"
	}
end

function PassportbirthdaytaskViewPresentor:buildViews()
	return {
		PassportBirthdayTaskView.New()
	}
end

return PassportbirthdaytaskViewPresentor
