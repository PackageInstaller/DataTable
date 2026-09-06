-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/showInfo/CutePetStarUpShowViewPresentor.lua

module("logic.extensions.cutepet.view.CutePetStarUpShowViewPresentor", package.seeall)

local CutePetStarUpShowViewPresentor = class("CutePetStarUpShowViewPresentor", ViewPresentor)

function CutePetStarUpShowViewPresentor:ctor()
	CutePetStarUpShowViewPresentor.super.ctor(self)
end

function CutePetStarUpShowViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CutePetStarUpShowViewPresentor:dependWhatResources()
	return {
		"ui/views/cutepet/cutepetstarupshowview.prefab"
	}
end

function CutePetStarUpShowViewPresentor:buildViews()
	return {
		CutePetStarUpShowView.New()
	}
end

return CutePetStarUpShowViewPresentor
