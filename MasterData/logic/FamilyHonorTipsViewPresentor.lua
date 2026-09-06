-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/view/FamilyHonorTipsViewPresentor.lua

module("logic.extensions.newfamily.view.FamilyHonorTipsViewPresentor", package.seeall)

local FamilyHonorTipsViewPresentor = class("FamilyHonorTipsViewPresentor", ViewPresentor)

function FamilyHonorTipsViewPresentor:ctor()
	FamilyHonorTipsViewPresentor.super.ctor(self)
end

function FamilyHonorTipsViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FamilyHonorTipsViewPresentor:dependWhatResources()
	return {
		"ui/views/newfamily/honor/familyhonortipsview.prefab"
	}
end

function FamilyHonorTipsViewPresentor:buildViews()
	return {
		FamilyHonorTipsView.New()
	}
end

return FamilyHonorTipsViewPresentor
