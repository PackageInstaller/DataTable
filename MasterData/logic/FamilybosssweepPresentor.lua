-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/view/FamilybosssweepPresentor.lua

module("logic.extensions.family.view.FamilybosssweepPresentor", package.seeall)

local FamilybosssweepPresentor = class("FamilybosssweepPresentor", ViewPresentor)

function FamilybosssweepPresentor:ctor()
	FamilybosssweepPresentor.super.ctor(self)
end

function FamilybosssweepPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FamilybosssweepPresentor:dependWhatResources()
	return {
		"ui/views/family/familybosssweepview.prefab"
	}
end

function FamilybosssweepPresentor:buildViews()
	return {
		FamilybosssweepView.New()
	}
end

return FamilybosssweepPresentor
