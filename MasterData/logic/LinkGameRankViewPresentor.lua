-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/linkgame/view/LinkGameRankViewPresentor.lua

module("logic.extensions.linkgame.view.LinkGameRankViewPresentor", package.seeall)

local LinkGameRankViewPresentor = class("LinkGameRankViewPresentor", ViewPresentor)

function LinkGameRankViewPresentor:ctor()
	LinkGameRankViewPresentor.super.ctor(self)
end

function LinkGameRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LinkGameRankViewPresentor:dependWhatResources()
	return {
		"ui/views/linkgame/linkgamerankview.prefab"
	}
end

function LinkGameRankViewPresentor:buildViews()
	return {
		LinkGameRankView.New()
	}
end

return LinkGameRankViewPresentor
