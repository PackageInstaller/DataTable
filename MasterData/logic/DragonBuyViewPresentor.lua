-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/DragonBuyViewPresentor.lua

module("logic.extensions.lottery.view.DragonBuyViewPresentor", package.seeall)

local DragonBuyViewPresentor = class("DragonBuyViewPresentor", ViewPresentor)

function DragonBuyViewPresentor:ctor()
	DragonBuyViewPresentor.super.ctor(self)
end

function DragonBuyViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DragonBuyViewPresentor:dependWhatResources()
	return {
		"ui/views/lottery/dragonbuyview.prefab"
	}
end

function DragonBuyViewPresentor:buildViews()
	return {
		DragonBuyView.New()
	}
end

return DragonBuyViewPresentor
