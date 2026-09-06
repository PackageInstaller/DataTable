-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fusionsoul/view/FusionSoulDispatchViewPresentor.lua

module("logic.extensions.fusionsoul.view.FusionSoulDispatchViewPresentor", package.seeall)

local FusionSoulDispatchViewPresentor = class("FusionSoulDispatchViewPresentor", ViewPresentor)

function FusionSoulDispatchViewPresentor:ctor()
	FusionSoulDispatchViewPresentor.super.ctor(self)
end

function FusionSoulDispatchViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FusionSoulDispatchViewPresentor:dependWhatResources()
	return {
		"ui/views/fusionsoul/fusionsouldispatchview.prefab"
	}
end

function FusionSoulDispatchViewPresentor:buildViews()
	return {
		FusionSoulDispatchView.New()
	}
end

return FusionSoulDispatchViewPresentor
