-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/view/FamilyHonorListViewPresentor.lua

module("logic.extensions.newfamily.view.FamilyHonorListViewPresentor", package.seeall)

local FamilyHonorListViewPresentor = class("FamilyHonorListViewPresentor", ViewPresentor)

function FamilyHonorListViewPresentor:ctor()
	FamilyHonorListViewPresentor.super.ctor(self)
end

function FamilyHonorListViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FamilyHonorListViewPresentor:dependWhatResources()
	return {
		"ui/views/newfamily/honor/familyhonorlistview.prefab"
	}
end

function FamilyHonorListViewPresentor:buildViews()
	return {
		FamilyHonorListView.New()
	}
end

return FamilyHonorListViewPresentor
