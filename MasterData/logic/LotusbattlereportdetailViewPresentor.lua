-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lotusbattle/view/LotusbattlereportdetailViewPresentor.lua

module("logic.extensions.lotusbattle.view.LotusbattlereportdetailViewPresentor", package.seeall)

local LotusbattlereportdetailViewPresentor = class("LotusbattlereportdetailViewPresentor", ViewPresentor)

function LotusbattlereportdetailViewPresentor:ctor()
	LotusbattlereportdetailViewPresentor.super.ctor(self)
end

function LotusbattlereportdetailViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function LotusbattlereportdetailViewPresentor:dependWhatResources()
	return {
		"ui/views/lotusbattle/lotusbattlereportdetailview.prefab"
	}
end

function LotusbattlereportdetailViewPresentor:buildViews()
	return {
		LotusbattlereportdetailView.New()
	}
end

return LotusbattlereportdetailViewPresentor
