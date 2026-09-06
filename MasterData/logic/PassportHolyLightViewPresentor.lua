-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/PassportHolyLightViewPresentor.lua

module("logic.extensions.passport.view.PassportHolyLightViewPresentor", package.seeall)

local PassportHolyLightViewPresentor = class("PassportHolyLightViewPresentor", ViewPresentor)

function PassportHolyLightViewPresentor:ctor()
	PassportHolyLightViewPresentor.super.ctor(self)
end

function PassportHolyLightViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PassportHolyLightViewPresentor:dependWhatResources()
	return {
		"ui/views/passport/passportwpview_new.prefab"
	}
end

function PassportHolyLightViewPresentor:buildViews()
	return {
		PassportHolyLightView.New()
	}
end

return PassportHolyLightViewPresentor
