-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/view/war/FamilyPillarRankViewPresentor.lua

module("logic.extensions.newfamily.view.war.FamilyPillarRankViewPresentor", package.seeall)

local FamilyPillarRankViewPresentor = class("FamilyPillarRankViewPresentor", ViewPresentor)

function FamilyPillarRankViewPresentor:ctor()
	FamilyPillarRankViewPresentor.super.ctor(self)
end

function FamilyPillarRankViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FamilyPillarRankViewPresentor:dependWhatResources()
	return {
		"ui/views/newfamily/war/familypillarrankview.prefab"
	}
end

function FamilyPillarRankViewPresentor:buildViews()
	return {
		FamilyPillarRankView.New()
	}
end

return FamilyPillarRankViewPresentor
