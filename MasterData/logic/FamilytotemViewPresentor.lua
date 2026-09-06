-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/view/FamilytotemViewPresentor.lua

module("logic.extensions.family.view.FamilytotemViewPresentor", package.seeall)

local FamilytotemViewPresentor = class("FamilytotemViewPresentor", ViewPresentor)

function FamilytotemViewPresentor:ctor()
	FamilytotemViewPresentor.super.ctor(self)
end

function FamilytotemViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FamilytotemViewPresentor:dependWhatResources()
	return {
		"ui/views/family/familytotemview.prefab"
	}
end

function FamilytotemViewPresentor:buildViews()
	return {
		FamilytotemView.New()
	}
end

return FamilytotemViewPresentor
