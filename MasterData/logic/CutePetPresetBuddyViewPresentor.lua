-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/CutePetPresetBuddyViewPresentor.lua

module("logic.extensions.cutepet.view.CutePetPresetBuddyViewPresentor", package.seeall)

local CutePetPresetBuddyViewPresentor = class("CutePetPresetBuddyViewPresentor", ViewPresentor)

function CutePetPresetBuddyViewPresentor:ctor()
	CutePetPresetBuddyViewPresentor.super.ctor(self)
end

function CutePetPresetBuddyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CutePetPresetBuddyViewPresentor:dependWhatResources()
	return {
		"ui/views/cutepet/cutepetpresetbuddyview.prefab"
	}
end

function CutePetPresetBuddyViewPresentor:buildViews()
	return {
		CutePetPresetBuddyView.New()
	}
end

return CutePetPresetBuddyViewPresentor
