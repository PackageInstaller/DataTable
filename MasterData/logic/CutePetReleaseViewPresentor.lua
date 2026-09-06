-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/CutePetReleaseViewPresentor.lua

module("logic.extensions.cutepet.view.CutePetReleaseViewPresentor", package.seeall)

local CutePetReleaseViewPresentor = class("CutePetReleaseViewPresentor", ViewPresentor)

function CutePetReleaseViewPresentor:ctor()
	CutePetReleaseViewPresentor.super.ctor(self)
end

function CutePetReleaseViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CutePetReleaseViewPresentor:dependWhatResources()
	return {
		"ui/views/cutepet/cutepetreleaseview.prefab"
	}
end

function CutePetReleaseViewPresentor:buildViews()
	return {
		CutePetReleaseView.New()
	}
end

return CutePetReleaseViewPresentor
