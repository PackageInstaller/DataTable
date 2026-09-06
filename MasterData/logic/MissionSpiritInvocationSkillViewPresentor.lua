-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/MissionSpiritInvocationSkillViewPresentor.lua

module("logic.extensions.formation.view.MissionSpiritInvocationSkillViewPresentor", package.seeall)

local MissionSpiritInvocationSkillViewPresentor = class("MissionSpiritInvocationSkillViewPresentor", ViewPresentor)

function MissionSpiritInvocationSkillViewPresentor:ctor()
	MissionSpiritInvocationSkillViewPresentor.super.ctor(self)
end

function MissionSpiritInvocationSkillViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function MissionSpiritInvocationSkillViewPresentor:dependWhatResources()
	return {
		"ui/views/formation/missionspiritinvocationskillview.prefab"
	}
end

function MissionSpiritInvocationSkillViewPresentor:buildViews()
	return {
		MissionSpiritInvocationSkillView.New()
	}
end

return MissionSpiritInvocationSkillViewPresentor
