-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/PassportwpnewViewPresentor.lua

module("logic.extensions.passport.view.PassportwpnewViewPresentor", package.seeall)

local PassportwpnewViewPresentor = class("PassportwpnewViewPresentor", ViewPresentor)

function PassportwpnewViewPresentor:ctor()
	PassportwpnewViewPresentor.super.ctor(self)
end

function PassportwpnewViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PassportwpnewViewPresentor:dependWhatResources()
	return {
		"ui/views/passport/passportwpview_new.prefab"
	}
end

function PassportwpnewViewPresentor:buildViews()
	return {
		PassportwpnewView.New()
	}
end

return PassportwpnewViewPresentor
