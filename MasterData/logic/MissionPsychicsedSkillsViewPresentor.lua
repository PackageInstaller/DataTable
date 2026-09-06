-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/MissionPsychicsedSkillsViewPresentor.lua

module("logic.extensions.mission.view.MissionPsychicsedSkillsViewPresentor", package.seeall)

local MissionPsychicsedSkillsViewPresentor = class("MissionPsychicsedSkillsViewPresentor", ViewWithGuidePresentor)

function MissionPsychicsedSkillsViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function MissionPsychicsedSkillsViewPresentor:dependWhatResources()
	return {
		"ui/views/formation/missionpsychicsedskillsview.prefab"
	}
end

function MissionPsychicsedSkillsViewPresentor:buildViews()
	return {
		MissionPsychicsedSkillsView.New()
	}
end

return MissionPsychicsedSkillsViewPresentor
