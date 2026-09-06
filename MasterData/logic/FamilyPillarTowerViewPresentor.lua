-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/view/war/FamilyPillarTowerViewPresentor.lua

module("logic.extensions.newfamily.view.war.FamilyPillarTowerViewPresentor", package.seeall)

local FamilyPillarTowerViewPresentor = class("FamilyPillarTowerViewPresentor", ViewPresentor)

function FamilyPillarTowerViewPresentor:ctor()
	FamilyPillarTowerViewPresentor.super.ctor(self)
end

function FamilyPillarTowerViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FamilyPillarTowerViewPresentor:dependWhatResources()
	return {
		"ui/views/newfamily/war/familypillartowerview.prefab"
	}
end

function FamilyPillarTowerViewPresentor:buildViews()
	return {
		FamilyPillarTowerView.New()
	}
end

return FamilyPillarTowerViewPresentor
