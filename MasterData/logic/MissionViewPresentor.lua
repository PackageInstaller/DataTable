-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/MissionViewPresentor.lua

module(..., package.seeall)

local MissionViewPresentor = class("MissionViewPresentor", ViewWithGuidePresentor)

MissionViewPresentor.RecPosItem = "ui/views/challenge/recpositem.prefab"
MissionViewPresentor.RestrainItem = "ui/views/challenge/restrainitem.prefab"
MissionViewPresentor.AtkSelfItem = "ui/views/challenge/atkselfitem.prefab"
MissionViewPresentor.AtkEnemyItem = "ui/views/challenge/atkenemyitem.prefab"

function MissionViewPresentor:ctor()
	MissionViewPresentor.super.ctor(self)
end

function MissionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MissionViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/missionview.prefab",
		self:_addCommonRes()
	}
end

function MissionViewPresentor:_addCommonRes()
	local commonRes = {
		MissionViewPresentor.RecPosItem,
		MissionViewPresentor.RestrainItem,
		MissionViewPresentor.AtkSelfItem,
		MissionViewPresentor.AtkEnemyItem
	}

	return unpack(commonRes)
end

function MissionViewPresentor:buildViews()
	return {
		MissionView.New(),
		FormationRightView.New(),
		FormationLeftView.New(),
		MissionFmtView.New()
	}
end

function MissionViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return MissionViewPresentor
