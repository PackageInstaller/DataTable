-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fusionsoul/view/FusionSoulCombineViewPresentor.lua

module("logic.extensions.fusionsoul.view.FusionSoulCombineViewPresentor", package.seeall)

local FusionSoulCombineViewPresentor = class("FusionSoulCombineViewPresentor", ViewPresentor)

function FusionSoulCombineViewPresentor:ctor()
	FusionSoulCombineViewPresentor.super.ctor(self)
end

function FusionSoulCombineViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FusionSoulCombineViewPresentor:dependWhatResources()
	return {
		"ui/views/fusionsoul/fusionsoulcombineview.prefab"
	}
end

function FusionSoulCombineViewPresentor:buildViews()
	return {
		FusionSoulCombineView.New()
	}
end

return FusionSoulCombineViewPresentor
