-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tutorsystem/view/lease/LeasePetSelectViewPresentor.lua

module("logic.extensions.tutorsystem.view.lease.LeasePetSelectViewPresentor", package.seeall)

local LeasePetSelectViewPresentor = class("LeasePetSelectViewPresentor", ViewPresentor)

function LeasePetSelectViewPresentor:ctor()
	LeasePetSelectViewPresentor.super.ctor(self)
end

function LeasePetSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LeasePetSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/tutorsystem/leasepetselectview.prefab"
	}
end

function LeasePetSelectViewPresentor:buildViews()
	return {
		LeasePetSelectView.New()
	}
end

return LeasePetSelectViewPresentor
