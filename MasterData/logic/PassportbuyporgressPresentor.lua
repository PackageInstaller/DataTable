-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/PassportbuyporgressPresentor.lua

module("logic.extensions.passport.view.PassportbuyporgressPresentor", package.seeall)

local PassportbuyporgressPresentor = class("PassportbuyporgressPresentor", ViewPresentor)

function PassportbuyporgressPresentor:ctor()
	PassportbuyporgressPresentor.super.ctor(self)
end

function PassportbuyporgressPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PassportbuyporgressPresentor:dependWhatResources()
	return {
		"ui/views/passport/passportbuyporgressview.prefab"
	}
end

function PassportbuyporgressPresentor:buildViews()
	return {
		PassportbuyporgressView.New()
	}
end

return PassportbuyporgressPresentor
