-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonkingaruishihud/view/SkillMatchMainViewPresentor.lua

module("logic.extensions.dragonkingaruishihud.view.SkillMatchMainViewPresentor", package.seeall)

local SkillMatchMainViewPresentor = class("SkillMatchMainViewPresentor", ViewPresentor)

function SkillMatchMainViewPresentor:ctor()
	SkillMatchMainViewPresentor.super.ctor(self)
end

function SkillMatchMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SkillMatchMainViewPresentor:dependWhatResources()
	return {
		"ui/views/dragonkingaruishihud/skillmatchmainview.prefab"
	}
end

function SkillMatchMainViewPresentor:buildViews()
	return {
		SkillMatchMainView.New()
	}
end

return SkillMatchMainViewPresentor
