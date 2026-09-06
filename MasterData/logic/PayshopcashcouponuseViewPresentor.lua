-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/payshop/view/PayshopcashcouponuseViewPresentor.lua

module("logic.extensions.payshop.view.PayshopcashcouponuseViewPresentor", package.seeall)

local PayshopcashcouponuseViewPresentor = class("PayshopcashcouponuseViewPresentor", ViewPresentor)

function PayshopcashcouponuseViewPresentor:ctor()
	PayshopcashcouponuseViewPresentor.super.ctor(self)
end

function PayshopcashcouponuseViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PayshopcashcouponuseViewPresentor:dependWhatResources()
	return {
		"ui/views/payshop/payshopcashcouponuseview.prefab"
	}
end

function PayshopcashcouponuseViewPresentor:buildViews()
	return {
		PayshopcashcouponuseView.New()
	}
end

return PayshopcashcouponuseViewPresentor
