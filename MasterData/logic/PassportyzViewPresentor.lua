-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/PassportyzViewPresentor.lua

module("logic.extensions.passport.view.PassportyzViewPresentor", package.seeall)

local PassportyzViewPresentor = class("PassportyzViewPresentor", ViewPresentor)

function PassportyzViewPresentor:ctor()
	PassportyzViewPresentor.super.ctor(self)
end

function PassportyzViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PassportyzViewPresentor:dependWhatResources()
	return {
		"ui/views/passport/passportyzview.prefab"
	}
end

function PassportyzViewPresentor:buildViews()
	return {
		PassportyzView.New()
	}
end

return PassportyzViewPresentor
