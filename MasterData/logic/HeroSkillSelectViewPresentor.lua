-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/view/HeroSkillSelectViewPresentor.lua

module("logic.extensions.formation.view.HeroSkillSelectViewPresentor", package.seeall)

local HeroSkillSelectViewPresentor = class("HeroSkillSelectViewPresentor", ViewPresentor)

function HeroSkillSelectViewPresentor:ctor()
	HeroSkillSelectViewPresentor.super.ctor(self)
end

function HeroSkillSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HeroSkillSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/formation/heroskillselectview.prefab"
	}
end

function HeroSkillSelectViewPresentor:buildViews()
	return {
		HeroSkillSelectView.New()
	}
end

return HeroSkillSelectViewPresentor
