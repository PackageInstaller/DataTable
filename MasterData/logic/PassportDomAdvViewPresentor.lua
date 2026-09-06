-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/domadv/PassportDomAdvViewPresentor.lua

module("logic.extensions.passport.view.domadv.PassportDomAdvViewPresentor", package.seeall)

local PassportDomAdvViewPresentor = class("PassportDomAdvViewPresentor", ViewPresentor)

function PassportDomAdvViewPresentor:ctor()
	PassportDomAdvViewPresentor.super.ctor(self)
end

function PassportDomAdvViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PassportDomAdvViewPresentor:dependWhatResources()
	return {
		"ui/views/passport/passportdomadvview.prefab"
	}
end

function PassportDomAdvViewPresentor:buildViews()
	return {
		PassportDomAdvView.New()
	}
end

return PassportDomAdvViewPresentor
