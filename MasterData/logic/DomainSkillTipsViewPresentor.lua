-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/instruction/view/DomainSkillTipsViewPresentor.lua

module("logic.extensions.common.instruction.view.DomainSkillTipsViewPresentor", package.seeall)

local DomainSkillTipsViewPresentor = class("DomainSkillTipsViewPresentor", ViewPresentor)

function DomainSkillTipsViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DomainSkillTipsViewPresentor:dependWhatResources()
	return {
		"ui/views/common/domainskill_tips.prefab"
	}
end

function DomainSkillTipsViewPresentor:buildViews()
	return {
		DomainSkillTipsView.New()
	}
end

return DomainSkillTipsViewPresentor
