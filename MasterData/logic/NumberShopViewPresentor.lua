-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/numberbomb/view/NumberShopViewPresentor.lua

module("logic.extensions.numberbomb.view.NumberShopViewPresentor", package.seeall)

local NumberShopViewPresentor = class("NumberShopViewPresentor", ViewWithGuidePresentor)

function NumberShopViewPresentor:ctor()
	NumberShopViewPresentor.super.ctor(self)
end

function NumberShopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NumberShopViewPresentor:dependWhatResources()
	return {
		"ui/views/numberbomb/numbershopview.prefab"
	}
end

function NumberShopViewPresentor:buildViews()
	return {
		NumberShopView.New()
	}
end

return NumberShopViewPresentor
