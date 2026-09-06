-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/musicgame/view/MusicGameStageViewPresentor.lua

module("logic.extensions.musicgame.view.MusicGameStageViewPresentor", package.seeall)

local MusicGameStageViewPresentor = class("MusicGameStageViewPresentor", ViewPresentor)

function MusicGameStageViewPresentor:ctor()
	MusicGameStageViewPresentor.super.ctor(self)
end

function MusicGameStageViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function MusicGameStageViewPresentor:dependWhatResources()
	return {
		"ui/views/musicgame/musicgamestageview.prefab"
	}
end

function MusicGameStageViewPresentor:buildViews()
	return {
		MusicGameStageView.New()
	}
end

return MusicGameStageViewPresentor
