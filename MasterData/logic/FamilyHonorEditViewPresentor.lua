-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/view/FamilyHonorEditViewPresentor.lua

module("logic.extensions.newfamily.view.FamilyHonorEditViewPresentor", package.seeall)

local FamilyHonorEditViewPresentor = class("FamilyHonorEditViewPresentor", ViewPresentor)

function FamilyHonorEditViewPresentor:ctor()
	FamilyHonorEditViewPresentor.super.ctor(self)
end

function FamilyHonorEditViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FamilyHonorEditViewPresentor:dependWhatResources()
	return {
		"ui/views/newfamily/honor/familyhonoreditview.prefab"
	}
end

function FamilyHonorEditViewPresentor:buildViews()
	return {
		FamilyHonorEditView.New()
	}
end

return FamilyHonorEditViewPresentor
