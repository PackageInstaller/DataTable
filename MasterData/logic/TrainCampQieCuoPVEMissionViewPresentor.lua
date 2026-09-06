-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/traincampqiecuo/view/TrainCampQieCuoPVEMissionViewPresentor.lua

module("logic.extensions.traincampqiecuo.view.PkmissionViewPresentor", package.seeall)

local TrainCampQieCuoPVEMissionViewPresentor = class("TrainCampQieCuoPVEMissionViewPresentor", MissionViewPresentor)

TrainCampQieCuoPVEMissionViewPresentor.ExtViewPrefab = "ui/views/traincampqiecuo/traincampqiecuomissionview.prefab"

function TrainCampQieCuoPVEMissionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TrainCampQieCuoPVEMissionViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/missionview.prefab",
		TrainCampQieCuoPVEMissionViewPresentor.ExtViewPrefab,
		MissionViewPresentor.RecPosItem,
		MissionViewPresentor.AtkSelfItem,
		self:_addCommonRes()
	}
end

function TrainCampQieCuoPVEMissionViewPresentor:buildViews()
	return {
		TrainCampQieCuoPVEMissionView.New(),
		TrainCampQieCuoPVEMissionRightView.New(),
		TrainCampQieCuoPVEMissionLeftView.New(),
		TrainCampQieCuoPVEMissionFmtView.New()
	}
end

return TrainCampQieCuoPVEMissionViewPresentor
