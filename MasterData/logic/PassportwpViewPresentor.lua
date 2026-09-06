-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/PassportwpViewPresentor.lua

module("logic.extensions.passport.view.PassportwpViewPresentor", package.seeall)

local PassportwpViewPresentor = class("PassportwpViewPresentor", ViewPresentor)

function PassportwpViewPresentor:ctor()
	PassportwpViewPresentor.super.ctor(self)
end

function PassportwpViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PassportwpViewPresentor:dependWhatResources()
	return {
		"ui/views/passport/passportwpview.prefab"
	}
end

function PassportwpViewPresentor:buildViews()
	return {
		PassportwpView.New()
	}
end

return PassportwpViewPresentor
