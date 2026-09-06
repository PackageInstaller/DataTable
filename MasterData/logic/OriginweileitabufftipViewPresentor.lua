-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originweileita/view/OriginweileitabufftipViewPresentor.lua

module("logic.extensions.originweileita.view.OriginweileitabufftipViewPresentor", package.seeall)

local OriginweileitabufftipViewPresentor = class("OriginweileitabufftipViewPresentor", ViewPresentor)

function OriginweileitabufftipViewPresentor:ctor()
	OriginweileitabufftipViewPresentor.super.ctor(self)
end

function OriginweileitabufftipViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginweileitabufftipViewPresentor:dependWhatResources()
	return {
		"ui/views/originweileita/originweileitabufftipview.prefab"
	}
end

function OriginweileitabufftipViewPresentor:buildViews()
	return {
		OriginweileitabufftipView.New()
	}
end

return OriginweileitabufftipViewPresentor
