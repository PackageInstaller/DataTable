-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/itembag/view/RewarmultidselectViewPresentor.lua

module("logic.extensions.itembag.view.RewarmultidselectViewPresentor", package.seeall)

local RewarmultidselectViewPresentor = class("RewarmultidselectViewPresentor", ViewPresentor)

function RewarmultidselectViewPresentor:ctor()
	RewarmultidselectViewPresentor.super.ctor(self)
end

function RewarmultidselectViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function RewarmultidselectViewPresentor:dependWhatResources()
	return {
		"ui/views/itembag/rewarmultidselectview.prefab"
	}
end

function RewarmultidselectViewPresentor:buildViews()
	return {
		RewarmultidselectView.New()
	}
end

return RewarmultidselectViewPresentor
