-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/PassportNewYearInvestViewPresentor.lua

module("logic.extensions.passport.view.PassportNewYearInvestViewPresentor", package.seeall)

local PassportNewYearInvestViewPresentor = class("PassportNewYearInvestViewPresentor", ViewPresentor)

function PassportNewYearInvestViewPresentor:ctor()
	PassportNewYearInvestViewPresentor.super.ctor(self)
end

function PassportNewYearInvestViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PassportNewYearInvestViewPresentor:dependWhatResources()
	return {
		"ui/views/passport/passportnewyearinvestview.prefab"
	}
end

function PassportNewYearInvestViewPresentor:buildViews()
	return {
		PassportNewYearInvestView.New()
	}
end

return PassportNewYearInvestViewPresentor
