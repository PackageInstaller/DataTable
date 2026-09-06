-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firepowercontest/view/FirepowercontestmatchViewPresentor.lua

module("logic.extensions.firepowercontest.view.FirepowercontestmatchViewPresentor", package.seeall)

local FirepowercontestmatchViewPresentor = class("FirepowercontestmatchViewPresentor", ViewPresentor)

function FirepowercontestmatchViewPresentor:ctor()
	FirepowercontestmatchViewPresentor.super.ctor(self)
end

function FirepowercontestmatchViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FirepowercontestmatchViewPresentor:dependWhatResources()
	return {
		"ui/views/firepowercontest/firepowercontestmatchview.prefab"
	}
end

function FirepowercontestmatchViewPresentor:buildViews()
	return {
		FirePowerContestMatchView.New()
	}
end

return FirepowercontestmatchViewPresentor
