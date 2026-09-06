-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyhoundingclg/view/FamilyHoudingClgMainViewPresentor.lua

module("logic.extensions.familyhoundingclg.view.FamilyHoudingClgMainViewPresentor", package.seeall)

local FamilyHoudingClgMainViewPresentor = class("FamilyHoudingClgMainViewPresentor", ViewPresentor)

function FamilyHoudingClgMainViewPresentor:ctor()
	FamilyHoudingClgMainViewPresentor.super.ctor(self)
end

function FamilyHoudingClgMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FamilyHoudingClgMainViewPresentor:dependWhatResources()
	return {
		"ui/views/familyhoundingclg/familyhoudingclgmainview.prefab"
	}
end

function FamilyHoudingClgMainViewPresentor:buildViews()
	return {
		FamilyHoudingClgMainView.New()
	}
end

return FamilyHoudingClgMainViewPresentor
