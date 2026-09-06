-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonkingaruishihud/view/SkillMatchGameViewPresentor.lua

module("logic.extensions.dragonkingaruishihud.view.SkillMatchGameViewPresentor", package.seeall)

local SkillMatchGameViewPresentor = class("SkillMatchGameViewPresentor", ViewPresentor)

function SkillMatchGameViewPresentor:ctor()
	SkillMatchGameViewPresentor.super.ctor(self)
end

function SkillMatchGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SkillMatchGameViewPresentor:dependWhatResources()
	return {
		"ui/views/dragonkingaruishihud/skillmatchgameview.prefab"
	}
end

function SkillMatchGameViewPresentor:buildViews()
	return {
		SkillMatchGameView.New()
	}
end

return SkillMatchGameViewPresentor
