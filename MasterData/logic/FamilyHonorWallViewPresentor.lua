-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/view/FamilyHonorWallViewPresentor.lua

module("logic.extensions.newfamily.view.FamilyHonorWallViewPresentor", package.seeall)

local FamilyHonorWallViewPresentor = class("FamilyHonorWallViewPresentor", ViewPresentor)

function FamilyHonorWallViewPresentor:ctor()
	FamilyHonorWallViewPresentor.super.ctor(self)
end

function FamilyHonorWallViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FamilyHonorWallViewPresentor:dependWhatResources()
	return {
		"ui/views/newfamily/honor/familyhonorwallview.prefab"
	}
end

function FamilyHonorWallViewPresentor:buildViews()
	return {
		FamilyHonorWallView.New()
	}
end

return FamilyHonorWallViewPresentor
