-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/view/war/FamilySeasonAwardNewViewPresentor.lua

module("logic.extensions.newfamily.view.war.FamilySeasonAwardNewViewPresentor", package.seeall)

local FamilySeasonAwardNewViewPresentor = class("FamilySeasonAwardNewViewPresentor", ViewPresentor)

function FamilySeasonAwardNewViewPresentor:ctor()
	FamilySeasonAwardNewViewPresentor.super.ctor(self)
end

function FamilySeasonAwardNewViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FamilySeasonAwardNewViewPresentor:dependWhatResources()
	return {
		"ui/views/newfamily/war/familyseasonawardnewview.prefab"
	}
end

function FamilySeasonAwardNewViewPresentor:buildViews()
	return {
		FamilySeasonAwardNewView.New()
	}
end

return FamilySeasonAwardNewViewPresentor
