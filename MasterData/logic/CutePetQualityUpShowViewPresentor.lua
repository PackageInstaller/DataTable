-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/showInfo/CutePetQualityUpShowViewPresentor.lua

module("logic.extensions.cutepet.view.CutePetQualityUpShowViewPresentor", package.seeall)

local CutePetQualityUpShowViewPresentor = class("CutePetQualityUpShowViewPresentor", ViewPresentor)

function CutePetQualityUpShowViewPresentor:ctor()
	CutePetQualityUpShowViewPresentor.super.ctor(self)
end

function CutePetQualityUpShowViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CutePetQualityUpShowViewPresentor:dependWhatResources()
	return {
		"ui/views/cutepet/cutepetqualityupshowview.prefab"
	}
end

function CutePetQualityUpShowViewPresentor:buildViews()
	return {
		CutePetQualityUpShowView.New()
	}
end

return CutePetQualityUpShowViewPresentor
