-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/CutePetSelectSortViewPresentor.lua

module("logic.extensions.cutepet.view.CutePetSelectSortViewPresentor", package.seeall)

local CutePetSelectSortViewPresentor = class("CutePetSelectSortViewPresentor", ViewPresentor)

function CutePetSelectSortViewPresentor:ctor()
	CutePetSelectSortViewPresentor.super.ctor(self)
end

function CutePetSelectSortViewPresentor:attachToWhichRoot()
	return ViewRootType.Notify
end

function CutePetSelectSortViewPresentor:dependWhatResources()
	return {
		"ui/views/cutepet/cutepetsortview.prefab"
	}
end

function CutePetSelectSortViewPresentor:buildViews()
	return {
		CutePetSelectSortView.New()
	}
end

return CutePetSelectSortViewPresentor
