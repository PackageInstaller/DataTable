-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/PassportbuyPresentor.lua

module("logic.extensions.passport.view.PassportbuyPresentor", package.seeall)

local PassportbuyPresentor = class("PassportbuyPresentor", ViewPresentor)

function PassportbuyPresentor:ctor()
	PassportbuyPresentor.super.ctor(self)
end

function PassportbuyPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PassportbuyPresentor:dependWhatResources()
	return {
		"ui/views/passport/passportbuyview.prefab"
	}
end

function PassportbuyPresentor:buildViews()
	return {
		PassportbuyView.New()
	}
end

return PassportbuyPresentor
