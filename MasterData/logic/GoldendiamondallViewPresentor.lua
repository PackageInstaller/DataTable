-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goldendiamondcard/view/GoldendiamondallViewPresentor.lua

module("logic.extensions.goldendiamondcard.view.GoldendiamondallViewPresentor", package.seeall)

local GoldendiamondallViewPresentor = class("GoldendiamondallViewPresentor", ViewPresentor)

function GoldendiamondallViewPresentor:ctor()
	GoldendiamondallViewPresentor.super.ctor(self)
end

function GoldendiamondallViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function GoldendiamondallViewPresentor:dependWhatResources()
	return {
		"ui/views/goldendiamondcard/goldendiamondallview.prefab"
	}
end

function GoldendiamondallViewPresentor:buildViews()
	return {
		GoldendiamondallView.New()
	}
end

return GoldendiamondallViewPresentor
