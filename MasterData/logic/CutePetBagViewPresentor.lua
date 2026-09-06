-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/CutePetBagViewPresentor.lua

module("logic.extensions.cutepet.view.CutePetBagViewPresentor", package.seeall)

local CutePetBagViewPresentor = class("CutePetBagViewPresentor", ViewWithGuidePresentor)

function CutePetBagViewPresentor:ctor()
	CutePetBagViewPresentor.super.ctor(self)
end

function CutePetBagViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CutePetBagViewPresentor:dependWhatResources()
	return {
		"ui/views/cutepet/cutepetbagview.prefab"
	}
end

function CutePetBagViewPresentor:buildViews()
	return {
		CutePetBagView.New()
	}
end

return CutePetBagViewPresentor
