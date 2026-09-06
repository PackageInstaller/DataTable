-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/martialcontest/view/MartialContestQualifyMatchViewPresentor.lua

module("logic.extensions.martialcontest.view.MartialContestQualifyMatchViewPresentor", package.seeall)

local MartialContestQualifyMatchViewPresentor = class("MartialContestQualifyMatchViewPresentor", ViewPresentor)

function MartialContestQualifyMatchViewPresentor:ctor()
	MartialContestQualifyMatchViewPresentor.super.ctor(self)
end

function MartialContestQualifyMatchViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function MartialContestQualifyMatchViewPresentor:dependWhatResources()
	return {
		"ui/views/martialcontest/martialcontestqualifymatchview.prefab"
	}
end

function MartialContestQualifyMatchViewPresentor:buildViews()
	return {
		MartialContestQualifyMatchView.New()
	}
end

return MartialContestQualifyMatchViewPresentor
