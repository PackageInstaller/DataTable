-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/community/CutePetCommunityPublishViewPresentor.lua

module("logic.extensions.cutepet.view.CutePetCommunityPublishViewPresentor", package.seeall)

local CutePetCommunityPublishViewPresentor = class("CutePetCommunityPublishViewPresentor", ViewPresentor)

function CutePetCommunityPublishViewPresentor:ctor()
	CutePetCommunityPublishViewPresentor.super.ctor(self)
end

function CutePetCommunityPublishViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CutePetCommunityPublishViewPresentor:dependWhatResources()
	return {
		"ui/views/cutepet/cutepetcommunitypublishview.prefab"
	}
end

function CutePetCommunityPublishViewPresentor:buildViews()
	return {
		CutePetCommunityPublishView.New()
	}
end

return CutePetCommunityPublishViewPresentor
