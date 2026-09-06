-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/view/war/FamilyWarReplaceViewPresentor.lua

module("logic.extensions.newfamily.view.war.FamilyWarReplaceViewPresentor", package.seeall)

local FamilyWarReplaceViewPresentor = class("FamilyWarReplaceViewPresentor", ViewPresentor)

function FamilyWarReplaceViewPresentor:ctor()
	FamilyWarReplaceViewPresentor.super.ctor(self)
end

function FamilyWarReplaceViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FamilyWarReplaceViewPresentor:dependWhatResources()
	return {
		"ui/views/newfamily/war/familywarreplaceview.prefab"
	}
end

function FamilyWarReplaceViewPresentor:buildViews()
	return {
		FamilyWarReplaceView.New()
	}
end

return FamilyWarReplaceViewPresentor
