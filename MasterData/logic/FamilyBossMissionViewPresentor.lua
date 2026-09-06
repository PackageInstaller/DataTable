-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/view/FamilyBossMissionViewPresentor.lua

module("logic.extensions.family.view.FamilyBossMissionViewPresentor", package.seeall)

local FamilyBossMissionViewPresentor = class("FamilyBossMissionViewPresentor", MissionViewPresentor)

function FamilyBossMissionViewPresentor:ctor()
	FamilyBossMissionViewPresentor.super.ctor(self)
end

function FamilyBossMissionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FamilyBossMissionViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/missionview.prefab",
		self:_addCommonRes()
	}
end

function FamilyBossMissionViewPresentor:buildViews()
	return {
		FamilyBossMissionView.New(),
		FamilyBossRightView.New(),
		FamilyBossLeftView.New(),
		FamilyBossMissionFmtView.New()
	}
end

function FamilyBossMissionViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return FamilyBossMissionViewPresentor
