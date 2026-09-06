-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/PassportCampTaskViewPresentor.lua

module("logic.extensions.passport.view.PassportCampTaskViewPresentor", package.seeall)

local PassportCampTaskViewPresentor = class("PassportCampTaskViewPresentor", ViewPresentor)

function PassportCampTaskViewPresentor:ctor()
	PassportCampTaskViewPresentor.super.ctor(self)
end

function PassportCampTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PassportCampTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/passport/passportcamptaskview.prefab"
	}
end

function PassportCampTaskViewPresentor:buildViews()
	return {
		PassportCampTaskView.New()
	}
end

return PassportCampTaskViewPresentor
