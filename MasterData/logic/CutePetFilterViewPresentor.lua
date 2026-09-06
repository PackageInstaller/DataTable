-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/CutePetFilterViewPresentor.lua

module("logic.extensions.cutepet.view.CutePetFilterViewPresentor", package.seeall)

local CutePetFilterViewPresentor = class("CutePetFilterViewPresentor", ViewPresentor)

function CutePetFilterViewPresentor:ctor()
	CutePetFilterViewPresentor.super.ctor(self)
end

function CutePetFilterViewPresentor:attachToWhichRoot()
	return ViewRootType.Notify
end

function CutePetFilterViewPresentor:dependWhatResources()
	return {
		"ui/views/cutepet/cutepetfilterview.prefab"
	}
end

function CutePetFilterViewPresentor:buildViews()
	return {
		CutePetFilterView.New()
	}
end

return CutePetFilterViewPresentor
