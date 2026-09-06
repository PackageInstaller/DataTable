-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingroad/view/KRMissionViewPresentor.lua

module("logic.extensions.kingroad.view.KRMissionViewPresentor", package.seeall)

local KRMissionViewPresentor = class("KRMissionViewPresentor", MissionViewPresentor)

function KRMissionViewPresentor:ctor()
	KRMissionViewPresentor.super.ctor(self)
end

function KRMissionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KRMissionViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/missionview.prefab",
		self:_addCommonRes()
	}
end

function KRMissionViewPresentor:buildViews()
	return {
		KRMissionView.New(),
		FormationRightView.New(),
		FormationLeftView.New(),
		KRMissionFmtView.New()
	}
end

function KRMissionViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return KRMissionViewPresentor
