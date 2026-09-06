-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/view/FamilybossPresentor.lua

module("logic.extensions.family.view.FamilybossPresentor", package.seeall)

local FamilybossPresentor = class("FamilybossPresentor", ViewPresentor)

function FamilybossPresentor:ctor()
	FamilybossPresentor.super.ctor(self)
end

function FamilybossPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FamilybossPresentor:dependWhatResources()
	return {
		"ui/views/family/familybossview.prefab"
	}
end

function FamilybossPresentor:buildViews()
	return {
		FamilybossView.New()
	}
end

return FamilybossPresentor
