-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firepowercontest/view/FirepowercontestresultViewPresentor.lua

module("logic.extensions.firepowercontest.view.FirepowercontestresultViewPresentor", package.seeall)

local FirepowercontestresultViewPresentor = class("FirepowercontestresultViewPresentor", ViewPresentor)

function FirepowercontestresultViewPresentor:ctor()
	FirepowercontestresultViewPresentor.super.ctor(self)
end

function FirepowercontestresultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FirepowercontestresultViewPresentor:dependWhatResources()
	return {
		"ui/views/firepowercontest/firepowercontestresultview.prefab"
	}
end

function FirepowercontestresultViewPresentor:buildViews()
	return {
		FirePowerContestResultView.New()
	}
end

return FirepowercontestresultViewPresentor
