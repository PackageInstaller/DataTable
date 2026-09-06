-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/vrspace/view/VrspacerankViewPresentor.lua

module("logic.extensions.vrspace.view.VrspacerankViewPresentor", package.seeall)

local VrspacerankViewPresentor = class("VrspacerankViewPresentor", ViewPresentor)

function VrspacerankViewPresentor:ctor()
	VrspacerankViewPresentor.super.ctor(self)
end

function VrspacerankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function VrspacerankViewPresentor:dependWhatResources()
	return {
		"ui/views/vrspace/vrspacerankview.prefab"
	}
end

function VrspacerankViewPresentor:buildViews()
	return {
		VrspacerankView.New()
	}
end

return VrspacerankViewPresentor
