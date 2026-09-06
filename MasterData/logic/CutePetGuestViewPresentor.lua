-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/CutePetGuestViewPresentor.lua

module("logic.extensions.cutepet.view.CutePetGuestViewPresentor", package.seeall)

local CutePetGuestViewPresentor = class("CutePetGuestViewPresentor", ViewWithGuidePresentor)

function CutePetGuestViewPresentor:ctor()
	CutePetGuestViewPresentor.super.ctor(self)
end

function CutePetGuestViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CutePetGuestViewPresentor:dependWhatResources()
	return {
		"ui/views/cutepet/cutepetguestview.prefab"
	}
end

function CutePetGuestViewPresentor:buildViews()
	return {
		CutePetGuestView.New()
	}
end

return CutePetGuestViewPresentor
