-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknightregress/view/SaintKnightRegressMainViewPresentor.lua

module("logic.extensions.saintknightregress.view.SaintKnightRegressMainViewPresentor", package.seeall)

local SaintKnightRegressMainViewPresentor = class("SaintKnightRegressMainViewPresentor", ViewPresentor)

function SaintKnightRegressMainViewPresentor:ctor()
	SaintKnightRegressMainViewPresentor.super.ctor(self)
end

function SaintKnightRegressMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SaintKnightRegressMainViewPresentor:dependWhatResources()
	return {
		"ui/views/saintknightregress/saintknightregressmainview.prefab"
	}
end

function SaintKnightRegressMainViewPresentor:buildViews()
	return {
		SaintKnightRegressMainView.New()
	}
end

return SaintKnightRegressMainViewPresentor
