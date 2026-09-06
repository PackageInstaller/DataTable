-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/view/war/FamilyWarPillarViewPresentor.lua

module("logic.extensions.newfamily.view.war.FamilyWarPillarViewPresentor", package.seeall)

local FamilyWarPillarViewPresentor = class("FamilyWarPillarViewPresentor", ViewPresentor)

function FamilyWarPillarViewPresentor:ctor()
	FamilyWarPillarViewPresentor.super.ctor(self)
end

function FamilyWarPillarViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FamilyWarPillarViewPresentor:dependWhatResources()
	return {
		"ui/views/newfamily/war/familywarpillarview.prefab"
	}
end

function FamilyWarPillarViewPresentor:buildViews()
	return {
		FamilyWarPillarView.New()
	}
end

return FamilyWarPillarViewPresentor
