-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petverify/view/PvbufftipViewPresentor.lua

module("logic.extensions.petverify.view.PvbufftipViewPresentor", package.seeall)

local PvbufftipViewPresentor = class("PvbufftipViewPresentor", ViewPresentor)

function PvbufftipViewPresentor:ctor()
	PvbufftipViewPresentor.super.ctor(self)
end

function PvbufftipViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PvbufftipViewPresentor:dependWhatResources()
	return {
		"ui/views/petverify/pvbufftipview.prefab"
	}
end

function PvbufftipViewPresentor:buildViews()
	return {
		PvbufftipView.New()
	}
end

return PvbufftipViewPresentor
