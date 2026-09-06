-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyscene/view/FamilySceneChannelsViewPresentor.lua

module("logic.extensions.familyscene.view.FamilySceneChannelsViewPresentor", package.seeall)

local FamilySceneChannelsViewPresentor = class("FamilySceneChannelsViewPresentor", ViewPresentor)

function FamilySceneChannelsViewPresentor:ctor()
	FamilySceneChannelsViewPresentor.super.ctor(self)
end

function FamilySceneChannelsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FamilySceneChannelsViewPresentor:dependWhatResources()
	return {
		"ui/views/familyscene/view/familyscenechannelsview.prefab"
	}
end

function FamilySceneChannelsViewPresentor:buildViews()
	return {
		FamilySceneChannelsView.New()
	}
end

return FamilySceneChannelsViewPresentor
