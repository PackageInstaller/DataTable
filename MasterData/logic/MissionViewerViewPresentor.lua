-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/MissionViewerViewPresentor.lua

module(..., package.seeall)

local MissionViewerViewPresentor = class("MissionViewerViewPresentor", ViewPresentor)

function MissionViewerViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function MissionViewerViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/missionviewerview.prefab"
	}
end

function MissionViewerViewPresentor:buildViews()
	return {
		MissionViewerView.New()
	}
end

return MissionViewerViewPresentor
