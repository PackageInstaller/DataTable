-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/martialcontest/view/MartialContestScoreResultViewPresentor.lua

module("logic.extensions.martialcontest.view.MartialContestScoreResultViewPresentor", package.seeall)

local MartialContestScoreResultViewPresentor = class("MartialContestScoreResultViewPresentor", ViewPresentor)

function MartialContestScoreResultViewPresentor:ctor()
	MartialContestScoreResultViewPresentor.super.ctor(self)
end

function MartialContestScoreResultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function MartialContestScoreResultViewPresentor:dependWhatResources()
	return {
		"ui/views/martialcontest/martialcontestscoreresultview.prefab"
	}
end

function MartialContestScoreResultViewPresentor:buildViews()
	return {
		MartialContestScoreResultView.New()
	}
end

return MartialContestScoreResultViewPresentor
