-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/PassportyzbuyViewPresentor.lua

module("logic.extensions.passport.view.PassportyzbuyViewPresentor", package.seeall)

local PassportyzbuyViewPresentor = class("PassportyzbuyViewPresentor", ViewPresentor)

function PassportyzbuyViewPresentor:ctor()
	PassportyzbuyViewPresentor.super.ctor(self)
end

function PassportyzbuyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PassportyzbuyViewPresentor:dependWhatResources()
	return {
		"ui/views/passport/passportyzbuyview.prefab"
	}
end

function PassportyzbuyViewPresentor:buildViews()
	return {
		PassportyzbuyView.New()
	}
end

return PassportyzbuyViewPresentor
