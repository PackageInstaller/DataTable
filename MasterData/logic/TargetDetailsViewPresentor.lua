-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/powerland/view/TargetDetailsViewPresentor.lua

module("logic.extensions.powerland.view.TargetDetailsViewPresentor", package.seeall)

local TargetDetailsViewPresentor = class("TargetDetailsViewPresentor", ViewPresentor)

function TargetDetailsViewPresentor:ctor()
	TargetDetailsViewPresentor.super.ctor(self)
end

function TargetDetailsViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function TargetDetailsViewPresentor:dependWhatResources()
	return {
		"ui/views/powerland/targetdetailsview.prefab"
	}
end

function TargetDetailsViewPresentor:buildViews()
	return {
		TargetDetailsView.New()
	}
end

return TargetDetailsViewPresentor
