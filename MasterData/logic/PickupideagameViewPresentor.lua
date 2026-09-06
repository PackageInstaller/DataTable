-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pickupidea/view/PickupideagameViewPresentor.lua

module("logic.extensions.pickupidea.view.PickupideagameViewPresentor", package.seeall)

local PickupideagameViewPresentor = class("PickupideagameViewPresentor", ViewPresentor)

function PickupideagameViewPresentor:ctor()
	PickupideagameViewPresentor.super.ctor(self)
end

function PickupideagameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PickupideagameViewPresentor:dependWhatResources()
	return {
		"ui/views/pickupidea/pickupideagameview.prefab"
	}
end

function PickupideagameViewPresentor:buildViews()
	return {
		PickupideagameView.New()
	}
end

return PickupideagameViewPresentor
