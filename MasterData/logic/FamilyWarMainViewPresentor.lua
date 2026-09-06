-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/view/war/FamilyWarMainViewPresentor.lua

module("logic.extensions.newfamily.view.war.FamilyWarMainViewPresentor", package.seeall)

local FamilyWarMainViewPresentor = class("FamilyWarMainViewPresentor", ViewPresentor)

function FamilyWarMainViewPresentor:ctor()
	FamilyWarMainViewPresentor.super.ctor(self)
end

function FamilyWarMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FamilyWarMainViewPresentor:dependWhatResources()
	return {
		"ui/views/newfamily/war/familywarmainview.prefab"
	}
end

function FamilyWarMainViewPresentor:buildViews()
	return {
		FamilyWarMainView.New()
	}
end

return FamilyWarMainViewPresentor
