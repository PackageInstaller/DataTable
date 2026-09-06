-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pickupidea/view/PickupideamainViewPresentor.lua

module("logic.extensions.pickupidea.view.PickupideamainViewPresentor", package.seeall)

local PickupideamainViewPresentor = class("PickupideamainViewPresentor", ViewPresentor)

function PickupideamainViewPresentor:ctor()
	PickupideamainViewPresentor.super.ctor(self)
end

function PickupideamainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PickupideamainViewPresentor:dependWhatResources()
	return {
		"ui/views/pickupidea/pickupideamainview.prefab"
	}
end

function PickupideamainViewPresentor:buildViews()
	return {
		PickupideamainView.New()
	}
end

return PickupideamainViewPresentor
