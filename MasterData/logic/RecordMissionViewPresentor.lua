-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlerecord/view/RecordMissionViewPresentor.lua

module(..., package.seeall)

local RecordMissionViewPresentor = class("RecordMissionViewPresentor", MissionViewPresentor)

function RecordMissionViewPresentor:ctor()
	RecordMissionViewPresentor.super.ctor(self)
end

function RecordMissionViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function RecordMissionViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/missionview.prefab",
		self:_addCommonRes()
	}
end

function RecordMissionViewPresentor:buildViews()
	return {
		RecordMissionView.New(),
		RecordFormationLeftView.New(),
		RecordMissionFmtView.New()
	}
end

function RecordMissionViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return RecordMissionViewPresentor
