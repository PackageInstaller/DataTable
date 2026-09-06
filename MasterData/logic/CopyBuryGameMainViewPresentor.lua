-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/suppressgame/view/game/bury/CopyBuryGameMainViewPresentor.lua

module("logic.extensions.suppressgame.view.game.bury.CopyBuryGameMainViewPresentor", package.seeall)

local CopyBuryGameMainViewPresentor = class("CopyBuryGameMainViewPresentor", ViewPresentor)

function CopyBuryGameMainViewPresentor:ctor()
	CopyBuryGameMainViewPresentor.super.ctor(self)
end

function CopyBuryGameMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CopyBuryGameMainViewPresentor:dependWhatResources()
	return {
		"ui/views/burygame/burygamemainview.prefab"
	}
end

function CopyBuryGameMainViewPresentor:buildViews()
	return {
		CopyBuryGameMainView.New()
	}
end

return CopyBuryGameMainViewPresentor
