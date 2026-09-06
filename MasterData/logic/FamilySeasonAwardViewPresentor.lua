-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/view/war/FamilySeasonAwardViewPresentor.lua

module("logic.extensions.newfamily.view.war.FamilySeasonAwardViewPresentor", package.seeall)

local FamilySeasonAwardViewPresentor = class("FamilySeasonAwardViewPresentor", ViewPresentor)

function FamilySeasonAwardViewPresentor:ctor()
	FamilySeasonAwardViewPresentor.super.ctor(self)
end

function FamilySeasonAwardViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FamilySeasonAwardViewPresentor:dependWhatResources()
	return {
		"ui/views/newfamily/war/familyseasonawardview.prefab"
	}
end

function FamilySeasonAwardViewPresentor:buildViews()
	return {
		FamilySeasonAwardView.New()
	}
end

return FamilySeasonAwardViewPresentor
