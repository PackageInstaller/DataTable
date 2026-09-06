-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/view/war/FamilyNestTowerViewPresentor.lua

module("logic.extensions.newfamily.view.war.FamilyNestTowerViewPresentor", package.seeall)

local FamilyNestTowerViewPresentor = class("FamilyNestTowerViewPresentor", ViewPresentor)

function FamilyNestTowerViewPresentor:ctor()
	FamilyNestTowerViewPresentor.super.ctor(self)
end

function FamilyNestTowerViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FamilyNestTowerViewPresentor:dependWhatResources()
	return {
		"ui/views/newfamily/war/familynesttowerview.prefab"
	}
end

function FamilyNestTowerViewPresentor:buildViews()
	return {
		FamilyNestTowerView.New()
	}
end

return FamilyNestTowerViewPresentor
