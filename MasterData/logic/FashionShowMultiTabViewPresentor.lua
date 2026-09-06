-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dressactivityshop/view/FashionShowMultiTabViewPresentor.lua

module("logic.extensions.dressactivityshop.view.FashionShowMultiTabViewPresentor", package.seeall)

local FashionShowMultiTabViewPresentor = class("FashionShowMultiTabViewPresentor", ViewPresentor)

function FashionShowMultiTabViewPresentor:ctor()
	FashionShowMultiTabViewPresentor.super.ctor(self)
end

function FashionShowMultiTabViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FashionShowMultiTabViewPresentor:dependWhatResources()
	return {
		"ui/views/multicommoditysale/fashionshowmultitabview.prefab"
	}
end

function FashionShowMultiTabViewPresentor:buildViews()
	return {
		FashionShowMultiTabView.New()
	}
end

return FashionShowMultiTabViewPresentor
