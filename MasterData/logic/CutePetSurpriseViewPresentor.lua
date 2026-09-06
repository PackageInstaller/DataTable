-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/travel/CutePetSurpriseViewPresentor.lua

module("logic.extensions.cutepet.view.CutePetSurpriseViewPresentor", package.seeall)

local CutePetSurpriseViewPresentor = class("CutePetSurpriseViewPresentor", ViewPresentor)

function CutePetSurpriseViewPresentor:ctor()
	CutePetSurpriseViewPresentor.super.ctor(self)
end

function CutePetSurpriseViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CutePetSurpriseViewPresentor:dependWhatResources()
	return {
		"ui/views/cutepet/cutepetsurprisedview.prefab"
	}
end

function CutePetSurpriseViewPresentor:buildViews()
	return {
		CutePetSurpriseView.New()
	}
end

function CutePetSurpriseViewPresentor:onClickOutside()
	self:close()
end

return CutePetSurpriseViewPresentor
