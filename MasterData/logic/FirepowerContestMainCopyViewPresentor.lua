-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firepowercontest/view/FirepowerContestMainCopyViewPresentor.lua

module("logic.extensions.firepowercontest.view.FirepowerContestMainCopyViewPresentor", package.seeall)

local FirepowerContestMainCopyViewPresentor = class("FirepowerContestMainCopyViewPresentor", ViewPresentor)

function FirepowerContestMainCopyViewPresentor:ctor()
	FirepowerContestMainCopyViewPresentor.super.ctor(self)
end

function FirepowerContestMainCopyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FirepowerContestMainCopyViewPresentor:dependWhatResources()
	return {
		"ui/views/firepowercontest/firepowercontestmaincopyview.prefab"
	}
end

function FirepowerContestMainCopyViewPresentor:buildViews()
	return {
		FirepowerContestMainCopyView.New()
	}
end

return FirepowerContestMainCopyViewPresentor
