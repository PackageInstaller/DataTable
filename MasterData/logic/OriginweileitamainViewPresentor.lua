-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originweileita/view/OriginweileitamainViewPresentor.lua

module("logic.extensions.originweileita.view.OriginweileitamainViewPresentor", package.seeall)

local OriginweileitamainViewPresentor = class("OriginweileitamainViewPresentor", ViewPresentor)

function OriginweileitamainViewPresentor:ctor()
	OriginweileitamainViewPresentor.super.ctor(self)
end

function OriginweileitamainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginweileitamainViewPresentor:dependWhatResources()
	return {
		"ui/views/originweileita/originweileitamainview.prefab"
	}
end

function OriginweileitamainViewPresentor:buildViews()
	return {
		OriginweileitamainView.New()
	}
end

return OriginweileitamainViewPresentor
