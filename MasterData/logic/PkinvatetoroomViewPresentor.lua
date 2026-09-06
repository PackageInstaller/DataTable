-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pk/view/PkinvatetoroomViewPresentor.lua

module("logic.extensions.pk.view.PkinvatetoroomViewPresentor", package.seeall)

local PkinvatetoroomViewPresentor = class("PkinvatetoroomViewPresentor", ViewPresentor)

function PkinvatetoroomViewPresentor:ctor()
	PkinvatetoroomViewPresentor.super.ctor(self)
end

function PkinvatetoroomViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PkinvatetoroomViewPresentor:dependWhatResources()
	return {
		"ui/views/pk/pkinvatetoroomview.prefab"
	}
end

function PkinvatetoroomViewPresentor:buildViews()
	return {
		PkinvatetoroomView.New()
	}
end

return PkinvatetoroomViewPresentor
