-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/linkgame/view/LinkGameMainViewPresentor.lua

module("logic.extensions.linkgame.view.LinkGameMainViewPresentor", package.seeall)

local LinkGameMainViewPresentor = class("LinkGameMainViewPresentor", ViewPresentor)

function LinkGameMainViewPresentor:ctor()
	LinkGameMainViewPresentor.super.ctor(self)
end

function LinkGameMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LinkGameMainViewPresentor:dependWhatResources()
	return {
		"ui/views/linkgame/linkgamemainview.prefab"
	}
end

function LinkGameMainViewPresentor:buildViews()
	return {
		LinkGameMainView.New()
	}
end

return LinkGameMainViewPresentor
