-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firepowercontest/view/FirepowercontestgameViewPresentor.lua

module("logic.extensions.firepowercontest.view.FirepowercontestgameViewPresentor", package.seeall)

local FirepowercontestgameViewPresentor = class("FirepowercontestgameViewPresentor", ViewPresentor)

function FirepowercontestgameViewPresentor:ctor()
	FirepowercontestgameViewPresentor.super.ctor(self)
end

function FirepowercontestgameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FirepowercontestgameViewPresentor:dependWhatResources()
	return {
		"ui/views/firepowercontest/firepowercontestgameview.prefab"
	}
end

function FirepowercontestgameViewPresentor:buildViews()
	return {
		FirePowerContestGameView.New()
	}
end

return FirepowercontestgameViewPresentor
