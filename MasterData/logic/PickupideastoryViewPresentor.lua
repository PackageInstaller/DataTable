-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pickupidea/view/PickupideastoryViewPresentor.lua

module("logic.extensions.pickupidea.view.PickupideastoryViewPresentor", package.seeall)

local PickupideastoryViewPresentor = class("PickupideastoryViewPresentor", ViewPresentor)

function PickupideastoryViewPresentor:ctor()
	PickupideastoryViewPresentor.super.ctor(self)
end

function PickupideastoryViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PickupideastoryViewPresentor:dependWhatResources()
	return {
		"ui/views/pickupidea/pickupideastoryview.prefab"
	}
end

function PickupideastoryViewPresentor:buildViews()
	return {
		PickupideastoryView.New()
	}
end

return PickupideastoryViewPresentor
