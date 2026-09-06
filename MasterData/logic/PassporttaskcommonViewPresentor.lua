-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/PassporttaskcommonViewPresentor.lua

module("logic.extensions.passport.view.PassporttaskcommonViewPresentor", package.seeall)

local PassporttaskcommonViewPresentor = class("PassporttaskcommonViewPresentor", ViewPresentor)

function PassporttaskcommonViewPresentor:ctor()
	PassporttaskcommonViewPresentor.super.ctor(self)
end

function PassporttaskcommonViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PassporttaskcommonViewPresentor:dependWhatResources()
	return {
		"ui/views/passport/passporttaskcommonview.prefab"
	}
end

function PassporttaskcommonViewPresentor:buildViews()
	return {
		PassporttaskcommonView.New()
	}
end

return PassporttaskcommonViewPresentor
