-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/view/FamilyRedpackViewPresentor.lua

module("logic.extensions.family.view.FamilyRedpackViewPresentor", package.seeall)

local FamilyRedpackViewPresentor = class("FamilyRedpackViewPresentor", ViewPresentor)

function FamilyRedpackViewPresentor:ctor()
	FamilyRedpackViewPresentor.super.ctor(self)
end

function FamilyRedpackViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FamilyRedpackViewPresentor:dependWhatResources()
	return {
		"ui/views/family/familyredpackview.prefab"
	}
end

function FamilyRedpackViewPresentor:buildViews()
	return {
		FamilyRedpackView.New()
	}
end

return FamilyRedpackViewPresentor
