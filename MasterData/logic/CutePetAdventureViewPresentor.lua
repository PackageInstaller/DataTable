-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/adventure/CutePetAdventureViewPresentor.lua

module("logic.extensions.cutepet.view.CutePetAdventureViewPresentor", package.seeall)

local CutePetAdventureViewPresentor = class("CutePetAdventureViewPresentor", ViewPresentor)

function CutePetAdventureViewPresentor:ctor()
	CutePetAdventureViewPresentor.super.ctor(self)
end

function CutePetAdventureViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CutePetAdventureViewPresentor:dependWhatResources()
	return {
		"ui/views/cutepet/cutepetadventureview.prefab"
	}
end

function CutePetAdventureViewPresentor:buildViews()
	return {
		CutePetAdventureView.New()
	}
end

return CutePetAdventureViewPresentor
