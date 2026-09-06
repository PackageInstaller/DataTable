-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firstcharge/view/newskinwithsource/NewSkinSellWithSourceViewPresentor.lua

module("logic.extensions.firstcharge.view.newskinwithsource.NewSkinSellWithSourceViewPresentor", package.seeall)

local NewSkinSellWithSourceViewPresentor = class("NewSkinSellWithSourceViewPresentor", ViewPresentor)

function NewSkinSellWithSourceViewPresentor:ctor()
	NewSkinSellWithSourceViewPresentor.super.ctor(self)
end

function NewSkinSellWithSourceViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NewSkinSellWithSourceViewPresentor:dependWhatResources()
	return {
		"ui/views/firstcharge/newskinsellwithsourceview.prefab"
	}
end

function NewSkinSellWithSourceViewPresentor:buildViews()
	return {
		NewSkinSellWithSourceView.New()
	}
end

return NewSkinSellWithSourceViewPresentor
