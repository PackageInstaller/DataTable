-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originage/view/OriginageshowViewPresentor.lua

module("logic.extensions.originage.view.OriginageshowViewPresentor", package.seeall)

local OriginageshowViewPresentor = class("OriginageshowViewPresentor", ViewPresentor)

function OriginageshowViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginageshowViewPresentor:dependWhatResources()
	return {
		"ui/views/originage/originageshowview.prefab"
	}
end

function OriginageshowViewPresentor:buildViews()
	return {
		OriginageshowView.New()
	}
end

return OriginageshowViewPresentor
