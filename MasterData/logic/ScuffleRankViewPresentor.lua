-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scuffle/view/ScuffleRankViewPresentor.lua

module("logic.extensions.scuffle.view.ScuffleRankViewPresentor", package.seeall)

local ScuffleRankViewPresentor = class("ScuffleRankViewPresentor", ViewPresentor)

function ScuffleRankViewPresentor:ctor()
	ScuffleRankViewPresentor.super.ctor(self)
end

function ScuffleRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ScuffleRankViewPresentor:dependWhatResources()
	return {
		"ui/views/scuffle/scufflerankview.prefab"
	}
end

function ScuffleRankViewPresentor:buildViews()
	return {
		ScuffleRankView.New()
	}
end

return ScuffleRankViewPresentor
