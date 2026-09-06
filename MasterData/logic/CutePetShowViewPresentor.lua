-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/showInfo/CutePetShowViewPresentor.lua

module("logic.extensions.cutepet.view.CutePetShowViewPresentor", package.seeall)

local CutePetShowViewPresentor = class("CutePetShowViewPresentor", ViewPresentor)

function CutePetShowViewPresentor:ctor()
	CutePetShowViewPresentor.super.ctor(self)
end

function CutePetShowViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CutePetShowViewPresentor:dependWhatResources()
	return {
		"ui/views/cutepet/cutepetshowview.prefab"
	}
end

function CutePetShowViewPresentor:buildViews()
	return {
		CutePetShowView.New()
	}
end

return CutePetShowViewPresentor
