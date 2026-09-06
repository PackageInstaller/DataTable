-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goldendiamondcard/view/GoldendiamondcardViewPresentor.lua

module("logic.extensions.goldendiamondcard.view.GoldendiamondcardViewPresentor", package.seeall)

local GoldendiamondcardViewPresentor = class("GoldendiamondcardViewPresentor", ViewPresentor)

function GoldendiamondcardViewPresentor:ctor()
	GoldendiamondcardViewPresentor.super.ctor(self)
end

function GoldendiamondcardViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoldendiamondcardViewPresentor:dependWhatResources()
	return {
		"ui/views/goldendiamondcard/goldendiamondcardview.prefab"
	}
end

function GoldendiamondcardViewPresentor:buildViews()
	return {
		GoldendiamondcardView.New()
	}
end

return GoldendiamondcardViewPresentor
