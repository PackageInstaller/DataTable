-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mirrortrial/view/MirrortrialMissionViewPresentor.lua

module("logic.extensions.Mirrortrial.view.MirrortrialMissionViewPresentor", package.seeall)

local MirrortrialMissionViewPresentor = class("MirrortrialMissionViewPresentor", MissionViewPresentor)

function MirrortrialMissionViewPresentor:ctor()
	MirrortrialMissionViewPresentor.super.ctor(self)
end

function MirrortrialMissionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MirrortrialMissionViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/missionview.prefab",
		self:_addCommonRes()
	}
end

function MirrortrialMissionViewPresentor:buildViews()
	return {
		MirrortrialMissionView.New(),
		FormationRightView.New(),
		FormationLeftView.New(),
		MirrortrialMissionFmtView.New()
	}
end

function MirrortrialMissionViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return MirrortrialMissionViewPresentor
