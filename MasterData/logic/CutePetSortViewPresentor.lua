-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/CutePetSortViewPresentor.lua

module("logic.extensions.cutepet.view.CutePetSortViewPresentor", package.seeall)

local CutePetSortViewPresentor = class("CutePetSortViewPresentor", ViewPresentor)

function CutePetSortViewPresentor:ctor()
	CutePetSortViewPresentor.super.ctor(self)
end

function CutePetSortViewPresentor:attachToWhichRoot()
	return ViewRootType.Notify
end

function CutePetSortViewPresentor:dependWhatResources()
	return {
		"ui/views/cutepet/cutepetsortview.prefab"
	}
end

function CutePetSortViewPresentor:buildViews()
	return {
		CutePetSortView.New()
	}
end

return CutePetSortViewPresentor
