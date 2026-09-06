-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/PassportNewYearTaskViewPresentor.lua

module("logic.extensions.passport.view.PassportNewYearTaskViewPresentor", package.seeall)

local PassportNewYearTaskViewPresentor = class("PassportNewYearTaskViewPresentor", ViewPresentor)

function PassportNewYearTaskViewPresentor:ctor()
	PassportNewYearTaskViewPresentor.super.ctor(self)
end

function PassportNewYearTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PassportNewYearTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/passport/passportcamptaskview.prefab"
	}
end

function PassportNewYearTaskViewPresentor:buildViews()
	return {
		PassportNewYearTaskView.New()
	}
end

return PassportNewYearTaskViewPresentor
