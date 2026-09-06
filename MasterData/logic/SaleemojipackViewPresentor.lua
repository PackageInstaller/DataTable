-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/preheatsale/view/SaleemojipackViewPresentor.lua

module("logic.extensions.preheatsale.view.SaleemojipackViewPresentor", package.seeall)

local SaleemojipackViewPresentor = class("SaleemojipackViewPresentor", ViewPresentor)

function SaleemojipackViewPresentor:ctor()
	SaleemojipackViewPresentor.super.ctor(self)
end

function SaleemojipackViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SaleemojipackViewPresentor:dependWhatResources()
	return {
		"ui/views/preheatsale/saleemojipackview.prefab"
	}
end

function SaleemojipackViewPresentor:buildViews()
	return {
		SaleemojipackView.New()
	}
end

return SaleemojipackViewPresentor
