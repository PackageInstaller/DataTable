-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/linkgame/view/LinkGameEndlessViewPresentor.lua

module("logic.extensions.linkgame.view.LinkGameEndlessViewPresentor", package.seeall)

local LinkGameEndlessViewPresentor = class("LinkGameEndlessViewPresentor", ViewPresentor)

function LinkGameEndlessViewPresentor:ctor()
	LinkGameEndlessViewPresentor.super.ctor(self)
end

function LinkGameEndlessViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LinkGameEndlessViewPresentor:dependWhatResources()
	return {
		"ui/views/linkgame/linkgameendlessview.prefab"
	}
end

function LinkGameEndlessViewPresentor:buildViews()
	return {
		LinkGameEndlessView.New()
	}
end

return LinkGameEndlessViewPresentor
