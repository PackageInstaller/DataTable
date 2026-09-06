-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/view/war/FamilyWarFmtViewPresentor.lua

module("logic.extensions.newfamily.view.war.FamilyWarFmtViewPresentor", package.seeall)

local FamilyWarFmtViewPresentor = class("FamilyWarFmtViewPresentor", ViewPresentor)

function FamilyWarFmtViewPresentor:ctor()
	FamilyWarFmtViewPresentor.super.ctor(self)
end

function FamilyWarFmtViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FamilyWarFmtViewPresentor:dependWhatResources()
	return {
		"ui/views/formation/formationview.prefab"
	}
end

function FamilyWarFmtViewPresentor:buildViews()
	return {
		BuzhenLeftView.New(),
		FormationRightView.New(),
		FamilyWarFmtView.New(true)
	}
end

return FamilyWarFmtViewPresentor
