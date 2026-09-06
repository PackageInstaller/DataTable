-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknightcard/view/SaintKnightCardRankViewPresentor.lua

module("logic.extensions.saintknightcard.view.SaintKnightCardRankViewPresentor", package.seeall)

local SaintKnightCardRankViewPresentor = class("SaintKnightCardRankViewPresentor", ViewPresentor)

function SaintKnightCardRankViewPresentor:ctor()
	SaintKnightCardRankViewPresentor.super.ctor(self)
end

function SaintKnightCardRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SaintKnightCardRankViewPresentor:dependWhatResources()
	return {
		"ui/views/saintknightcard/saintknightcardrankview.prefab"
	}
end

function SaintKnightCardRankViewPresentor:buildViews()
	return {
		SaintKnightCardRankView.New()
	}
end

return SaintKnightCardRankViewPresentor
