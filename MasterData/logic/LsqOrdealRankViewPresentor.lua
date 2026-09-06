-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luoshiqiordeal/view/LsqOrdealRankViewPresentor.lua

module("logic.extensions.luoshiqiordeal.view.LsqOrdealRankViewPresentor", package.seeall)

local LsqOrdealRankViewPresentor = class("LsqOrdealRankViewPresentor", ViewPresentor)

function LsqOrdealRankViewPresentor:ctor()
	LsqOrdealRankViewPresentor.super.ctor(self)
end

function LsqOrdealRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LsqOrdealRankViewPresentor:dependWhatResources()
	return {
		"ui/views/luoshiqiordeal/lsqordealrankview.prefab"
	}
end

function LsqOrdealRankViewPresentor:buildViews()
	return {
		LsqOrdealRankView.New()
	}
end

return LsqOrdealRankViewPresentor
