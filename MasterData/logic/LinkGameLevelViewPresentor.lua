-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/linkgame/view/LinkGameLevelViewPresentor.lua

module("logic.extensions.linkgame.view.LinkGameLevelViewPresentor", package.seeall)

local LinkGameLevelViewPresentor = class("LinkGameLevelViewPresentor", ViewPresentor)

function LinkGameLevelViewPresentor:ctor()
	LinkGameLevelViewPresentor.super.ctor(self)
end

function LinkGameLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LinkGameLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/linkgame/linkgamelevelview.prefab"
	}
end

function LinkGameLevelViewPresentor:buildViews()
	return {
		LinkGameLevelView.New()
	}
end

return LinkGameLevelViewPresentor
