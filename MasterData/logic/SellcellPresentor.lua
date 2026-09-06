-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shop/view/SellcellPresentor.lua

module("logic.extensions.shop.view.SellcellPresentor", package.seeall)

local SellcellPresentor = class("SellcellPresentor", ViewPresentor)

function SellcellPresentor:ctor()
	SellcellPresentor.super.ctor(self)
end

function SellcellPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SellcellPresentor:dependWhatResources()
	return {
		"ui/views/shop/sellcell.prefab"
	}
end

function SellcellPresentor:buildViews()
	return {
		SellcellView.New()
	}
end

return SellcellPresentor
