-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/plotcopy/view/CopyMissionViewPresentor.lua

module("logic.extensions.plotcopy.view.CopyMissionViewPresentor", package.seeall)

local CopyMissionViewPresentor = class("CopyMissionViewPresentor", MissionViewPresentor)

function CopyMissionViewPresentor:ctor()
	CopyMissionViewPresentor.super.ctor(self)
end

function CopyMissionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CopyMissionViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/missionview.prefab",
		self:_addCommonRes()
	}
end

function CopyMissionViewPresentor:buildViews()
	return {
		CopyMissionView.New(),
		CopyFormationRightView.New(),
		CopyFormationLeftView.New(),
		CopyMissionFmtView.New()
	}
end

function CopyMissionViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return CopyMissionViewPresentor
