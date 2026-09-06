-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/martialcontest/view/MartialContestMainViewPresentor.lua

module("logic.extensions.martialcontest.view.MartialContestMainViewPresentor", package.seeall)

local MartialContestMainViewPresentor = class("MartialContestMainViewPresentor", ViewPresentor)

function MartialContestMainViewPresentor:ctor()
	MartialContestMainViewPresentor.super.ctor(self)
end

function MartialContestMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MartialContestMainViewPresentor:dependWhatResources()
	return {
		"ui/views/martialcontest/martialcontestmainview.prefab"
	}
end

function MartialContestMainViewPresentor:buildViews()
	return {
		MartialContestMainView.New()
	}
end

return MartialContestMainViewPresentor
