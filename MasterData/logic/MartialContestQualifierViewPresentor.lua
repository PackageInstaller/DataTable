-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/martialcontest/view/MartialContestQualifierViewPresentor.lua

module("logic.extensions.martialcontest.view.MartialContestQualifierViewPresentor", package.seeall)

local MartialContestQualifierViewPresentor = class("MartialContestQualifierViewPresentor", ViewPresentor)

function MartialContestQualifierViewPresentor:ctor()
	MartialContestQualifierViewPresentor.super.ctor(self)
end

function MartialContestQualifierViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MartialContestQualifierViewPresentor:dependWhatResources()
	return {
		"ui/views/martialcontest/martialcontestqualifierview.prefab"
	}
end

function MartialContestQualifierViewPresentor:buildViews()
	return {
		MartialContestQualifierView.New()
	}
end

return MartialContestQualifierViewPresentor
