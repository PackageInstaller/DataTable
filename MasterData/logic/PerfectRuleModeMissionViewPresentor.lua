-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/perfectrulemode/mission/PerfectRuleModeMissionViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.perfectrulemode.mission.PerfectRuleModeMissionViewPresentor", package.seeall)

local PerfectRuleModeMissionViewPresentor = class("PerfectRuleModeMissionViewPresentor", MissionViewPresentor)

function PerfectRuleModeMissionViewPresentor:buildViews()
	return {
		PerfectRuleModeMissionView.New(),
		PerfectRuleModeFmtRightView.New(),
		PerfectRuleModeFmtLeftView.New(),
		PerfectRuleModeMissionFmtView.New()
	}
end

return PerfectRuleModeMissionViewPresentor
