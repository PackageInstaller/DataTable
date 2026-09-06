-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/view/FamilyTaskViewPresentor.lua

module("logic.extensions.newfamily.view.FamilyTaskViewPresentor", package.seeall)

local FamilyTaskViewPresentor = class("FamilyTaskViewPresentor", ViewPresentor)

function FamilyTaskViewPresentor:ctor()
	FamilyTaskViewPresentor.super.ctor(self)
end

function FamilyTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FamilyTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/newfamily/familytaskview.prefab"
	}
end

function FamilyTaskViewPresentor:buildViews()
	return {
		FamilyTaskView.New()
	}
end

return FamilyTaskViewPresentor
