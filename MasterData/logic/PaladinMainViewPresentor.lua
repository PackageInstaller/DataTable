-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/moonking/view/PaladinMainViewPresentor.lua

module("logic.extensions.moonking.view.PaladinMainViewPresentor", package.seeall)

local PaladinMainViewPresentor = class("PaladinMainViewPresentor", ViewWithGuidePresentor)

function PaladinMainViewPresentor:ctor()
	PaladinMainViewPresentor.super.ctor(self)
end

function PaladinMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PaladinMainViewPresentor:dependWhatResources()
	return {
		"ui/views/moonking/paladinmainview.prefab"
	}
end

function PaladinMainViewPresentor:buildViews()
	return {
		PaladinMainView.New()
	}
end

return PaladinMainViewPresentor
