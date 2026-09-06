-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/view/war/FamilyPillarSignViewPresentor.lua

module("logic.extensions.newfamily.view.war.FamilyPillarSignViewPresentor", package.seeall)

local FamilyPillarSignViewPresentor = class("FamilyPillarSignViewPresentor", ViewPresentor)

function FamilyPillarSignViewPresentor:ctor()
	FamilyPillarSignViewPresentor.super.ctor(self)
end

function FamilyPillarSignViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FamilyPillarSignViewPresentor:dependWhatResources()
	return {
		"ui/views/newfamily/war/familypillarsignview.prefab"
	}
end

function FamilyPillarSignViewPresentor:buildViews()
	return {
		FamilyPillarSignView.New()
	}
end

return FamilyPillarSignViewPresentor
