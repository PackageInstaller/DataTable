-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/view/FamilyIconViewPresentor.lua

module("logic.extensions.family.view.FamilyIconViewPresentor", package.seeall)

local FamilyIconViewPresentor = class("FamilyIconViewPresentor", ViewPresentor)

function FamilyIconViewPresentor:ctor()
	FamilyIconViewPresentor.super.ctor(self)
end

function FamilyIconViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FamilyIconViewPresentor:dependWhatResources()
	return {
		"ui/views/family/familyiconview.prefab"
	}
end

function FamilyIconViewPresentor:buildViews()
	return {
		FamilyIconView.New()
	}
end

return FamilyIconViewPresentor
