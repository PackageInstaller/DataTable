-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/farnas/view/FarnasnordetailViewPresentor.lua

module("logic.extensions.farnas.view.FarnasnordetailViewPresentor", package.seeall)

local FarnasnordetailViewPresentor = class("FarnasnordetailViewPresentor", ViewPresentor)

function FarnasnordetailViewPresentor:ctor()
	FarnasnordetailViewPresentor.super.ctor(self)
end

function FarnasnordetailViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FarnasnordetailViewPresentor:dependWhatResources()
	return {
		"ui/views/farnas/farnasnordetailview.prefab"
	}
end

function FarnasnordetailViewPresentor:buildViews()
	return {
		FarnasnordetailView.New()
	}
end

return FarnasnordetailViewPresentor
