-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firepowercontest/view/FirepowercontestprepareViewPresentor.lua

module("logic.extensions.firepowercontest.view.FirepowercontestprepareViewPresentor", package.seeall)

local FirepowercontestprepareViewPresentor = class("FirepowercontestprepareViewPresentor", ViewPresentor)

function FirepowercontestprepareViewPresentor:ctor()
	FirepowercontestprepareViewPresentor.super.ctor(self)
end

function FirepowercontestprepareViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FirepowercontestprepareViewPresentor:dependWhatResources()
	return {
		"ui/views/firepowercontest/firepowercontestprepareview.prefab"
	}
end

function FirepowercontestprepareViewPresentor:buildViews()
	return {
		FirePowerContestPrepareView.New()
	}
end

return FirepowercontestprepareViewPresentor
