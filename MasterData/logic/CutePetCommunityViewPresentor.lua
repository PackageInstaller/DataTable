-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/community/CutePetCommunityViewPresentor.lua

module("logic.extensions.cutepet.view.CutePetCommunityViewPresentor", package.seeall)

local CutePetCommunityViewPresentor = class("CutePetCommunityViewPresentor", ViewPresentor)

function CutePetCommunityViewPresentor:ctor()
	CutePetCommunityViewPresentor.super.ctor(self)
end

function CutePetCommunityViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CutePetCommunityViewPresentor:dependWhatResources()
	return {
		"ui/views/cutepet/cutepetcommunityview.prefab"
	}
end

function CutePetCommunityViewPresentor:buildViews()
	return {
		CutePetCommunityView.New()
	}
end

return CutePetCommunityViewPresentor
