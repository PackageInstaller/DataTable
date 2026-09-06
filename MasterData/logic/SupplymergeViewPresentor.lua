-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/strength/view/SupplymergeViewPresentor.lua

module("logic.extensions.strength.view.SupplymergeViewPresentor", package.seeall)

local SupplymergeViewPresentor = class("SupplymergeViewPresentor", ViewPresentor)

function SupplymergeViewPresentor:ctor()
	SupplymergeViewPresentor.super.ctor(self)
end

function SupplymergeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SupplymergeViewPresentor:dependWhatResources()
	return {
		"ui/views/strength/supplymergeview.prefab"
	}
end

function SupplymergeViewPresentor:buildViews()
	return {
		SupplymergeView.New()
	}
end

return SupplymergeViewPresentor
