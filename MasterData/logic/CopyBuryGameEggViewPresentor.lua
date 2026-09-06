-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/suppressgame/view/game/bury/CopyBuryGameEggViewPresentor.lua

module("logic.extensions.suppressgame.view.game.bury.CopyBuryGameEggViewPresentor", package.seeall)

local CopyBuryGameEggViewPresentor = class("CopyBuryGameEggViewPresentor", ViewPresentor)

function CopyBuryGameEggViewPresentor:ctor()
	CopyBuryGameEggViewPresentor.super.ctor(self)
end

function CopyBuryGameEggViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function CopyBuryGameEggViewPresentor:dependWhatResources()
	return {
		"ui/views/burygame/burygameeggview.prefab"
	}
end

function CopyBuryGameEggViewPresentor:buildViews()
	return {
		CopyBuryGameEggView.New()
	}
end

return CopyBuryGameEggViewPresentor
