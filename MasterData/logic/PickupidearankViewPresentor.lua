-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pickupidea/view/PickupidearankViewPresentor.lua

module("logic.extensions.pickupidea.view.PickupidearankViewPresentor", package.seeall)

local PickupidearankViewPresentor = class("PickupidearankViewPresentor", ViewPresentor)

function PickupidearankViewPresentor:ctor()
	PickupidearankViewPresentor.super.ctor(self)
end

function PickupidearankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PickupidearankViewPresentor:dependWhatResources()
	return {
		"ui/views/pickupidea/pickupidearankview.prefab"
	}
end

function PickupidearankViewPresentor:buildViews()
	return {
		PickupidearankView.New()
	}
end

return PickupidearankViewPresentor
