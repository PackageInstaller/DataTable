-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/payshop/view/PayshopmoneycardViewPresentor.lua

module("logic.extensions.payshop.view.PayshopmoneycardViewPresentor", package.seeall)

local PayshopmoneycardViewPresentor = class("PayshopmoneycardViewPresentor", ViewPresentor)

function PayshopmoneycardViewPresentor:ctor()
	PayshopmoneycardViewPresentor.super.ctor(self)
end

function PayshopmoneycardViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PayshopmoneycardViewPresentor:dependWhatResources()
	return {
		"ui/views/payshop/payshopmoneycardview.prefab"
	}
end

function PayshopmoneycardViewPresentor:buildViews()
	return {
		PayshopmoneycardView.New()
	}
end

return PayshopmoneycardViewPresentor
