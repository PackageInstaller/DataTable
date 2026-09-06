-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/RoguelikeprizeViewPresentor.lua

module("logic.extensions.roguelike.view.RoguelikeprizeViewPresentor", package.seeall)

local RoguelikeprizeViewPresentor = class("RoguelikeprizeViewPresentor", ViewPresentor)

function RoguelikeprizeViewPresentor:ctor()
	RoguelikeprizeViewPresentor.super.ctor(self)
end

function RoguelikeprizeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RoguelikeprizeViewPresentor:dependWhatResources()
	return {
		"ui/views/roguelike/roguelikeprizeview.prefab"
	}
end

function RoguelikeprizeViewPresentor:buildViews()
	return {
		RoguelikeprizeView.New()
	}
end

return RoguelikeprizeViewPresentor
