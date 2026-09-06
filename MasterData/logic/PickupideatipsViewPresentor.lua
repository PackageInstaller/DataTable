-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pickupidea/view/PickupideatipsViewPresentor.lua

module("logic.extensions.pickupidea.view.PickupideatipsViewPresentor", package.seeall)

local PickupideatipsViewPresentor = class("PickupideatipsViewPresentor", ViewPresentor)

function PickupideatipsViewPresentor:ctor()
	PickupideatipsViewPresentor.super.ctor(self)
end

function PickupideatipsViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PickupideatipsViewPresentor:dependWhatResources()
	return {
		"ui/views/pickupidea/pickupideatipsview.prefab"
	}
end

function PickupideatipsViewPresentor:buildViews()
	return {
		PickupideatipsView.New()
	}
end

return PickupideatipsViewPresentor
