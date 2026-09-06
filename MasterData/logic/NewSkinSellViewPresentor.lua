-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firstcharge/view/NewSkinSellViewPresentor.lua

module("logic.extensions.firstcharge.view.NewSkinSellViewPresentor", package.seeall)

local NewSkinSellViewPresentor = class("NewSkinSellViewPresentor", ViewPresentor)

function NewSkinSellViewPresentor:ctor()
	NewSkinSellViewPresentor.super.ctor(self)
end

function NewSkinSellViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NewSkinSellViewPresentor:dependWhatResources()
	return {
		"ui/views/firstcharge/petskindirectsaleview.prefab"
	}
end

function NewSkinSellViewPresentor:buildViews()
	return {
		NewSkinSellView.New()
	}
end

return NewSkinSellViewPresentor
