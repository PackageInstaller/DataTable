-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/martialcontest/view/MartialContestQualifierFmtViewPresentor.lua

module("logic.extensions.martialcontest.view.MartialContestQualifierFmtViewPresentor", package.seeall)

local MartialContestQualifierFmtViewPresentor = class("MartialContestQualifierFmtViewPresentor", ViewPresentor)

function MartialContestQualifierFmtViewPresentor:ctor()
	MartialContestQualifierFmtViewPresentor.super.ctor(self)
end

function MartialContestQualifierFmtViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MartialContestQualifierFmtViewPresentor:dependWhatResources()
	return {
		"ui/views/martialcontest/martialcontestqualifierfmtview.prefab"
	}
end

function MartialContestQualifierFmtViewPresentor:buildViews()
	return {
		MartialContestQualifierFmtView.New()
	}
end

return MartialContestQualifierFmtViewPresentor
