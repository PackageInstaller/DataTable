-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firepowercontest/view/FirepowercontestmainViewPresentor.lua

module("logic.extensions.firepowercontest.view.FirepowercontestmainViewPresentor", package.seeall)

local FirepowercontestmainViewPresentor = class("FirepowercontestmainViewPresentor", ViewPresentor)

function FirepowercontestmainViewPresentor:ctor()
	FirepowercontestmainViewPresentor.super.ctor(self)
end

function FirepowercontestmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FirepowercontestmainViewPresentor:dependWhatResources()
	return {
		"ui/views/firepowercontest/firepowercontestmainview.prefab"
	}
end

function FirepowercontestmainViewPresentor:buildViews()
	return {
		FirePowerContestMainView.New()
	}
end

return FirepowercontestmainViewPresentor
