-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/MonsterMissionViewPresentor.lua

module(..., package.seeall)

local MonsterMissionViewPresentor = class("MonsterMissionViewPresentor", MissionViewPresentor)

function MonsterMissionViewPresentor:ctor()
	MonsterMissionViewPresentor.super.ctor(self)
end

function MonsterMissionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MonsterMissionViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/missionview.prefab",
		self:_addCommonRes()
	}
end

function MonsterMissionViewPresentor:buildViews()
	return {
		MonsterMissionView.New(),
		FormationRightView.New(),
		FormationLeftView.New(),
		MonsterMissionFmtView.New()
	}
end

function MonsterMissionViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return MonsterMissionViewPresentor
