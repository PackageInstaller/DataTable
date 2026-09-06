-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/PassportwpbuyViewPresentor.lua

module("logic.extensions.passport.view.PassportwpbuyViewPresentor", package.seeall)

local PassportwpbuyViewPresentor = class("PassportwpbuyViewPresentor", ViewPresentor)

function PassportwpbuyViewPresentor:ctor()
	PassportwpbuyViewPresentor.super.ctor(self)
end

function PassportwpbuyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PassportwpbuyViewPresentor:dependWhatResources()
	return {
		"ui/views/passport/passportwpbuyview.prefab"
	}
end

function PassportwpbuyViewPresentor:buildViews()
	return {
		PassportwpbuyView.New()
	}
end

return PassportwpbuyViewPresentor
