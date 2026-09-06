-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/strength/view/SupplyPresentor.lua

module("logic.extensions.strength.view.SupplyPresentor", package.seeall)

local SupplyPresentor = class("SupplyPresentor", ViewPresentor)

function SupplyPresentor:ctor()
	SupplyPresentor.super.ctor(self)
end

function SupplyPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SupplyPresentor:dependWhatResources()
	return {
		"ui/views/strength/supplyview.prefab"
	}
end

function SupplyPresentor:buildViews()
	return {
		SupplyView.New()
	}
end

return SupplyPresentor
