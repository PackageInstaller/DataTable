-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/CutePetPresetSelectViewPresentor.lua

module("logic.extensions.cutepet.view.CutePetPresetSelectViewPresentor", package.seeall)

local CutePetPresetSelectViewPresentor = class("CutePetPresetSelectViewPresentor", ViewPresentor)

function CutePetPresetSelectViewPresentor:ctor()
	CutePetPresetSelectViewPresentor.super.ctor(self)
end

function CutePetPresetSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CutePetPresetSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/cutepet/cutepetpresetselectview.prefab"
	}
end

function CutePetPresetSelectViewPresentor:buildViews()
	return {
		CutePetPresetSelectView.New()
	}
end

return CutePetPresetSelectViewPresentor
