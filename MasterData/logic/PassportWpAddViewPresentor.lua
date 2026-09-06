-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/PassportWpAddViewPresentor.lua

module("logic.extensions.passport.view.PassportWpAddViewPresentor", package.seeall)

local PassportWpAddViewPresentor = class("PassportWpAddViewPresentor", ViewPresentor)

function PassportWpAddViewPresentor:ctor()
	PassportWpAddViewPresentor.super.ctor(self)
end

function PassportWpAddViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PassportWpAddViewPresentor:dependWhatResources()
	return {
		"ui/views/passport/passportwpview_add.prefab"
	}
end

function PassportWpAddViewPresentor:buildViews()
	return {
		PassportWpAddView.New()
	}
end

return PassportWpAddViewPresentor
