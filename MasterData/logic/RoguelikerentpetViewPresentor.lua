-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/RoguelikerentpetViewPresentor.lua

module("logic.extensions.roguelike.view.RoguelikerentpetViewPresentor", package.seeall)

local RoguelikerentpetViewPresentor = class("RoguelikerentpetViewPresentor", ViewPresentor)

function RoguelikerentpetViewPresentor:ctor()
	RoguelikerentpetViewPresentor.super.ctor(self)
end

function RoguelikerentpetViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RoguelikerentpetViewPresentor:dependWhatResources()
	return {
		"ui/views/roguelike/roguelikerentpetview.prefab"
	}
end

function RoguelikerentpetViewPresentor:buildViews()
	return {
		RoguelikerentpetView.New()
	}
end

return RoguelikerentpetViewPresentor
