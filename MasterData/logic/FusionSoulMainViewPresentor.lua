-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fusionsoul/view/FusionSoulMainViewPresentor.lua

module("logic.extensions.fusionsoul.view.FusionSoulMainViewPresentor", package.seeall)

local FusionSoulMainViewPresentor = class("FusionSoulMainViewPresentor", ViewPresentor)

function FusionSoulMainViewPresentor:ctor()
	FusionSoulMainViewPresentor.super.ctor(self)
end

function FusionSoulMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FusionSoulMainViewPresentor:dependWhatResources()
	return {
		"ui/views/fusionsoul/fusionsoulmainview.prefab"
	}
end

function FusionSoulMainViewPresentor:buildViews()
	return {
		FusionSoulMainView.New()
	}
end

return FusionSoulMainViewPresentor
