-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitefuture/view/InfinfumissionViewPresentor.lua

module("logic.extensions.infinitefuture.view.InfinfumissionViewPresentor", package.seeall)

local InfinfumissionViewPresentor = class("InfinfumissionViewPresentor", MissionViewPresentor)

function InfinfumissionViewPresentor:ctor()
	InfinfumissionViewPresentor.super.ctor(self)
end

function InfinfumissionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function InfinfumissionViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/missionview.prefab",
		self:_addCommonRes()
	}
end

function InfinfumissionViewPresentor:buildViews()
	return {
		InfinfuMissionView.New(),
		InfinfuMissionFmtRightView.New(),
		InfinfuMissionFmtLeftView.New(),
		InfinfuMissionFmtView.New()
	}
end

function InfinfumissionViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return InfinfumissionViewPresentor
