-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/view/war/FamilyWarSeasonViewPresentor.lua

module("logic.extensions.newfamily.view.war.FamilyWarSeasonViewPresentor", package.seeall)

local FamilyWarSeasonViewPresentor = class("FamilyWarSeasonViewPresentor", ViewPresentor)

function FamilyWarSeasonViewPresentor:ctor()
	FamilyWarSeasonViewPresentor.super.ctor(self)
end

function FamilyWarSeasonViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FamilyWarSeasonViewPresentor:dependWhatResources()
	return {
		"ui/views/newfamily/war/familywarseasonview.prefab"
	}
end

function FamilyWarSeasonViewPresentor:buildViews()
	return {
		FamilyWarSeasonView.New()
	}
end

return FamilyWarSeasonViewPresentor
