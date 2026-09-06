-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/musicgame/view/MusicGameMainViewPresentor.lua

module("logic.extensions.musicgame.view.MusicGameMainViewPresentor", package.seeall)

local MusicGameMainViewPresentor = class("MusicGameMainViewPresentor", ViewPresentor)

function MusicGameMainViewPresentor:ctor()
	MusicGameMainViewPresentor.super.ctor(self)
end

function MusicGameMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MusicGameMainViewPresentor:dependWhatResources()
	return {
		"ui/views/musicgame/musicgamemainview.prefab"
	}
end

function MusicGameMainViewPresentor:buildViews()
	return {
		MusicGameMainView.New()
	}
end

return MusicGameMainViewPresentor
