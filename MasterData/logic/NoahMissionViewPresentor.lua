-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/noahchallenge/view/NoahMissionViewPresentor.lua

module("logic.extensions.noahchallenge.view.NoahMissionViewPresentor", package.seeall)

local NoahMissionViewPresentor = class("NoahMissionViewPresentor", MissionViewPresentor)

function NoahMissionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NoahMissionViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/missionview.prefab",
		self:_addCommonRes()
	}
end

function NoahMissionViewPresentor:buildViews()
	return {
		NoahMissionView.New(),
		NoahFormationRightView.New(),
		NoahFormationLeftView.New(),
		NoahMissionFmtView.New()
	}
end

return NoahMissionViewPresentor
