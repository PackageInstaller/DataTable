-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/linkgame/view/LinkGamePlayViewPresentor.lua

module("logic.extensions.linkgame.view.LinkGamePlayViewPresentor", package.seeall)

local LinkGamePlayViewPresentor = class("LinkGamePlayViewPresentor", ViewPresentor)

function LinkGamePlayViewPresentor:ctor()
	LinkGamePlayViewPresentor.super.ctor(self)
end

function LinkGamePlayViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LinkGamePlayViewPresentor:dependWhatResources()
	return {
		"ui/views/linkgame/linkgameview.prefab"
	}
end

function LinkGamePlayViewPresentor:buildViews()
	return {
		LinkGamePlayView.New()
	}
end

return LinkGamePlayViewPresentor
