-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/PassportNewYearViewPresentor.lua

module("logic.extensions.passport.view.PassportNewYearViewPresentor", package.seeall)

local PassportNewYearViewPresentor = class("PassportNewYearViewPresentor", ViewPresentor)

function PassportNewYearViewPresentor:ctor()
	PassportNewYearViewPresentor.super.ctor(self)
end

function PassportNewYearViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PassportNewYearViewPresentor:dependWhatResources()
	return {
		"ui/views/passport/passportnewyearview.prefab"
	}
end

function PassportNewYearViewPresentor:buildViews()
	return {
		PassportNewYearView.New()
	}
end

return PassportNewYearViewPresentor
