-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/martialcontest/view/MartialContestRewardViewPresentor.lua

module("logic.extensions.martialcontest.view.MartialContestRewardViewPresentor", package.seeall)

local MartialContestRewardViewPresentor = class("MartialContestRewardViewPresentor", ViewPresentor)

function MartialContestRewardViewPresentor:ctor()
	MartialContestRewardViewPresentor.super.ctor(self)
end

function MartialContestRewardViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function MartialContestRewardViewPresentor:dependWhatResources()
	return {
		"ui/views/martialcontest/martialcontestrewardview.prefab"
	}
end

function MartialContestRewardViewPresentor:buildViews()
	return {
		MartialContestRewardView.New()
	}
end

return MartialContestRewardViewPresentor
