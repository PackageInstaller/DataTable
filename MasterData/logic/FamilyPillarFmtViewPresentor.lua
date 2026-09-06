-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/view/war/FamilyPillarFmtViewPresentor.lua

module("logic.extensions.newfamily.view.war.FamilyPillarFmtViewPresentor", package.seeall)

local FamilyPillarFmtViewPresentor = class("FamilyPillarFmtViewPresentor", MissionViewPresentor)

function FamilyPillarFmtViewPresentor:ctor()
	FamilyPillarFmtViewPresentor.super.ctor(self)
end

function FamilyPillarFmtViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FamilyPillarFmtViewPresentor:dependWhatResources()
	return {
		"ui/views/arena/arenafmtview.prefab",
		self:_addCommonRes()
	}
end

function FamilyPillarFmtViewPresentor:buildViews()
	return {
		ArenaDefFmtView.New(),
		FamilyPillarMissionFmtView.New()
	}
end

return FamilyPillarFmtViewPresentor
