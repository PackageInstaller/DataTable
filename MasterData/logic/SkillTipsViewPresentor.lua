-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/instruction/view/SkillTipsViewPresentor.lua

module("logic.extensions.common.instruction.view.SkillTipsViewPresentor", package.seeall)

local SkillTipsViewPresentor = class("SkillTipsViewPresentor", ViewPresentor)

function SkillTipsViewPresentor:ctor()
	SkillTipsViewPresentor.super.ctor(self)
end

function SkillTipsViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SkillTipsViewPresentor:dependWhatResources()
	return {
		"ui/views/common/skill_tips.prefab"
	}
end

function SkillTipsViewPresentor:buildViews()
	return {
		SkillTipsView.New()
	}
end

return SkillTipsViewPresentor
