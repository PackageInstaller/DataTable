-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/MissionDomainSkillsViewPresentor.lua

module("logic.extensions.mission.view.MissionDomainSkillsViewPresentor", package.seeall)

local MissionDomainSkillsViewPresentor = class("MissionDomainSkillsViewPresentor", ViewPresentor)

function MissionDomainSkillsViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function MissionDomainSkillsViewPresentor:dependWhatResources()
	return {
		"ui/views/formation/missiondomainskillsview.prefab"
	}
end

function MissionDomainSkillsViewPresentor:buildViews()
	return {
		MissionDomainSkillsView.New()
	}
end

return MissionDomainSkillsViewPresentor
