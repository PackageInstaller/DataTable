-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/PassportwpextbuyViewPresentor.lua

module("logic.extensions.passport.view.PassportwpextbuyViewPresentor", package.seeall)

local PassportwpextbuyViewPresentor = class("PassportwpextbuyViewPresentor", ViewPresentor)

function PassportwpextbuyViewPresentor:ctor()
	PassportwpextbuyViewPresentor.super.ctor(self)
end

function PassportwpextbuyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PassportwpextbuyViewPresentor:dependWhatResources()
	return {
		"ui/views/passport/passportwpextbuyview.prefab"
	}
end

function PassportwpextbuyViewPresentor:buildViews()
	return {
		PassportwpextbuyView.New()
	}
end

return PassportwpextbuyViewPresentor
