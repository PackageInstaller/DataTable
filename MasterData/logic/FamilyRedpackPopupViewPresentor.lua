-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/view/FamilyRedpackPopupViewPresentor.lua

module("logic.extensions.family.view.FamilyRedpackPopupViewPresentor", package.seeall)

local FamilyRedpackPopupViewPresentor = class("FamilyRedpackPopupViewPresentor", ViewWithGuidePresentor)

function FamilyRedpackPopupViewPresentor:ctor()
	FamilyRedpackPopupViewPresentor.super.ctor(self)
end

function FamilyRedpackPopupViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FamilyRedpackPopupViewPresentor:dependWhatResources()
	return {
		"ui/views/family/familyredpackpopupview.prefab"
	}
end

function FamilyRedpackPopupViewPresentor:buildViews()
	return {
		FamilyRedpackPopupView.New()
	}
end

return FamilyRedpackPopupViewPresentor
