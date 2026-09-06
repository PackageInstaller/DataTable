-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/view/FamilyHonorExhibitViewPresentor.lua

module("logic.extensions.newfamily.view.FamilyHonorExhibitViewPresentor", package.seeall)

local FamilyHonorExhibitViewPresentor = class("FamilyHonorExhibitViewPresentor", ViewPresentor)

function FamilyHonorExhibitViewPresentor:ctor()
	FamilyHonorExhibitViewPresentor.super.ctor(self)
end

function FamilyHonorExhibitViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FamilyHonorExhibitViewPresentor:dependWhatResources()
	return {
		"ui/views/newfamily/honor/familyhonorexhibitview.prefab"
	}
end

function FamilyHonorExhibitViewPresentor:buildViews()
	return {
		FamilyHonorExhibitView.New()
	}
end

return FamilyHonorExhibitViewPresentor
