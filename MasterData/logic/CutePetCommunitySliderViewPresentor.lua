-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/community/CutePetCommunitySliderViewPresentor.lua

module("logic.extensions.cutepet.view.CutePetCommunitySliderViewPresentor", package.seeall)

local CutePetCommunitySliderViewPresentor = class("CutePetCommunitySliderViewPresentor", ViewPresentor)

function CutePetCommunitySliderViewPresentor:ctor()
	CutePetCommunitySliderViewPresentor.super.ctor(self)
end

function CutePetCommunitySliderViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CutePetCommunitySliderViewPresentor:dependWhatResources()
	return {
		"ui/views/cutepet/cutepetcommunitysliderview.prefab"
	}
end

function CutePetCommunitySliderViewPresentor:buildViews()
	return {
		CutePetCommunitySliderView.New()
	}
end

return CutePetCommunitySliderViewPresentor
