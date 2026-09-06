-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/view/FamilySettingViewPresentor.lua

module("logic.extensions.family.view.FamilySettingViewPresentor", package.seeall)

local FamilySettingViewPresentor = class("FamilySettingViewPresentor", ViewPresentor)

function FamilySettingViewPresentor:ctor()
	FamilySettingViewPresentor.super.ctor(self)
end

function FamilySettingViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FamilySettingViewPresentor:dependWhatResources()
	return {
		"ui/views/family/familysettingview.prefab"
	}
end

function FamilySettingViewPresentor:buildViews()
	return {
		FamilySettingView.New()
	}
end

return FamilySettingViewPresentor
